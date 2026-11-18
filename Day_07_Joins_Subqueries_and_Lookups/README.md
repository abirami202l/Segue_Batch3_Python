# Day 07 – Joins, Subqueries and `$lookup` (SQL Server + MongoDB)

Three business case studies solved twice: once in **SQL Server (T-SQL)** and once in **MongoDB (mongosh)**.
Every script creates its own database, loads sample data and then runs the queries, so each file can be run on its own.

## Folder structure

```
Day_07_Normalisation_and_Data_Joins/
├── README.md
├── SQL_Server/
│   ├── Set1_Logistics_Shipment_Analysis.sql
│   ├── Set2_Bank_Loan_Portfolio.sql
│   └── Set3_Retail_Returns_Refunds.sql
└── MongoDB/
    ├── Set1_Logistics_Shipment_Analysis.js
    ├── Set2_Bank_Loan_Portfolio.js
    └── Set3_Retail_Returns_Refunds.js
```

## How to run

| Platform | Steps |
|---|---|
| SQL Server | Open the `.sql` file in SSMS or Azure Data Studio and run it top to bottom. It creates `LogisticsDB`, `BankLoanDB` or `RetailReturnsDB`. In Set 2, run the query section (after the last `GO`) as **one batch**, because it uses a `@AsOf` variable. |
| MongoDB | `mongosh --file MongoDB/Set1_Logistics_Shipment_Analysis.js` (same for the other sets). Needs MongoDB **5.0+** for `$dateDiff` and `$setWindowFields`. Each script drops and recreates its own database and prints every pipeline's result. |

Reporting date used in Set 2 (both SQL and MongoDB): **2026-11-18**.

---

## Set 1 – Logistics Shipment Analysis

**Tables / collections:** Hubs, Carriers, Customers, Employees (self-referencing supervisor), Shipments, DeliveryEvents.

### Join choice per question

| # | Question | Join | Why this join |
|---|---|---|---|
| 1 | Shipments delayed > 2 days with carrier names | INNER | Only shipments that have a carrier, customer and delivery date matter. |
| 2 | Customers with shipment count and spend | LEFT | Customers drive the report; customers with no shipments must show 0. |
| 3 | Hubs with no outbound shipments | LEFT + `IS NULL` | Anti-join: keep every hub, then filter to those with no match. |
| 4 | Employees with supervisors | SELF (LEFT) | Same table twice; LEFT keeps the top employee who has no supervisor. |
| 5 | Outbound vs inbound counts per hub | FULL OUTER | Two independent summaries; a hub can appear in only one (Kolkata is inbound only). |
| 6 | Shipment routes (origin → destination) | INNER (Hubs joined twice) | Every shipment must have both an origin and a destination. |
| 7 | Tracking events per shipment | LEFT | Shipments with no events must not disappear. |
| 8 | Carrier performance (average delay) | INNER | A carrier with no delivered shipments has no delay to report. |
| 9 | Employees sharing a supervisor | SELF (INNER) | Pair rows; `e1.EmployeeID < e2.EmployeeID` removes mirror duplicates. |
| 10 | Headcount per hub | LEFT | Hubs with no staff must still show 0. |

### Subquery choices

| Question | Form | Reason |
|---|---|---|
| Customers who used a given carrier | `IN` | A plain list of ids is enough; no row-by-row check needed. |
| Customers with a delayed shipment | `EXISTS` | Existence check, stops at the first match, no duplicates. |
| Costlier than *any* / *all* shipments of a customer | `ANY` / `ALL` | Compare against the minimum / maximum of a list without writing MIN or MAX. |
| Customers who shipped to **every** hub | double `NOT EXISTS` | Relational division: "no hub exists for which the customer has no shipment". |
| Carriers above the overall average delay | scalar subquery in `HAVING` | Compares a group aggregate with a single overall value. |

**Subquery → join rewrites (Task 3)**

- *EXISTS → INNER JOIN + DISTINCT:* the `EXISTS` form is **more readable**; it reads like the question and needs no `DISTINCT`. The join multiplies rows and the `DISTINCT` is easy to forget.
- *HAVING subquery → CTE + join:* the **join/CTE form is more readable**; it names each step and can show the overall average next to each carrier, which the `HAVING` version cannot.

**Nested subquery (Task 4):** the second-highest cost per hub is found by taking `MAX(cost)` among shipments strictly below that hub's `MAX(cost)`.

**MongoDB pipelines:** (1) shipments + deliveryEvents, (2) customers + shipments (totals, hubs reached), (3) carriers + delay statistics, using a `$lookup` sub-pipeline with `$dateDiff`.

### Embedding vs `$lookup`

- **Embed** when the child is read together with the parent, belongs to only one parent and is small and bounded (a shipment's tracking events). It needs one read and no join, and updates stay atomic.
- **Use `$lookup`** when the data is shared by many parents (carriers, hubs), grows without limit, is queried on its own, or is used for cross-collection analytics (carrier delay statistics). Index the foreign field.

---

## Set 2 – Bank Loan Portfolio

**Tables / collections:** Branches, Customers, Loans, Repayments (one row per instalment paid), Guarantees (guarantor → loan).
Instalments due = months since the start date (capped at the tenure). Overdue = due − paid.

### Join choice per question

| # | Question | Join | Why this join |
|---|---|---|---|
| 1 | Loans overdue by more than 3 instalments | INNER + LEFT | INNER for customer and branch; LEFT for repayments so a loan with zero payments still counts as overdue. |
| 2 | Customers with loans in more than one branch | INNER | Only customers who hold loans can qualify; `COUNT(DISTINCT BranchID) > 1`. |
| 3 | Guarantors who are also borrowers | SELF (Customers ↔ Customers) | The same table plays guarantor and borrower, linked through Guarantees and Loans. |
| 4 | Branches with no loans | LEFT + `IS NULL` | Anti-join. |
| 5 | Customers with total exposure | LEFT | A customer with no loan must show 0. |
| 6 | Borrower only / guarantor only / both | FULL OUTER | Borrowers and guarantors are two sets, and people can be on one side only. |
| 7 | Loans with repayments made and total repaid | LEFT | Loans never repaid must remain. |
| 8 | Branch portfolio summary | LEFT | Branches drive the report; empty branches show 0. |
| 9 | Guaranteed loans with borrower, guarantor, branch | INNER | A loan with no guarantor is outside the question. |
| 10 | Collections per branch in the last 60 days | INNER | Only branches that collected something appear. |

### Subquery choices

| Question | Form | Reason |
|---|---|---|
| Exposure above the **branch** average | **correlated** subquery | The average depends on each row's branch, so the inner query refers to the outer row. |
| Exposure above the **bank-wide** average | **uncorrelated** subquery | One average for everyone, calculated once. |
| Loan but no repayment in 60 days | `EXISTS` + `NOT EXISTS` | Pure existence tests. `NOT EXISTS` is safe with NULLs. |
| Branches whose highest loan > average of branch maximums | nested subquery (average of per-branch `MAX`) | Needs an aggregate of an aggregate. |

**MongoDB pipelines:** (1) loans + customers + repayments with an overdue calculation, (2) customers + loans (exposure, branches), (3) **last repayment per loan** using a `$lookup` sub-pipeline (`$sort` + `$limit: 1`).

**Embedding decision:** guarantor ids are embedded in the loan (tiny and always read with it). Repayments stay in their own collection because they grow every month and are queried independently.

---

## Set 3 – Retail Returns and Refunds

**Tables / collections:** Stores, Customers, Products, Employees (self-referencing manager), Sales, Returns, Refunds (SQL) / refund embedded in returns plus `returnFeedback` (MongoDB).

### Join choice per question

| # | Question | Join | Why this join |
|---|---|---|---|
| 1 | Products with return rate > 10% | INNER + LEFT (with CTEs) | LEFT to returns so unreturned products get rate 0. Sold and returned units are summed in CTEs first so joins do not multiply the quantities. |
| 2 | Returns with no refund | LEFT + `IS NULL` | Anti-join on Refunds. |
| 3 | Stores with the highest refund value | LEFT (inside `vw_StoreRefund`) | Keeps stores with no refunds; `TOP 1 WITH TIES` handles a tie. |
| 4 | Employees and managers | SELF (LEFT) | The head-office employee has no manager. |
| 5 | Stores with no staff / staff with no store | FULL OUTER | The problem exists on both sides at once. |
| 6 | Products never returned | LEFT + `HAVING COUNT = 0` | Grouped anti-join. |
| 7 | Return register with refund status | INNER chain + LEFT | The chain Return → Sale → Product → Store is mandatory; the refund is optional. |
| 8 | Returns by reason with refund value | LEFT | Unrefunded returns must still be counted. |
| 9 | Customers with more than one return | INNER | Walk-ins and customers with no returns cannot qualify. |
| 10 | Sales lines never returned | LEFT + `IS NULL` | Anti-join. |

### `NOT IN` and the NULL pitfall (Task 2)

The sale made by a walk-in customer has `CustomerID = NULL`, so the subquery list contains a `NULL`.

```sql
-- returns 0 rows (wrong): x NOT IN (1,2,3,NULL)  =>  x<>1 AND x<>2 AND x<>3 AND x<>NULL  => UNKNOWN
SELECT CustName FROM Customers
WHERE CustomerID NOT IN (SELECT s.CustomerID FROM Returns r JOIN Sales s ON s.SaleID = r.SaleID);

-- correct: returns Farhan
SELECT c.CustName FROM Customers c
WHERE NOT EXISTS (SELECT 1 FROM Returns r JOIN Sales s ON s.SaleID = r.SaleID
                  WHERE s.CustomerID = c.CustomerID);
```

Use `NOT EXISTS` whenever the subquery column can be NULL. A second fix, adding `WHERE s.CustomerID IS NOT NULL` inside the list, is also in the script.

### `ANY` / `ALL` within a region (Task 3)

- `> ALL (other stores in the region)` returns stores that beat **every** peer: Chennai Central, Mumbai Andheri, Delhi Saket.
- `> ANY (...)` returns stores that beat **at least one** peer: Chennai Central, Coimbatore Mall, Mumbai Andheri.
- Delhi Saket is the only North store. `ALL` over an empty set is TRUE, so it appears in the first result. `ANY` over an empty set is FALSE, so it is absent from the second.

### Nested subqueries with results (Task 4)

| Query | Result |
|---|---|
| Products whose returned quantity is above the average (2.20) | Wireless Headphones (4), Smartwatch (3) |
| Customers whose total refund is above the average (6,425) | Anitha (14,000), Bharath (8,000) |

### MongoDB pipelines and comparison with the SQL joins

Pipelines: (1) returns + feedback, (2) products with return rate and average rating, (3) stores with refunds, feedback and a rank inside their region.

| Need | SQL Server | MongoDB |
|---|---|---|
| Keep unmatched rows | `LEFT JOIN` | `$lookup` + `$unwind` with `preserveNullAndEmptyArrays` |
| Drop unmatched rows | `INNER JOIN` | `$lookup` + `$unwind` |
| Refund of a return | `Refunds` table + `LEFT JOIN` | embedded sub-document, no join |
| Multi-table chain | 3–4 `JOIN`s in one query | one `$lookup` stage per hop |
| Compare with peers in a region | self-join / `ANY` / `ALL` | `$setWindowFields` with `$rank` |
| Integrity | foreign keys | enforced by the application |

SQL Server is stronger for ad-hoc, many-table, set-based questions. MongoDB is stronger when one read matches one document shape, and `$lookup` is best kept for genuinely separate data.

---

## Notes

- Expected results are written as comments under each query so the output can be checked after running.
- The sample data is small and hand-designed so every query returns something meaningful (an empty branch, an unrefunded return, a NULL walk-in, a customer who shipped to every hub, and so on).
- The root folder name is a guess because the screenshot cut it off. Rename it to match your actual folder.

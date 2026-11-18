# Day 6: Functions, Aggregation, Grouping, and Joins

Practice repository for SQL Server and MongoDB reporting queries. The
examples cover built-in functions, aggregation, `GROUP BY`, filtering,
`JOIN` and `$lookup`, date calculations, category sharing, and `NULL`
handling across retail, insurance, and telecom datasets.

## Repository structure

```text
.
|-- SQL_server/
|   |-- Set1_Retail_Sales.sql
|   |-- Set2_Insurance_Reporting.sql
|   `-- Set3_Telecom_Reporting.sql
`-- MongoDB/
    |-- Set1_Retail_Sales.js
    |-- Set2_Insurance_Reporting.js
    `-- Set3_Telecom_Reporting.sql
```

> Note: `MongoDB/Set3_Telecom_Reporting.sql` contains MongoDB JavaScript
> and should be run in `mongosh`, even though its current extension is
> `.sql`.

## SQL Server exercises

Open a file in SQL Server Management Studio (SSMS), Azure Data Studio, or
another SQL Server client and run it in order.

| File | Dataset | Main topics |
|---|---|---|
| [Set1_Retail_Sales.sql](SQL_server/Set1_Retail_Sales.sql) | Customers, products, orders, items, and payments | Revenue, monthly sales, HAVING, basket value, anti-joins, percentages, string/date functions |
| [Set2_Insurance_Reporting.sql](SQL_server/Set2_Insurance_Reporting.sql) | Customers, policies, agents, premiums, and claims | Expiry dates, premium totals, claim ratios, age bands, overdue calculations |
| [Set3_Telecom_Reporting.sql](SQL_server/Set3_Telecom_Reporting.sql) | Plans, subscribers, usage, and invoices | Usage limits, revenue, ARPU, overdue invoices, NULL behavior |

Each SQL script creates and populates its tables, then runs the reporting
queries. Fixed reference dates are used where noted so that date-based
results remain reproducible.

## MongoDB exercises

Run the JavaScript files from `mongosh`:

```javascript
load("/absolute/path/to/MongoDB/Set1_Retail_Sales.js")
load("/absolute/path/to/MongoDB/Set2_Insurance_Reporting.js")
load("/absolute/path/to/MongoDB/Set3_Telecom_Reporting.sql")
```

On Windows, use a valid absolute path with forward slashes or escape
backslashes. For example:

```javascript
load("C:/Users/Lenovo/OneDrive/Desktop/Day_6_Functions_Aggregation_Grouping_and_Joins/MongoDB/Set1_Retail_Sales.js")
```

| File | Dataset | Main topics |
|---|---|---|
| [Set1_Retail_Sales.js](MongoDB/Set1_Retail_Sales.js) | Retail collections | `$lookup`, `$unwind`, `$group`, `$sum`, `$avg`, sorting, limits |
| [Set2_Insurance_Reporting.js](MongoDB/Set2_Insurance_Reporting.js) | Retail collections | Additional retail aggregation examples using customers, products, orders, items, and payments |
| [Set3_Telecom_Reporting.sql](MongoDB/Set3_Telecom_Reporting.sql) | Telecom usage events | Hourly usage, average session length, busiest cell tower |

The retail scripts use separate MongoDB collections for customers,
products, orders, order items, and payments. The telecom script uses a
`usage_events` collection and prints aggregation results with `printjson`.

## Concepts practiced

- Aggregate functions: `SUM`, `COUNT`, `AVG`, `MIN`, and `MAX`
- Grouping and filtering: `GROUP BY`, `HAVING`, `$group`, and `$match`
- Cross-table reporting: SQL `JOIN` and MongoDB `$lookup`
- Inner, left, and anti-joins
- Date and string functions
- Calculated fields and ratios
- Category or month-based reporting
- Top-N queries
- `NULL` handling with `ISNULL`, `$ifNull`, `COALESCE`, and aggregation
- SQL-to-MongoDB aggregation pipeline mapping

## Suggested workflow

1. Create and populate the SQL tables or MongoDB collections.
2. Read one question or report label before running its query.
3. Run the result, then compare SQL with the MongoDB aggregation version.
4. Change a filter or `GROUP BY` key and predict the result before rerunning.
5. Experiment with `NULL` values and review how `COUNT`, `SUM`, and `AVG`
   behave.

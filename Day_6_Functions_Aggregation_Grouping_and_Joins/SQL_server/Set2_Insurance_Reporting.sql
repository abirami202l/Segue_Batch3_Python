CREATE TABLE customers (customer_id INT PRIMARY KEY, name VARCHAR(50), dob DATE);
CREATE TABLE agents    (agent_id INT PRIMARY KEY, agent_name VARCHAR(50));
CREATE TABLE products  (product_id INT PRIMARY KEY, product_name VARCHAR(50));
CREATE TABLE policies  (policy_id INT PRIMARY KEY, policy_no VARCHAR(20),
                        customer_id INT REFERENCES customers(customer_id),
                        product_id  INT REFERENCES products(product_id),
                        agent_id    INT REFERENCES agents(agent_id),
                        start_date DATE, end_date DATE, premium INT, status VARCHAR(10));
CREATE TABLE premiums  (premium_id INT PRIMARY KEY, policy_id INT REFERENCES policies(policy_id),
                        amount INT, paid_date DATE);
CREATE TABLE claims    (claim_id INT PRIMARY KEY, policy_id INT REFERENCES policies(policy_id),
                        claim_amount INT, status VARCHAR(10), claim_date DATE);

INSERT INTO customers VALUES (1,'Arjun','1985-03-12'),(2,'Priya','1992-07-20'),(3,'Rahul','1968-01-05'),
                             (4,'Sneha','2001-09-15'),(5,'Karthik','1979-11-30'),(6,'Divya','1958-05-22');
INSERT INTO agents VALUES (1,'Ravi'),(2,'Meena'),(3,'Suresh'),(4,'Anita'),(5,'Kiran'),(6,'Latha');
INSERT INTO products VALUES (1,'Health'),(2,'Motor'),(3,'Life'),(4,'Home');
INSERT INTO policies VALUES
(1,'POL-2026-0001',1,2,1,'2025-12-01','2026-12-01',12000,'Active'),
(2,'POL-2026-0002',1,1,2,'2026-01-15','2027-01-15',18000,'Active'),
(3,'POL-2026-0003',2,1,2,'2026-03-10','2027-03-10',15000,'Active'),
(4,'POL-2026-0004',3,3,1,'2026-04-01','2027-04-01',25000,'Active'),
(5,'POL-2026-0005',3,3,3,'2025-12-10','2026-12-10',30000,'Active'),
(6,'POL-2026-0006',4,4,4,'2026-05-20','2027-05-20',8000,'Active'),
(7,'POL-2026-0007',5,2,5,'2025-11-10','2026-11-10',11000,'Expired'),
(8,'POL-2026-0008',5,1,6,'2026-08-18','2027-08-18',21000,'Active'),
(9,'POL-2026-0009',6,1,4,'2026-09-05','2027-09-05',22000,'Active'),
(10,'POL-2026-0010',6,3,3,'2026-10-12','2027-10-12',40000,'Active'),
(11,'POL-2026-0011',2,2,5,'2026-10-25','2027-10-25',9000,'Active');
INSERT INTO premiums VALUES (1,1,12000,'2025-12-01'),(2,2,9000,'2026-01-15'),(3,2,9000,'2026-07-15'),
(4,3,15000,'2026-03-10'),(5,4,25000,'2026-04-01'),(6,5,30000,'2025-12-10'),(7,6,8000,'2026-05-20'),
(8,7,11000,'2025-11-10'),(9,8,10500,'2026-08-18'),(10,9,22000,'2026-09-05'),(11,10,20000,'2026-10-12');
INSERT INTO claims VALUES (1,2,15000,'Settled','2026-06-10'),(2,4,20000,'Settled','2026-08-02'),
(3,1,5000,'Rejected','2026-09-01'),(4,7,9000,'Settled','2026-02-14'),(5,3,12000,'Open','2026-10-20'),
(6,9,18000,'Open','2026-11-02'),(7,2,4000,'Settled','2026-09-18');

DECLARE @Today DATE = '2026-11-17';   -- fixed so results are repeatable; use GETDATE() normally

-- Q1. Policies expiring in the next 30 days
SELECT policy_no, end_date
FROM policies
WHERE status = 'Active' AND end_date BETWEEN @Today AND DATEADD(DAY, 30, @Today)
ORDER BY end_date;

-- Q2. Premium collected per product
SELECT pr.product_name, SUM(m.amount) AS premium_collected
FROM premiums m JOIN policies p ON m.policy_id = p.policy_id
                JOIN products pr ON p.product_id = pr.product_id
GROUP BY pr.product_name
ORDER BY premium_collected DESC;

-- Q3. Customers with more than one active policy
SELECT c.name, COUNT(*) AS active_policies
FROM customers c JOIN policies p ON c.customer_id = p.customer_id
WHERE p.status = 'Active'
GROUP BY c.name
HAVING COUNT(*) > 1
ORDER BY c.name;

-- Q4. Claim ratio per product = total claims / total premium * 100
SELECT pr.product_name, pt.total_premium, ISNULL(ct.total_claims, 0) AS total_claims,
       CAST(100.0 * ISNULL(ct.total_claims, 0) / pt.total_premium AS DECIMAL(5,2)) AS claim_ratio_pct
FROM products pr
JOIN (SELECT product_id, SUM(premium) AS total_premium FROM policies GROUP BY product_id) pt
     ON pr.product_id = pt.product_id
LEFT JOIN (SELECT p.product_id, SUM(c.claim_amount) AS total_claims
           FROM claims c JOIN policies p ON c.policy_id = p.policy_id
           GROUP BY p.product_id) ct ON pr.product_id = ct.product_id
ORDER BY claim_ratio_pct DESC;

-- Q5. Policies without claims
SELECT p.policy_no, c.name
FROM policies p JOIN customers c ON p.customer_id = c.customer_id
LEFT JOIN claims cl ON p.policy_id = cl.policy_id
WHERE cl.claim_id IS NULL
ORDER BY p.policy_id;

-- Q6. Average premium by customer age band
SELECT age_band, COUNT(*) AS policies, AVG(premium * 1.0) AS avg_premium
FROM (SELECT p.premium,
             CASE WHEN DATEDIFF(YEAR, c.dob, @Today) < 30 THEN 'Under 30'
                  WHEN DATEDIFF(YEAR, c.dob, @Today) < 45 THEN '30-44'
                  WHEN DATEDIFF(YEAR, c.dob, @Today) < 60 THEN '45-59'
                  ELSE '60+' END AS age_band
      FROM policies p JOIN customers c ON p.customer_id = c.customer_id) t
GROUP BY age_band
ORDER BY avg_premium DESC;

-- Q7. Monthly new policies
SELECT FORMAT(start_date, 'yyyy-MM') AS month, COUNT(*) AS new_policies
FROM policies
GROUP BY FORMAT(start_date, 'yyyy-MM')
ORDER BY month;

-- Q8. Top-5 agents by premium
SELECT TOP 5 a.agent_name, SUM(p.premium) AS total_premium
FROM policies p JOIN agents a ON p.agent_id = a.agent_id
GROUP BY a.agent_name
ORDER BY total_premium DESC;

-- Task 2. DATEADD, DATEDIFF, CASE and string functions: masked policy number + age band
SELECT CONCAT(LEFT(p.policy_no, 4), REPLICATE('*', LEN(p.policy_no) - 8), RIGHT(p.policy_no, 4)) AS masked_policy_no,
       UPPER(c.name) AS customer_name,
       CASE WHEN DATEDIFF(YEAR, c.dob, @Today) < 30 THEN 'Under 30'
            WHEN DATEDIFF(YEAR, c.dob, @Today) < 45 THEN '30-44'
            WHEN DATEDIFF(YEAR, c.dob, @Today) < 60 THEN '45-59'
            ELSE '60+' END AS age_band,
       DATEADD(DAY, -30, p.end_date) AS reminder_date,
       DATEDIFF(DAY, @Today, p.end_date) AS days_to_expiry
FROM policies p JOIN customers c ON p.customer_id = c.customer_id
ORDER BY p.policy_id;
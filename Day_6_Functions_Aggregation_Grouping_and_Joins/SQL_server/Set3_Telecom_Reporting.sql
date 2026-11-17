CREATE TABLE plans (plan_id INT PRIMARY KEY, plan_name VARCHAR(30), monthly_fee INT, data_limit_mb INT);
CREATE TABLE subscribers (subscriber_id INT PRIMARY KEY, name VARCHAR(50),
                          plan_id INT REFERENCES plans(plan_id), circle VARCHAR(30), activation_date DATE);
CREATE TABLE call_records (record_id INT PRIMARY KEY, subscriber_id INT REFERENCES subscribers(subscriber_id),
                           record_date DATE, call_minutes INT, data_mb INT NULL);   -- data_mb can be NULL
CREATE TABLE invoices (invoice_id INT PRIMARY KEY, invoice_no VARCHAR(10),
                       subscriber_id INT REFERENCES subscribers(subscriber_id),
                       invoice_date DATE, due_date DATE, amount INT, status VARCHAR(10));

INSERT INTO plans VALUES (1,'Basic',199,2048),(2,'Standard',399,5120),(3,'Premium',699,10240);
INSERT INTO subscribers VALUES
(1,'Arjun',2,'Tamil Nadu','2024-02-10'),(2,'Priya',3,'Karnataka','2023-11-05'),(3,'Rahul',1,'Tamil Nadu','2024-06-18'),
(4,'Sneha',2,'Kerala','2025-01-22'),(5,'Karthik',1,'Karnataka','2024-09-09'),(6,'Divya',3,'Kerala','2025-03-14'),
(7,'Faisal',2,'Tamil Nadu','2025-05-30'),(8,'Anita',2,'Kerala','2025-08-12'),(9,'Vikram',3,'Karnataka','2026-01-07');
INSERT INTO call_records VALUES
(1,1,'2026-10-03',40,1500),(2,1,'2026-10-12',25,1200),(3,2,'2026-10-05',60,6000),(4,2,'2026-10-18',90,5000),
(5,3,'2026-10-07',15,2500),(6,4,'2026-10-09',30,3000),(7,4,'2026-10-21',20,NULL),(8,5,'2026-10-11',10,800),
(9,6,'2026-10-15',120,9000),(10,7,'2026-10-20',45,6000),(11,1,'2026-10-25',35,2500);
INSERT INTO invoices VALUES
(1,'2608001',1,'2026-08-01','2026-08-15',399,'Paid'),(2,'2608002',2,'2026-08-01','2026-08-15',699,'Paid'),
(3,'2609001',1,'2026-09-01','2026-09-15',399,'Paid'),(4,'2609002',3,'2026-09-01','2026-09-15',199,'Unpaid'),
(5,'2609003',4,'2026-09-01','2026-09-15',399,'Paid'),(6,'2610001',2,'2026-10-01','2026-10-15',699,'Unpaid'),
(7,'2610002',5,'2026-10-01','2026-10-15',199,'Unpaid'),(8,'2610003',6,'2026-10-01','2026-10-15',699,'Paid'),
(9,'2610004',7,'2026-10-01','2026-10-15',399,'Paid'),(10,'2611001',1,'2026-11-01','2026-11-15',399,'Unpaid'),
(11,'2611002',4,'2026-11-01','2026-11-15',399,'Unpaid'),(12,'2611003',7,'2026-11-01','2026-11-25',399,'Unpaid');

DECLARE @Today DATE = '2026-11-17';   -- fixed so results are repeatable; use GETDATE() normally

-- Q1. Total call minutes per plan
SELECT p.plan_name, SUM(u.call_minutes) AS total_minutes
FROM plans p JOIN subscribers s ON p.plan_id = s.plan_id
             JOIN call_records u ON s.subscriber_id = u.subscriber_id
GROUP BY p.plan_name
ORDER BY total_minutes DESC;

-- Q2. Subscribers exceeding their data limit (usage is for October 2026)
SELECT s.name, p.plan_name, SUM(u.data_mb) AS used_mb, p.data_limit_mb,
       SUM(u.data_mb) - p.data_limit_mb AS over_by_mb
FROM subscribers s JOIN plans p ON s.plan_id = p.plan_id
                   JOIN call_records u ON s.subscriber_id = u.subscriber_id
GROUP BY s.name, p.plan_name, p.data_limit_mb
HAVING SUM(u.data_mb) > p.data_limit_mb
ORDER BY over_by_mb DESC;

-- Q3. Month-wise revenue (amount billed)
SELECT FORMAT(invoice_date, 'yyyy-MM') AS month, COUNT(*) AS invoices, SUM(amount) AS revenue
FROM invoices
GROUP BY FORMAT(invoice_date, 'yyyy-MM')
ORDER BY month;

-- Q4. Unpaid invoices overdue by more than 15 days
SELECT i.invoice_no, s.name, i.due_date, DATEDIFF(DAY, i.due_date, @Today) AS days_overdue, i.amount
FROM invoices i JOIN subscribers s ON i.subscriber_id = s.subscriber_id
WHERE i.status = 'Unpaid' AND DATEDIFF(DAY, i.due_date, @Today) > 15
ORDER BY days_overdue DESC;

-- Q5. Subscribers with no usage
SELECT s.subscriber_id, s.name, s.circle
FROM subscribers s LEFT JOIN call_records u ON s.subscriber_id = u.subscriber_id
WHERE u.record_id IS NULL;

-- Q6. ARPU by circle = total billed / number of subscribers in the circle
SELECT s.circle, SUM(i.amount) AS total_billed, COUNT(DISTINCT s.subscriber_id) AS subscribers,
       CAST(SUM(i.amount) * 1.0 / COUNT(DISTINCT s.subscriber_id) AS DECIMAL(10,2)) AS arpu
FROM subscribers s LEFT JOIN invoices i ON s.subscriber_id = i.subscriber_id
GROUP BY s.circle
ORDER BY arpu DESC;

-- Q7. Plan popularity
SELECT p.plan_name, COUNT(*) AS subscribers
FROM subscribers s JOIN plans p ON s.plan_id = p.plan_id
GROUP BY p.plan_name
ORDER BY subscribers DESC;

-- Q8. Top-10 data consumers
SELECT TOP 10 s.name, SUM(u.data_mb) AS total_mb
FROM subscribers s JOIN call_records u ON s.subscriber_id = u.subscriber_id
GROUP BY s.name
ORDER BY total_mb DESC;

-- Task 2. Formatted invoice number and due-date status (CONCAT, LEFT, RIGHT, DATEDIFF, CASE)
SELECT CONCAT('INV-', LEFT(invoice_no, 4), '-', RIGHT(invoice_no, 3)) AS invoice_number,
       CASE WHEN status = 'Paid' THEN 'Paid'
            WHEN due_date >= @Today THEN CONCAT('Due in ', DATEDIFF(DAY, @Today, due_date), ' days')
            WHEN DATEDIFF(DAY, due_date, @Today) > 15 THEN CONCAT('Severely overdue (', DATEDIFF(DAY, due_date, @Today), ' days)')
            ELSE CONCAT('Overdue (', DATEDIFF(DAY, due_date, @Today), ' days)')
       END AS due_status
FROM invoices
ORDER BY invoice_id;

-- Task 3. NULL effect on SUM and AVG (subscribers 8 and 9 have no usage rows, one data_mb is NULL)
SELECT COUNT(*) AS subscribers, COUNT(total_mb) AS with_usage, SUM(total_mb) AS sum_mb,
       CAST(AVG(total_mb * 1.0) AS DECIMAL(10,2)) AS avg_ignoring_nulls,
       CAST(AVG(ISNULL(total_mb, 0) * 1.0) AS DECIMAL(10,2)) AS avg_nulls_as_zero
FROM (SELECT s.subscriber_id, SUM(u.data_mb) AS total_mb
      FROM subscribers s LEFT JOIN call_records u ON s.subscriber_id = u.subscriber_id
      GROUP BY s.subscriber_id) t;
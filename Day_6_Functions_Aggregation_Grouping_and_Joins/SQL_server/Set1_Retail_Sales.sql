CREATE TABLE customers (customer_id INT PRIMARY KEY, name VARCHAR(50), city VARCHAR(50), age INT NULL);
CREATE TABLE products  (product_id INT PRIMARY KEY, product_name VARCHAR(50), category VARCHAR(50), price INT);
CREATE TABLE orders    (order_id INT PRIMARY KEY, customer_id INT REFERENCES customers(customer_id), order_date DATE);
CREATE TABLE order_items (order_id INT REFERENCES orders(order_id), product_id INT REFERENCES products(product_id),
                          quantity INT, PRIMARY KEY (order_id, product_id));
CREATE TABLE payments  (payment_id INT PRIMARY KEY, order_id INT REFERENCES orders(order_id));

INSERT INTO customers VALUES (1,'Arjun','Chennai',25),(2,'Priya','Mumbai',30),(3,'Rahul','Delhi',NULL),
                             (4,'Sneha','Chennai',28),(5,'Karthik','Mumbai',NULL);
INSERT INTO products VALUES (1,'Laptop Stand','Electronics',1500),(2,'Mouse','Electronics',800),
                            (3,'T-Shirt','Apparel',600),(4,'Shoes','Apparel',3000),
                            (5,'Notebook','Stationery',250),(6,'Lamp','Home',1200);
INSERT INTO orders VALUES (101,1,'2026-08-05'),(102,2,'2026-08-05'),(103,1,'2026-08-20'),(104,4,'2026-09-10'),
                          (105,1,'2026-09-15'),(106,2,'2026-09-15'),(107,1,'2026-10-02'),(108,3,'2026-10-02');
INSERT INTO order_items VALUES (101,1,1),(101,5,2),(102,4,1),(103,2,2),(104,3,2),(104,5,4),
                               (105,6,1),(106,1,1),(106,2,1),(107,4,1),(107,3,1),(108,5,3);
INSERT INTO payments VALUES (1,101),(2,102),(3,103),(4,104),(5,105),(6,106),(7,107);  -- order 108 not paid

-- Q1. Top-5 products by revenue
SELECT TOP 5 p.product_name, SUM(oi.quantity) AS units_sold, SUM(oi.quantity * p.price) AS revenue
FROM order_items oi JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;

-- Q2. Month-wise sales
SELECT FORMAT(o.order_date, 'yyyy-MM') AS sales_month, COUNT(DISTINCT o.order_id) AS orders,
       SUM(oi.quantity * p.price) AS revenue
FROM orders o JOIN order_items oi ON o.order_id = oi.order_id
              JOIN products p ON oi.product_id = p.product_id
GROUP BY FORMAT(o.order_date, 'yyyy-MM')
ORDER BY sales_month;

-- Q3. Customers with more than three orders
SELECT c.name, COUNT(*) AS order_count
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING COUNT(*) > 3;

-- Q4. Average basket value per city
SELECT c.city, CAST(AVG(t.total * 1.0) AS DECIMAL(10,2)) AS avg_basket_value
FROM (SELECT oi.order_id, SUM(oi.quantity * p.price) AS total
      FROM order_items oi JOIN products p ON oi.product_id = p.product_id
      GROUP BY oi.order_id) t
JOIN orders o ON t.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.city
ORDER BY avg_basket_value DESC;

-- Q5. Orders without payment
SELECT o.order_id, c.name, o.order_date
FROM orders o JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN payments pay ON o.order_id = pay.order_id
WHERE pay.payment_id IS NULL;

-- Q6. Customers with no orders
SELECT c.customer_id, c.name, c.city
FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Q7. Product-category revenue share
SELECT p.category, SUM(oi.quantity * p.price) AS revenue,
       CAST(100.0 * SUM(oi.quantity * p.price) /
            (SELECT SUM(oi2.quantity * p2.price)
             FROM order_items oi2 JOIN products p2 ON oi2.product_id = p2.product_id) AS DECIMAL(5,2)) AS share_pct
FROM order_items oi JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;

-- Q8. Day with the highest sales
SELECT TOP 1 o.order_date, SUM(oi.quantity * p.price) AS daily_sales
FROM orders o JOIN order_items oi ON o.order_id = oi.order_id
              JOIN products p ON oi.product_id = p.product_id
GROUP BY o.order_date
ORDER BY daily_sales DESC;

-- Task 2. Customer-friendly column (UPPER, CONCAT, DATEDIFF, FORMAT, ROUND)
SELECT o.order_id,
       CONCAT(UPPER(c.name), ' | ', FORMAT(o.order_date, 'dd-MMM-yyyy', 'en-US'),
              ' (', DATEDIFF(DAY, o.order_date, '2026-11-17'), ' days ago) | Total Rs. ',
              FORMAT(t.total, 'N0', 'en-US'), ' | GST Rs. ',
              FORMAT(ROUND(t.total * 0.18, 0), 'N0', 'en-US')) AS order_summary
FROM orders o JOIN customers c ON o.customer_id = c.customer_id
JOIN (SELECT oi.order_id, SUM(oi.quantity * p.price) AS total
      FROM order_items oi JOIN products p ON oi.product_id = p.product_id
      GROUP BY oi.order_id) t ON o.order_id = t.order_id
ORDER BY o.order_id;

-- Task 3. NULL behaviour (age is NULL for 2 customers)
SELECT COUNT(*) AS count_star, COUNT(age) AS count_age,
       CAST(AVG(age * 1.0) AS DECIMAL(5,2)) AS avg_age,
       CAST(AVG(ISNULL(age, 0) * 1.0) AS DECIMAL(5,2)) AS avg_age_null_as_zero
FROM customers;
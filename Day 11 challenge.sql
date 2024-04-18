--Retrieve all columns from any table

SELECT *
FROM accounts

SELECT *
FROM orders

SELECT *
FROM region

SELECT *
FROM sales_reps

SELECT *
FROM web_events

SELECT name
FROM accounts
ORDER BY name asc

--Join two tables and retrieve 6  columns

SELECT *
FROM accounts As a
JOIN orders As o
ON a.id = o.account_id 

SELECT *
FROM accounts As a
JOIN orders As o
ON a.id = o.account_id 

SELECT a.id, o.account_id
FROM accounts As a
JOIN orders As o
ON a.id = o.account_id 

SELECT *
FROM sales_reps As s
LEFT JOIN region As r
ON s.region_id = r.id

--Join two tables and retrieve 6  columns, 3 columns from each chosen table

SELECT a.id, a.name, a.website, o.occurred_at, o.standard_qty, o.gloss_qty
FROM accounts As a
JOIN orders As o
ON a.id = o.account_id 

--calculate total sales and average order value by region

SELECT r.name, AVG(total_amt_usd) average_order_value
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
GROUP BY r.name
ORDER BY average_order_value desc

--Use a subquery to find customers who have made orders above the average order value

SELECT a.name, o.total_amt_usd
FROM accounts a
JOIN orders o
ON a.id = o.account_id
WHERE total_amt_usd > (SELECT AVG(total_amt_usd)FROM orders)
ORDER BY total_amt_usd asc

--Write an SQL query to retrieve the total sales for each channel, highlight high and low value channels 

SELECT w.channel, SUM(total_amt_usd) AS total_sales,
CASE WHEN SUM(total_amt_usd)> 600000000 THEN 'high value'
WHEN SUM(total_amt_usd) < 50000000 THEN 'Low vaue'
ELSE 'Medium Value'
END AS sales_category
FROM orders o
JOIN web_events w
ON w.account_id = o.account_id
GROUP BY w.channel
ORDER BY total_sales desc

SELECT total_amt_usd, SUM(total_amt_usd) AS total_sales,
CASE WHEN SUM(total_amt_usd)> 10000 THEN 'high_value'
WHEN SUM(total_amt_usd) > 5000 THEN 'Mid_vaue'
ELSE 'Low_Value'
END amt_value
FROM orders o
JOIN web_events w
ON w.account_id = o.account_id
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.id, o.total_amt_usd
ORDER BY total_sales desc



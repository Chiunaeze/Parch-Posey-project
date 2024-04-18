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
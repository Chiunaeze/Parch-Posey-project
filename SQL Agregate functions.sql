SELECT *
FROM region
--No of times a customer placed an order

SELECT account_id, COUNT(total) times_ordered
FROM orders
GROUP BY account_id


SELECT name, account_id, COUNT(total) times_ordered
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY account_id, name
ORDER BY times_ordered desc


SELECT COUNT (id) total_number_of_customers
FROM accounts

--total amount spent by each customer
SELECT account_id, SUM(total_amt_usd)
FROM orders
GROUP BY account_id
ORDER BY account_id

--total number of standard paper ordered by each customer

SELECT account_id, SUM(standard_qty) total_standard
FROM orders
GROUP BY account_id
ORDER BY account_id

--calculate average order value by region
SELECT r.name, AVG(total) average_order_value
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
GROUP BY r.name
ORDER BY average_order_value desc

--Calculate total sales by region
SELECT r.name, SUM(total) total_sales
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
GROUP BY r.name
ORDER BY total_sales desc

--CASE

SELECT total_amt_usd, CASE
						WHEN total_amt_usd > 10000 THEN 'High_order'	
						WHEN total_amt_usd > 5000 THEN 'Mid_order'
						ELSE 'Mid_order'
					END AS order_categories
FROM orders
ORDER BY total_amt_usd desc

--Group total column into two categories. category1 > 15000; category1 < 15000

SELECT total, CASE
				WHEN total > 15000 THEN 'category1'
				ELSE 'category2'
				END AS order_categories
FROM ORDERS
ORDER BY total desc

--SUBQUERIES

--Generate order id and when it occurred where standard_qty orderred is greater than 500
SELECT id, occurred_at
FROM (SELECT id,occurred_at, standard_qty
	 FROM orders
	 WHERE standard_qty > 500) AS standard_above_500
	
--CTE(COMMON TABLE EXPRESSION)
WITH standard_above_500 AS (SELECT id,occurred_at, standard_qty
	 						FROM orders
	 						WHERE standard_qty > 500)
SELECT id, occurred_at
FROM standard_above_500
				
--WORKING WITH DATE/TIME IN SQL

--DATE_TRUNC

SELECT occurred_at, DATE_TRUNC('year', occurred_at) AS years,
					DATE_TRUNC('month', occurred_at) AS months,
					DATE_TRUNC('day', occurred_at) AS days
FROM web_events

--USING DATE_PART

SELECT occurred_at, DATE_PART('year', occurred_at) AS year_part,
					DATE_PART('month', occurred_at) AS month_part,
					DATE_PART('month', occurred_at) AS day_part
FROM web_events

SELECT DATE_TRUNC('year', occurred_at), COUNT(occurred_at)
FROM web_events
GROUP BY 1
ORDER BY 1

SELECT DATE_PART('month', occurred_at), COUNT(occurred_at)
FROM web_events
GROUP BY 1
ORDER BY 1

SELECT DATE_PART('dow', occurred_at), COUNT(occurred_at)
FROM web_events
GROUP BY 1
ORDER BY 1

--WHAT IS THE TOTAL AMOUNT OF MONEY GENERATED MONTHLY FROM INCEPTION OF PARCH AND POSEY
--WHAT MONTH HAS THE HIGHEST SALES IRRESPECTIVE OF THE YEAR

SELECT DATE_TRUNC('month', o.occurred_at) AS month, SUM(o.total_amt_usd) AS monthly_sales
FROM orders o
GROUP BY 1
ORDER BY 1


SELECT DATE_PART('month', o.occurred_at) AS month, SUM(o.total_amt_usd) AS monthly_sales
FROM orders o
GROUP BY 1
ORDER BY 1 desc
LIMIT 1
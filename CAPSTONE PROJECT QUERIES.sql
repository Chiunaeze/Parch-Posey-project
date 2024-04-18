--1. What is the region with the highest revenue

SELECT r.name, SUM(o.total_amt_usd) highest_revenue
FROM orders AS o
JOIN accounts AS a
ON a.id = o.account_id
JOIN sales_reps AS s
ON a.sales_rep_id = s.id
JOIN region AS r
ON s.region_id = r.id
GROUP BY r.name
ORDER BY highest_revenue desc


--2. Which sales rep has total sales above the average value	

SELECT s.id, o.total
FROM orders AS o
JOIN accounts AS a
ON a.id = o.account_id
JOIN sales_reps AS s
ON s.id = a.sales_rep_id
WHERE total > (SELECT AVG(total) sale_rep_abv_avg FROM orders)
GROUP BY s.id, o.total
ORDER BY o.total desc
LIMIT 10

-- 3. Which customer placed the highest order and at what time

SELECT a.name, o.total, o.occurred_at, MAX(o.total)
FROM orders AS o
JOIN accounts AS a
ON a.id = o.account_id
WHERE o.total = (SELECT MAX(total) highest_order FROM orders)
GROUP BY a.name, o.total, o.occurred_at

--4. Retrieve the total sales for each region, highlight high and low

SELECT r.name, SUM(o.total) AS sales,
	 CASE WHEN SUM (total) > 500000 THEN 'high value'
	 WHEN SUM (total) <= 500000 THEN 'low value'
	 END AS sales_category
FROM orders AS o
JOIN accounts AS a
ON a.id = o.account_id
JOIN sales_reps AS s
ON a.sales_rep_id = s.id
JOIN region AS r
ON r.id = s.region_id
GROUP BY r.name
ORDER BY r.name asc


-- 5. Identify which product has the most revenue and from which region

SELECT r.name, standard_qty, gloss_qty, poster_qty, MAX(o.total_amt_usd)
FROM orders AS o
JOIN accounts AS a
ON a.id = o.account_id
JOIN sales_reps AS s
ON a.sales_rep_id = s.id
JOIN region AS r
ON r.id = s.region_id
GROUP BY r.name, standard_qty, gloss_qty, poster_qty
ORDER BY MAX(o.total_amt_usd) desc
LIMIT 5


--6. Show the top ten orders for all products and their total revenue

SELECT a.id, total, total_amt_usd, name
FROM orders o
JOIN accounts a
ON a.id = o.account_id
ORDER BY name,total_amt_usd desc
LIMIT 10

--7. Show the customers that ordered standard and gloss papers but not poster paper

SELECT a.name, a.id, o.standard_qty, o.gloss_qty, o.poster_qty, o.total
FROM orders AS o
JOIN accounts AS a
ON a.id = o.account_id
WHERE poster_qty = 0
	and standard_qty >= 1
	and gloss_qty >= 1
GROUP BY a.name, a.id, o.standard_qty, o.gloss_qty, o.poster_qty, o.total
ORDER BY total


--8. In what month was the highest profit made

SELECT DATE_PART('month', occurred_at), SUM(total_amt_usd)
FROM orders
GROUP BY 1
ORDER BY 2 desc
LIMIT 1


--9. Retrieve the total revenue from each channel 

SELECT w.channel, SUM(o.total_amt_usd) AS total_revenue
FROM orders AS o
JOIN web_events AS w
ON w.account_id = w.account_id
GROUP BY w.channel


--10. What is the total sales from standard_qty and gloss_qty only

SELECT standard_qty, gloss_qty, (standard_qty+gloss_qty) AS total_sales
FROM orders

--11. Sales trend over the years

SELECT DATE_PART('year', occurred_at), SUM(total)
FROM orders
GROUP BY 1
ORDER BY 2

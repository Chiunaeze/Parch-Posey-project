-- 1. Retrieve data from the accounts table and display the names, websites and sales reps of all customers

SELECT name, website, sales_rep_id
FROM accounts

--2i. Retrieve the order id and the quantity ordered of only standard paper

SELECT id, standard_qty
FROM orders

--2ii. Identify the top 10 total orders by quantity

SELECT total
FROM orders
ORDER BY total desc
LIMIT 10

--2iii.	Identify large total orders that are greater than 2000 pieces

SELECT total
FROM orders
WHERE total > 2000 

--3. Using the appropriate table, identify the highest total single order by count, made by a company

SELECT account_id, COUNT(total) times_ordered
FROM orders
GROUP BY account_id
RDER BY times_ordered desc

--4.Using the appropriate table, identify the top 3 total single order by amount paid, made by a company

SELECT account_id, SUM(total) total_amt_usd
FROM orders
GROUP BY account_id
ORDER BY total_amt_usd desc
LIMIT 3

--5. Retrieve the list of orders where the total ordered quantity is greater than 2000 and the total price is greater than #50000

SELECT id, total, total_amt_usd
FROM orders 
WHERE total >2000 and total_amt_usd >50000
ORDER BY id asc

--B1.Retrieve the top 10 orders of poster paper by amount spent and the respective names of companies that placed the order.

SELECT o.id, o.total_amt_usd, a.name
FROM orders o
JOIN accounts a
ON a.id = o.account_id
ORDER BY total_amt_usd desc
LIMIT 10

--B2. Retrieve the account names for all customers, the names of their sales reps and the region names of their respective sales reps.

SELECT a.name, s.name, r.name
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id

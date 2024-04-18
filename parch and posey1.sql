--Alphabetically what are the last 5 account names

SELECT name
FROM accounts
ORDER BY name desc
LIMIT 5

--Join the accounts and orders table

SELECT *
FROM accounts
JOIN orders
ON accounts.id = orders.account_id
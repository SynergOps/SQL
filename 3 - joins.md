# Lets learn how to JOIN tables to show combined data

Use the previously imported database (`wallets`).
Types of Join
1. INNER JOIN
2. OUTER JOIN
3. CROSS JOIN

INNER JOIN
There should be a common column between the two tables to join them
In this case, the common column is `customer_id` because it is present in both tables

First, create a new table from `wallet_addr` with only the columns we need.
```sql
CREATE TABLE customer_wallets AS
SELECT
    customer_id,
    bitcoin_addr AS wallet_address,
    btc AS balance,
    date_of_creation AS created_at
FROM
    wallet_addr;
```
Lets delete the columns we don't need from `wallet_addr` (`bitcoin_addr`, `btc`, `date_of_creation`).
Create a backup of the `wallet_addr` table before dropping columns.

```sql
CREATE TABLE wallet_addr_backup AS
SELECT * FROM wallet_addr;
```
Drop the columns bitcoin_addr and btc from the wallet_addr table
```sql
ALTER TABLE wallet_addr
DROP COLUMN date_of_creation,
DROP COLUMN bitcoin_addr,
DROP COLUMN btc;
```
Now we can join the two tables, wallet_addr and customer_wallets, using the INNER JOIN.
Aliases can be anything, but it is a good practice to use the first letter of the table name
This query retrieves the first name, last name, wallet address, and balance for each customer
```sql
SELECT
    wa.first_name,
    wa.last_name,
    cw.wallet_address,
    cw.balance
FROM
    wallet_addr wa
INNER JOIN customer_wallets cw ON
    wa.customer_id = cw.customer_id
```

OUTER JOIN (if you don't find a match, you still want to see the row but with NULL values)
1. LEFT JOIN : All rows from the left table and the matched rows from the right table
2. RIGHT JOIN : All rows from the right table and the matched rows from the left table

OUTER LEFT JOIN
This query retrieves the first name, last name, wallet address, and balance for each customer
If a customer does not have a wallet, the wallet address and balance will be NULL
Lets delete some wallet addresses, balances and creation dates from the `customer_wallets` table
to simulate a situation where some customers do not have wallets.

Create a backup of the customer_wallets table before emptying some rows
```sql
CREATE TABLE customer_wallets_backup AS
SELECT * FROM customer_wallets;
```
Empty some rows from the customer_wallets table
```sql
UPDATE
    customer_wallets
SET
    wallet_address = NULL,
    balance = NULL,
    created_at = NULL
WHERE
    balance > 19000
```
Now we can join the two tables, wallet_addr and customer_wallets, using the LEFT JOIN.
```sql
SELECT
    wa.first_name,
    wa.last_name,
    cw.wallet_address,
    cw.balance
FROM
    wallet_addr wa
LEFT JOIN customer_wallets cw ON
    wa.customer_id = cw.customer_id
```
OUTER RIGHT JOIN
This query retrieves the first name, last name, wallet address, and balance for each customer
If a customer does not have a wallet, the first name and last name will be NULL
So lets delete some first names and last names from the wallet_addr table to simulate a situation
where some customers do not have postal codes.

Empty some rows from the wallet_addr table where postal code is Null

```sql
UPDATE
    wallet_addr
SET
    first_name = NULL,
    last_name = NULL
WHERE
    postal_code IS NULL
```
Now we can join the two tables, wallet_addr and customer_wallets, using the RIGHT JOIN.
```sql
SELECT
    wa.customer_id,
    wa.first_name,
    wa.last_name,
    cw.wallet_address,
    cw.balance
FROM
    wallet_addr wa  
RIGHT JOIN customer_wallets cw ON
    wa.customer_id = cw.customer_id
```
CROSS JOIN
Cartesian product of two tables, i.e. all possible combinations of rows from both tables. Meaning 
the number of rows in the result set is the product of the number of rows in the two tables. Every row
in the first table is joined with every row in the second table.
Here we will use the `wallet_addr` and `customer_wallets` tables to demonstrate the CROSS JOIN.

```sql
SELECT
    wa.customer_id,
    wa.first_name,
    wa.last_name,
    cw.wallet_address,
    cw.balance
FROM
    wallet_addr wa
CROSS JOIN customer_wallets cw
```
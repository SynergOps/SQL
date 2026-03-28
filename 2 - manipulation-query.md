# Lets learn how to manage tables

Use the previously imported database (`wallets`).
Show everybody from Greece with more than 500 BTC with named columns
```sql
SELECT first_name AS first_name, last_name AS last_name, btc AS btc_amount
FROM wallet_addr WHERE country = 'Greece' AND btc > 500;
```
Show a new column with the sum of BTC
```sql
SELECT first_name AS first_name,
    last_name AS last_name,
    btc AS btc_amount,
    btc + 100 AS btc_amount_plus_100
FROM wallet_addr;
```
Create a temporary table with the previous query and show the result from the temporary table
```sql
CREATE TEMPORARY TABLE temp_wallet_addr_plus_100 AS SELECT
    first_name,
    last_name,
    btc + 100 AS btc_amount_plus_100
FROM
    wallet_addr;
    -- Show the result from the temporary table
SELECT
    *
FROM
    temp_wallet_addr_plus_100;
```
Create a new table with the previous query
```sql
CREATE TABLE wallet_addr_plus_100 AS SELECT
    first_name,
    last_name,
    btc + 100 AS btc_amount_plus_100
FROM
    wallet_addr;
```
Create a new table with the previous query but with a primary key
```sql
CREATE TABLE wallet_addr_plus_100_with_id (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    btc_amount_plus_100 DECIMAL(12, 7) NOT NULL
) ;

INSERT INTO wallet_addr_plus_100_with_id (first_name, last_name, btc_amount_plus_100)
SELECT
    first_name,
    last_name,
    btc + 100 AS btc_amount_plus_100
FROM
    wallet_addr;
```
Dialect note:
- MySQL/MariaDB: replace identity with `id INT AUTO_INCREMENT PRIMARY KEY`.
- Microsoft SQL Server: replace identity with `id INT IDENTITY(1,1) PRIMARY KEY`.
Delete data from the table `wallet_addr_plus_100` where name starts with 'Cl'
```sql
DELETE FROM wallet_addr_plus_100 WHERE first_name LIKE 'Cl%';
```
Update the table `wallet_addr_plus_100` where the name starts with 'A' to have 200 BTC
```sql
UPDATE wallet_addr_plus_100 SET btc_amount_plus_100 = 200 WHERE first_name LIKE 'A%';
-- Show where we have updated the BTC amount
SELECT * FROM wallet_addr_plus_100 WHERE btc_amount_plus_100 = 200;
```
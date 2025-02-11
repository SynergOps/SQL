# Lets how to manage tables

Use the previously imported database
```sql
USE wallets;
```
Show everybody from Greece with more than 500 BTC with named columns
```sql
SELECT first_name AS 'First Name', last_name AS 'Last Name', btc AS 'BTC amount' 
FROM wallet_addr WHERE country = 'Greece' AND btc > 500;
```
Show a new column with the sum of BTC
```sql
SELECT first_name AS 'First Name', 
    last_name AS 'Last Name', 
    btc AS 'BTC amount', 
    btc + 100 AS 'BTC amount + 100' 
FROM wallet_addr;
```
Create a temporary table with the previous query and show the result from the temporary table
```sql
CREATE TEMPORARY TABLE temp_wallet_addr_plus_100 AS SELECT
    first_name AS 'First Name',
    last_name AS 'Last Name',
    btc + 100 AS 'BTC amount + 100'
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
    first_name AS 'First Name',
    last_name AS 'Last Name',
    btc + 100 AS 'BTC amount + 100'
INTO @wallet_addr_plus_100
FROM
    wallet_addr;
```
Create a new table with the previous query but with a primary key
```sql
CREATE TABLE wallet_addr_plus_100 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    btc_amount_plus_100 DECIMAL(12, 7) NOT NULL
) AS SELECT NULL AS 
    id,
    first_name,
    last_name,
    btc + 100 AS btc_amount_plus_100
FROM
    wallet_addr;
```
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
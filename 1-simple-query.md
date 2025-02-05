Create a database named `wallets` (e.g. with phpmyadmin), and import the wallet_addr.sql

Use the new imported database
```sql
USE wallets;
```
Query the table `wallet_addr` in the database `wallets`
```sql
SELECT * FROM wallet_addr;
```
Show only the first name and last name of the table `wallet_addr`

```sql
SELECT first_name, last_name FROM wallet_addr;
```
Distinct values in a column (e.g. first_name)
```sql
SELECT DISTINCT first_name FROM wallet_addr;
```
Show everybody from Greece
```sql
SELECT * FROM wallet_addr WHERE country = 'Greece';
```
Show everybody from Greece with more than 500 BTC
```sql
SELECT * FROM wallet_addr WHERE country = 'Greece' AND btc > 500;
```
Show everybody from Greece where the name starts with 'A'. Note that LIKE is case-insensitive
```sql
SELECT * FROM wallet_addr WHERE country = 'Greece' AND first_name LIKE 'A%';
```
Show everybody from Greece or China
```sql
SELECT * FROM wallet_addr WHERE country IN ('Greece', 'China');
```
Show everybody from Greece with their wallet address created after 2009-01-03
```sql
SELECT * FROM wallet_addr WHERE country = 'Greece' AND date_of_creation > '2009-01-03';
```
Show wallets created between two dates
```sql 
SELECT * FROM wallet_addr WHERE date_of_creation BETWEEN '2009-01-03' AND '2010-01-03';
```
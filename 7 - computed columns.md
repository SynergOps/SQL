# Lets learn about computed columns in MySQL

Computed columns are columns that are not stored in the table but are computed on the fly
They are calculated based on other columns in the table
They are useful when you want to calculate a value based on other columns 
and you don't want to store that value in the table

They are also useful when you want to create an index on a column that is computed
Lets see an example with our `customer_wallets` MySQL table where we want to calculate how many years old is 
the wallet address based on the creation date that is stored in the `Created At` column

If you already have the `customer_wallets` table, from the previous sections then you can skip the following part.
If not, you can create the `customer_wallets` table using the following SQL statement using columns from the `wallet_addr` table.

Create the customer_wallets table:

```sql
CREATE TABLE customer_wallets AS
SELECT
    customer_id AS `Customer ID`,
    bitcoin_addr AS 'Wallet Address',
    btc AS 'Balance',
    date_of_creation AS 'Created At'
FROM
    wallet_addr;
```

Now we have the `customer_wallets` MySQL table with the following columns lets add a 
new column `Years Old` that will calculate how many years old is the wallet address based on the `Created At` column

Note that MySQL does not allow non-deterministic functions (like CURDATE()) in generated columns. 
Unfortunately, this means you cannot use a generated column to automatically update Years Old based on the current date.

Since a generated column won't work, you should:

1. Add a regular Years Old column
1. Use an UPDATE query to calculate the age
1. (Optional) Create an event scheduler to update it automatically

Add the `Years Old` column to the `customer_wallets` table
```sql
ALTER TABLE customer_wallets 
ADD COLUMN `Years Old` INT;
```
Update the `Years Old` column with the age of the wallet address
```sql
UPDATE customer_wallets 
SET `Years Old` = TIMESTAMPDIFF(YEAR, `Created At`, CURDATE());
```
Now you can see the `Years Old` column in the `customer_wallets` table
```sql
SELECT * FROM customer_wallets;
```
(Optional): Automate Updates Using MySQL Event Scheduler
If you want Years Old to update automatically daily, you can create a scheduled event:
```sql
CREATE EVENT update_wallet_age
ON SCHEDULE EVERY 1 DAY
DO
  UPDATE customer_wallets 
  SET `Years Old` = TIMESTAMPDIFF(YEAR, `Created At`, CURDATE());
```
This ensures that Years Old stays updated without manual intervention. Enable the MySQL Event Scheduler (if it's not enabled)
Before using events, make sure the MySQL event scheduler is enabled:
```sql
SET GLOBAL event_scheduler = ON;
```
 Why is this necessary?
MySQL does not allow CURDATE() in generated columns because the value would change dynamically over time. The event scheduler is the best alternative to keep it updated automatically
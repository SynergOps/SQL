## Lets learn about SQL Views

Create a database named `wallet_addr` (e.g. with phpmyadmin), and import the wallet_addr.sql
Use the new imported database
```sql
USE wallet_addr;
```
A view is a virtual table based on the result-set of an SQL statement.
- A view contains rows and columns, just like a real table. 
- The fields in a view are fields from one or more real tables in the database.
- You can add SQL functions, WHERE, and JOIN statements to a view and present the data as if the data were coming from one single table.
- A view can contain all rows or columns of a table or selected rows or columns from one or more tables.

Create a view with the `wallet_addr_view` that will display first name, the wallet address, the balance of the wallet address and the email
```sql
CREATE VIEW wallet_addr_view AS SELECT
    wa.first_name,
    cw.`Wallet Address`,
    cw.Balance,
    wa.email
FROM
    wallet_addr wa
INNER JOIN customer_wallets cw ON
    wa.customer_id = cw.`Customer ID`;
```
Lets create a view for Whales customers only that have a balance greater than 20000
```sql
CREATE VIEW whales_customers AS SELECT
    wa.first_name,
    cw.`Wallet Address`,
    cw.Balance,
    wa.email
FROM
    wallet_addr wa
INNER JOIN customer_wallets cw ON
    wa.customer_id = cw.`Customer ID`
WHERE
    cw.Balance > 20000
```
# Lets learn about SQL Views

Use the previously imported database (`wallets`).
If you already have the `customer_wallets` table from Lesson 3, skip the table creation step below. Otherwise, create it using:

```sql
CREATE TABLE customer_wallets AS
SELECT
    customer_id,
    bitcoin_addr AS wallet_address,
    btc AS balance,
    date_of_creation AS created_at
FROM wallet_addr;

ALTER TABLE customer_wallets
ADD CONSTRAINT customer_wallets_pk PRIMARY KEY (customer_id);
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
    cw.wallet_address,
    cw.balance,
    wa.email
FROM
    wallet_addr wa
INNER JOIN customer_wallets cw ON
    wa.customer_id = cw.customer_id;
```
Lets create a view for whale customers only that have a balance greater than 20000
```sql
CREATE VIEW whales_customers AS SELECT
    wa.first_name,
    cw.wallet_address,
    cw.balance,
    wa.email
FROM
    wallet_addr wa
INNER JOIN customer_wallets cw ON
    wa.customer_id = cw.customer_id
WHERE
    cw.balance > 20000
```
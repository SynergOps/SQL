# Lets learn about about Common Table Expressions (CTE)

A Common Table Expression (CTE) is a temporary result set that exists only within the execution of a single query. CTEs help organize complex queries, improve readability, and allow you to reuse subquery results.
They are defined using the `WITH` keyword and can be referenced only within the query that follows.

Here is the syntax for a CTE:

```sql
WITH cte_name AS (
    SELECT column1, column2, ...
    FROM table_name
    WHERE condition
)
SELECT * FROM cte_name;
```
- The WITH clause defines the CTE.
- The CTE exists only during query execution and cannot be referenced afterward.

For testing purposes we will use the `customer_wallets` table. If you already have the `customer_wallets` table, from the previous sections then you can skip the following part.
If not, you can create the `customer_wallets` table using the following SQL statement using columns from the `wallet_addr` table.

Create the `customer_wallets` table:

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

Lets start exploring CTEs with some examples. 

### Example 1: Using a CTE for Readability
Without a CTE:
```sql
SELECT first_name, last_name
FROM wallet_addr
WHERE customer_id IN (
    SELECT `Customer ID` FROM customer_wallets WHERE balance > 20499
);
```
With a CTE:
```sql
WITH high_value_customers AS (
    SELECT `Customer ID` FROM customer_wallets WHERE balance > 20499
)
SELECT first_name, last_name
FROM wallet_addr
WHERE customer_id IN (SELECT `Customer ID` FROM high_value_customers);
```
### Example 2: Using Multiple CTEs
```sql
WITH high_value_customers AS (
    SELECT `Customer ID` FROM customer_wallets WHERE balance > 20499
),
high_value_transactions AS (
    SELECT * FROM customer_wallets WHERE balance > 20499
)
SELECT * FROM high_value_customers JOIN high_value_transactions USING (`Customer ID`) 
WHERE `Created At` BETWEEN '2020-01-01' AND '2023-01-01';
```
### Example 3: Recursive CTE for Hierarchical Data
```sql
WITH
    RECURSIVE cte AS( -- This defines a recursive CTE that will repeatedly execute itself based on a set condition
    SELECT -- Base case (starting point) 
        customer_id,
        first_name,
        last_name,
        country,
        postal_code,
        1 AS level
    FROM wallet_addr
    WHERE postal_code IS NULL -- Ends here. Selects all rows from wallet_addr where postal_code IS NULL
    UNION ALL -- Recursive case. The UNION ALL ensures that new rows keep getting added until no new matches are found.
    SELECT
        w.customer_id,
        w.first_name,
        w.last_name,
        w.country,
        w.postal_code,
        cte.level + 1
    FROM wallet_addr w
    INNER JOIN cte ON w.postal_code = cte.country -- It matches w.postal_code with cte.country. This means a row in wallet_addr is included in the recursion if its postal_code matches the country of an already selected row.
    WHERE cte.level < 10  -- Prevent infinite loops by limiting the number of recursions
)
SELECT * FROM cte;
```
### When to Use a CTE vs. a Subquery

| Feature | CTE (WITH ... AS) | Subquery ((SELECT ...) AS alias) |
|---------|---------|---------|
| Readability| ✅ Improves readability| ❌ Can become complex|
| Reusability| ✅ Can be referenced multiple times| ❌ Usually needs duplication|
| Performance| ✅ Optimized in some cases| ✅ Sometimes faster for small queries|
| Recursive Queries| ✅ Supported| ❌ Not possible|

MySQL Version Requirement: MySQL 8.0 and above

### Conclusion
CTEs improve query structure by breaking down complex logic.
They only exist within a single query execution and are not stored in the database.
Use CTEs for recursion, improving readability, and avoiding redundant subqueries.
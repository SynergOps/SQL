# Lets learn about computed columns

Computed columns are values derived from other columns.
For portability, use two patterns:

1. Generated column for deterministic expressions.
2. Regular column + periodic `UPDATE` for time-based values that depend on the current date.

If you already have the `customer_wallets` table, skip this part.

```sql
CREATE TABLE customer_wallets AS
SELECT
  customer_id,
  bitcoin_addr AS wallet_address,
  btc AS balance,
  date_of_creation AS created_at
FROM wallet_addr;
```

## PostgreSQL-safe example (time-based age)

Because age changes over time, keep it in a regular column and refresh it.

```sql
ALTER TABLE customer_wallets
ADD COLUMN years_old INT;
```

```sql
UPDATE customer_wallets
SET years_old = DATE_PART('year', AGE(CURRENT_DATE, created_at));
```

```sql
SELECT * FROM customer_wallets;
```

## Optional automation

Use your scheduler of choice (cron, pg_cron, SQL Agent, event scheduler) to run the `UPDATE` daily.

## Dialect notes (only where different)

- MySQL/MariaDB equivalent age update:
```sql
UPDATE customer_wallets
SET years_old = TIMESTAMPDIFF(YEAR, created_at, CURDATE());
```

- Microsoft SQL Server equivalent age update:
```sql
UPDATE customer_wallets
SET years_old = DATEDIFF(YEAR, created_at, CAST(GETDATE() AS date))
         - CASE
           WHEN DATEADD(YEAR, DATEDIFF(YEAR, created_at, CAST(GETDATE() AS date)), created_at)
            > CAST(GETDATE() AS date)
           THEN 1
           ELSE 0
         END;
```

Note: `DATEDIFF(YEAR, ...)` in SQL Server counts year boundaries, so the adjustment above gives full years.
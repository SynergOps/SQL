# Lets learn about triggers

Triggers execute automatically when an event happens on a table (`INSERT`, `UPDATE`, `DELETE`).
They are useful for business rules, auditing, and data integrity.

## PostgreSQL-safe syntax (default)

In PostgreSQL, you create a trigger function first, then attach it with `CREATE TRIGGER`.

```sql
CREATE OR REPLACE FUNCTION trigger_function_name()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    -- trigger body
    RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_name
BEFORE INSERT OR UPDATE OR DELETE
ON table_name
FOR EACH ROW
EXECUTE FUNCTION trigger_function_name();
```

If you already have the `customer_wallets` table from previous lessons, skip this part.

```sql
CREATE TABLE customer_wallets AS
SELECT
    customer_id,
    bitcoin_addr AS wallet_address,
    btc AS balance,
    date_of_creation AS created_at
FROM wallet_addr;
```

## Example: enforce non-negative balance

```sql
CREATE OR REPLACE FUNCTION check_non_negative_balance()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.balance < 0 THEN
        RAISE EXCEPTION 'Balance cannot be negative';
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER balance_check
BEFORE UPDATE ON customer_wallets
FOR EACH ROW
EXECUTE FUNCTION check_non_negative_balance();
```

Test it:

```sql
UPDATE customer_wallets
SET balance = -10
WHERE customer_id = 1;
```

You should see an error indicating the trigger blocked the update.

## Dialect notes (only where different)

- MySQL/MariaDB: trigger body is written directly in `CREATE TRIGGER ... BEGIN ... END`; client often needs `DELIMITER`.
- Microsoft SQL Server: triggers are statement-level (not `FOR EACH ROW`) and use `inserted`/`deleted` pseudo-tables.
- All three engines define triggers on tables, not on the whole database.
# Lets learn how to create a user-defined function (UDF)

UDFs are reusable functions you define in the database and call from SQL queries.

## PostgreSQL-safe default

### Scalar function example

```sql
CREATE OR REPLACE FUNCTION hello_name(name_text TEXT)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN 'Hello, ' || name_text;
END;
$$;
```

### Aggregate-like helper function example

```sql
CREATE OR REPLACE FUNCTION sum_btc()
RETURNS NUMERIC(12, 7)
LANGUAGE plpgsql
AS $$
DECLARE
    v_sum NUMERIC(12, 7);
BEGIN
    SELECT COALESCE(SUM(btc), 0)
    INTO v_sum
    FROM wallet_addr;

    RETURN v_sum;
END;
$$;
```

Call it:

```sql
SELECT sum_btc();
```

### Parameterized function example

```sql
CREATE OR REPLACE FUNCTION sum_btc_by_country(p_country TEXT)
RETURNS NUMERIC(12, 7)
LANGUAGE plpgsql
AS $$
DECLARE
    v_sum NUMERIC(12, 7);
BEGIN
    SELECT COALESCE(SUM(btc), 0)
    INTO v_sum
    FROM wallet_addr
    WHERE country = p_country;

    RETURN v_sum;
END;
$$;
```

Call it:

```sql
SELECT sum_btc_by_country('Greece') AS greece_total_btc;
```

## Useful built-ins across engines

```sql
SELECT CURRENT_USER;
SELECT CURRENT_TIMESTAMP;
```

## Dialect notes (only where different)

- MySQL/MariaDB:
  - Use `CREATE FUNCTION ... RETURNS ...` with routine body syntax.
  - In many clients, `DELIMITER` is needed when creating multi-statement functions.
  - Use `SHOW VARIABLES LIKE 'max_connections%';` for server variables.

- Microsoft SQL Server:
  - Scalar function style: `CREATE OR ALTER FUNCTION ... RETURNS ... AS BEGIN ... END`.
  - System metadata uses DMVs/catalog views instead of `SHOW VARIABLES`.

## Notes

- The `LANGUAGE JAVASCRIPT`/`LANGUAGE PHP` style is not a general portable SQL pattern.
- Keep function logic deterministic when possible, and test with realistic data sizes.


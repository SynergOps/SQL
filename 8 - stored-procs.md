# Lets learn about stored procedures

Stored procedures let you save reusable SQL routines and execute them with `CALL`.

## PostgreSQL-safe default

General structure:

```sql
CREATE OR REPLACE PROCEDURE procedure_name(parameter_1 data_type, parameter_2 data_type)
LANGUAGE plpgsql
AS $$
BEGIN
    -- instructions
END;
$$;
```

Assume we want to get wallet count for a country.

```sql
CREATE OR REPLACE PROCEDURE get_wallet_addr_count_by_country(IN p_country TEXT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_count BIGINT;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM wallet_addr
    WHERE country = p_country;

    RAISE NOTICE 'wallet_addr count in %: %', p_country, v_count;
END;
$$;
```

Call it:

```sql
CALL get_wallet_addr_count_by_country('Greece');
```

Drop it:

```sql
DROP PROCEDURE get_wallet_addr_count_by_country;
```

## Procedure with input and output behavior (PostgreSQL `INOUT`)

```sql
CREATE OR REPLACE PROCEDURE get_wallet_addr_count_by_country_inout(
    IN p_country TEXT,
    INOUT p_wallet_addr_count BIGINT
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COUNT(*) INTO p_wallet_addr_count
    FROM wallet_addr
    WHERE country = p_country;
END;
$$;
```

```sql
CALL get_wallet_addr_count_by_country_inout('Greece', NULL);
```

## Dialect notes (only where different)

- MySQL/MariaDB:
  - Procedure body is written as `CREATE PROCEDURE ... BEGIN ... END`.
  - In CLI tools, `DELIMITER` is usually needed while creating the routine.
  - `OUT` parameters are common, e.g. `CALL proc_name('Greece', @v); SELECT @v;`.

- Microsoft SQL Server:
  - Use `CREATE OR ALTER PROCEDURE ... AS BEGIN ... END`.
  - Execute with `EXEC`.
  - Output parameters use `@param INT OUTPUT`.
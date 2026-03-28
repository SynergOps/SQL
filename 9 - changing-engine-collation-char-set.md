# Lets learn about collation, character set and storage engine

This lesson uses PostgreSQL-safe defaults and shows alternatives only where syntax differs.

## PostgreSQL-safe default

Check database settings:

```sql
SELECT datname, datcollate, datctype
FROM pg_database
WHERE datname = current_database();
```

Check column collations in a table:

```sql
SELECT table_schema, table_name, column_name, collation_name
FROM information_schema.columns
WHERE table_name = 'wallet_addr';
```

Set collation for a text column:

```sql
ALTER TABLE wallet_addr
ALTER COLUMN country TYPE text COLLATE "C";
```

## Dialect notes (only where different)

- MySQL/MariaDB:
	- You can set character set/collation at database and table level:
	- `ALTER DATABASE db_name DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_general_ci;`
	- `ALTER TABLE db_name.table_name CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;`
	- Storage engine is configurable per table (e.g. `ENGINE=InnoDB`).

- Microsoft SQL Server:
	- Collation can be set per database/column:
	- `ALTER DATABASE db_name COLLATE Latin1_General_100_CI_AS;`
	- `ALTER TABLE t ALTER COLUMN c NVARCHAR(100) COLLATE Latin1_General_100_CI_AS;`
	- There is no MySQL-style pluggable table engine option.

## Conclusion

Collation and character set decisions affect sorting, comparison, and indexing behavior.
Always test changes on staging data before applying them in production.

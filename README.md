# SQL Training Material used in sessions

This repository is used during training sessions on SQL.
It contains a collection of SQL lessons designed to help users learn and practice various aspects of practical use of SQL. Each lesson includes step-by-step instructions and exercises
that users can work through to gain a deeper understanding of SQL syntax and functionality.

The repository includes a mock database that you can import and use for practicing SQL commands. The mock database contains sample table and data that you can query using SQL commands that are described in the provided lessons.

# Mock Scenario: Bitcoin Custody Service Startup

## Background

Imagine you're working for a Bitcoin custody service startup called **"GetRekt"**. 
The company provides secure storage and management solutions for Bitcoin users, allowing them to
store their private keys and manage their Bitcoin balances securely.

Your team has developed a database that stores user information, bitcoin wallet addresses, balances and other relevant data. Your task is to help design queries and analyze the database to
provide insights into user behavior and Bitcoin transactions. 

This mock scenario, as used during training sessions, provides a clear context and purpose for the database, making it easier for students to understand why certain SQL queries are relevant and how they can be
applied in real-world applications. It also makes learning more engaging by connecting the exercises to a plausible narrative.

---

## What is this repository?

- An educational resource for learning SQL
- Contains practical SQL examples and lessons
- Includes a ready-to-use mock database for practicing SQL queries

## Getting Started

This repository assumes that you know how to install an RDBMS and use a SQL client.

1. **Clone the Repository**
```sh
   git clone https://github.com/synergops/sql.git
```
2. **Set Up a Database**
   - Install PostgreSQL, MySQL, MariaDB, or Microsoft SQL Server
   - Create a new database or use an existing one
   - Import the portable seed file (`wallet_addr.portable.sql`) into your database
   - If you use MySQL/MariaDB, you can use the native dump wrapper (`wallet_addr.mysql.sql`)

## Lessons Overview

| # | Lesson | Dataset | Topics |
|---|--------|---------|--------|
| 0 | Intro to SQL | — | Database/table creation, INSERT, SELECT basics |
| 1 | Simple Query | `wallet_addr` | SELECT, WHERE, DISTINCT, filtering |
| 2 | Manipulation Query | `wallet_addr` | Aliasing, computed columns, CREATE TABLE AS, UPDATE, DELETE |
| 3 | Joins | `wallet_addr` | INNER JOIN, LEFT JOIN, RIGHT JOIN, CROSS JOIN |
| 4 | Aggregation & String Functions | `wallet_addr` | COUNT, SUM, AVG, MIN, MAX, string manipulation |
| 5 | Views | `wallet_addr` | CREATE VIEW, virtual tables, query abstraction |
| 6 | Triggers | `wallet_addr` | Event-driven logic, business rules, data integrity |
| 7 | Computed Columns | `wallet_addr` | Generated columns, age calculations, date arithmetic |
| 8 | Stored Procedures | `wallet_addr` | Reusable routines, parameters, encapsulation |
| 9 | Collation, Character Set, Engine | `wallet_addr` | Database configuration, encoding, MySQL-specific features |
| 10 | User-Defined Functions | `wallet_addr` | Scalar & aggregate functions, code reuse |
| 11 | UDF vs Stored Procedures | — | Theory: when to use each pattern |
| 12 | Common Table Expressions | `wallet_addr` | CTEs, WITH clauses, recursive queries, readability |
| 13 | World Database Queries | `world` | Multi-table joins, window functions, CTEs, complex filtering |
| 14 | Student Records | `iekstudents` | Data quality, aggregation, reporting, practical scenarios |

## Available Datasets

- **`wallet_addr`** (GetRekt Bitcoin custody scenario): 12 sample customers with wallet addresses and balances
- **`world`** (Geography/demographics): 239 countries, ~4,000 cities, language data
- **`iekstudents`** (Student meal preferences): Sample student records with dining preferences

## SQL Dialect Approach

- The lessons use a PostgreSQL-safe default syntax.
- Where syntax differs, a short alternative is provided for MySQL/MariaDB and Microsoft SQL Server.

## SQL Dump Naming

- `*.portable.sql`: cross-dialect, PostgreSQL-safe seed/schema scripts
- `*.mysql.sql`: MySQL/MariaDB-native dump entry files
- Legacy dump filenames are currently kept for compatibility and are referenced by the `*.mysql.sql` wrappers.

Current mapping:
- `wallet_addr.sql` -> `wallet_addr.mysql.sql`
- `iekstudents.sql` -> `iekstudents.mysql.sql`
- `world-db/world.sql` -> `world-db/world.mysql.sql`

## License

The content, files, and material in this repository are released under the GPL-3.0 License for anyone interested in learning or teaching SQL.
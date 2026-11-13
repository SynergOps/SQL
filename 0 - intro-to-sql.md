# Lets learn how to create a database and add data 

SQL (Structured Query Language) is the standard language for storing, managing, and retrieving data in relational databases. A relational database organizes data into **tables** (rows and columns), where each row represents an individual record and each column defines a specific attribute. A Relational Database Management System (RDBMS) like PostgreSQL, MySQL, MariaDB, or Microsoft SQL Server is the software engine that runs the database.

Create a new database
```sql
CREATE DATABASE my_database;
```
Connect to the new database (`wallets` in this repository's examples).
Create a new table
```sql
CREATE TABLE my_table (
  column0 INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  column1 INTEGER,
  column2 VARCHAR(50),
  column3 DATE
  );
```
Dialect note:
- MySQL/MariaDB: `column0 INT AUTO_INCREMENT PRIMARY KEY`
- Microsoft SQL Server: `column0 INT IDENTITY(1,1) PRIMARY KEY`
Insert data into the table
```sql
INSERT INTO my_table (column1, column2, column3) 
VALUES (42, 'A string', '2018-01-01');
```
Retrieve everything from the table / Query the table
```sql
SELECT * FROM my_table;
```
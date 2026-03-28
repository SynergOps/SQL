# Lets learn how to create a database and add data 

Create a new database
```sql
CREATE DATABASE my_database;
```
Connect to the new database (`wallets` in this repository examples).
Create a new table
```sql
CREATE TABLE my_table (
  column0 INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  column1 INTEGER,
  column2 VARCHAR(50),
  column3 DATE
  );
```
Insert data into the table
```sql
INSERT INTO my_table (column1, column2, column3) 
VALUES (42, 'A string', '2018-01-01');
```
Retrive everything from the table / Query the table
```sql
SELECT * FROM my_table;
```
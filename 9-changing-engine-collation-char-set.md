## Lets learn how to change the Collate, Character Set and storage engine in MySQL

First lets see the current character set and collate of the database and table of `some_database` and `some_table`
```sql
SHOW CREATE DATABASE `the_database_name`;
SHOW CREATE TABLE `the_database_name`.`the_table_name`;
```
Now lets change the character set and collate of the database
```sql
ALTER DATABASE `the_database_name`
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_general_ci;
```
lets see the current storage engine of the table
```sql
SHOW TABLE STATUS FROM the_database_name WHERE Name = 'the_table_name';
```
Now lets change the storage engine of the table
```sql
ALTER TABLE the_database_name.the_table_name ENGINE = InnoDB;
```
Now lets see the current storage engine of the table
```sql
SHOW TABLE STATUS FROM the_database_name WHERE Name = 'the_table_name';
```
Now lets change the character set and collate of the table
```sql
ALTER TABLE the_database_name.the_table_name 
COLLATE=utf8mb4_general_ci;
```
Now lets see the current character set and collate of the table
```sql
SHOW CREATE TABLE `the_database_name`.`the_table_name`;
```
# conclusion:
We can change the character set, collate and storage engine of the database 
and table in MySQL using the above commands. Caution should be taken while changing the 
character set and collate as it may affect the data in the table. For example if the
character set is changed from latin1 to utf8mb4 then the data in the table may be corrupted.

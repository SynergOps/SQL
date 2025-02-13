# Lets learn how to create a user defined function in MySQL

**User-Defined Functions (UDFs)** in MySQL, which allow developers to create
custom functions within stored procedures or functions that can perform specific tasks or operations.

In MySQL, UDFs are stored routines that can be created using various languages such as JavaScript or PHP. These
functions can be used to extend the functionality of MySQL by adding custom logic beyond what is available with
built-in SQL functions.

## Types of User defined functions

### Scalar UDFs
   - Scalar UDFs perform operations on a single value and return a single value.
   - Example: Using JavaScript or PHP to implement mathematical operations, string manipulation, date/time functions,
etc.
   - Syntax:
```sql
    DELIMITER //

    CREATE FUNCTION example_function(name VARCHAR(50)) RETURNS VARCHAR(50)
    BEGIN
        RETURN CONCAT("Hello, ", name);
    END //

    DELIMITER ;
```
  - This function will return a concatenated string based on the input `name`.

### Aggregation UDFs
   - Aggregation UDFs process multiple rows and return a single result.
   - These are used when you need to perform custom aggregations (e.g., calculate totals, averages, or other metrics)
across a set of rows.
   - Example:
```sql
    DELIMITER //

    CREATE FUNCTION sum_custom(num1 INT, num2 INT) RETURNS INT
    BEGIN
        RETURN num1 + num2;
    END //

    DELIMITER ;
```
   - This function will return the sum of two integers.

### Stored UDFs
   - Stored UDFs are stored in the database and can be called from multiple sessions.
   - Example:
```sql
    DELIMITER //

    CREATE FUNCTION example_stored(name VARCHAR(50)) RETURNS VARCHAR(50)
    BEGIN
        RETURN CONCAT("Hello, ", name);
    END //

    DELIMITER ;
```
   - This function is defined within the database and can be used in queries.

### Asynchronous UDFs
   - Asynchronous UDFs (introduced in MySQL 5.5) allow you to perform CPU-intensive tasks outside of the main thread,
reducing the load on the server.
   - Example:
```sql
    DELIMITER //

    CREATE FUNCTION compute_async_operation(args BLOB) RETURNS INT
    BEGIN
        -- Perform CPU-intensive operations here
        RETURN 0;
    END //

    DELIMITER ;
```
   - These are useful for tasks like file I/O or heavy computations.

### Security-Related UDFs
   - MySQL also provides built-in UDFs for security-related tasks, such as checking if a value is numeric
(`ISNUMERIC()`) or validating passwords.
   - Example:
```sql
    DELIMITER //

    CREATE FUNCTION validate_password(plain VARCHAR(50)) RETURNS VARCHAR(50)
    BEGIN
        IF LENGTH(plain) < 8 OR plain NOT REGEXP '^[A-Za-z0-9!@#$%^&*]+$' THEN
            RETURN "Password must be at least 8 characters and contain special characters!";
        END IF;
        RETURN "Valid password!";
    END //

    DELIMITER ;
```
### System Functions
- MySQL provides several **system functions** that allow you to retrieve or modify system-related information
within queries. These functions are often used for debugging, obtaining version information, or performing
system-specific operations

   - Return the username associated with the current connection.
   ```sql
   SELECT CURRENT_USER();
   ```
   Example output:
   ```
   'user@example.com'
   ```
   - Returns the version of MySQL.
   ```sql
   SELECT VERSION();
   ```
   Example output:
   ```
   '8.0.34-15'
   ```
   - Returns the current timestamp.
   ```sql
   SELECT CURRENT_TIMESTAMP();
   ```
   Example output:
   ```
   '2024-04-20 14:38:12'
   ```
   - Displays system and configuration parameters (e.g., `[mysqld]` configuration variables).
   ```sql
   SHOW VARIABLES LIKE 'max_connections%';
   ```
   Example output:
   ```
   '% max_connections=100'
   ```
### Custom UDFs Using Third-Party Languages

MySQL supports UDFs written in various languages, such as:

- **JavaScript**: You can use `CREATE FUNCTION` with the JavaScript language.
```sql
    DELIMITER //

    CREATE FUNCTION js_hello(name VARCHAR(50)) RETURNS VARCHAR(50)
        LANGUAGE JAVASCRIPT
    BEGIN
        RETURN "Hello, " + name;
    END //

    DELIMITER ;
```

- **PHP**: Use `CREATE FUNCTION` with PHP (on supported platforms).
```sql
    DELIMITER //

    CREATE FUNCTION php_hello(name VARCHAR(50)) RETURNS VARCHAR(50)
        LANGUAGE PHP
    BEGIN
        return "Hello, " . $name;
    END //

    DELIMITER ;
```
These examples demonstrate how to create simple UDFs using JavaScript, PHP.

### Key Points to Remember:
- UDFs allow you to extend MySQL's functionality beyond built-in functions.
- Always test UDFs thoroughly before relying on them in production environments.
- Use UDFs cautiously, as they can impact performance depending on their implementation (e.g., CPU-intensive
operations).

### Additional Resources:

- [MySQL User-Defined Functions](https://dev.mysql.com/doc/refman/8.0/en/udf.html)
- [MySQL Stored Functions](https://dev.mysql.com/doc/refman/8.0/en/stored-functions.html)
- [MySQL Aggregation Functions](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html)
- [MySQL Asynchronous Functions](https://dev.mysql.com/doc/refman/8.0/en/create-function-udf.html)
- [MySQL Security Functions](https://dev.mysql.com/doc/refman/8.0/en/security-functions.html)
- [MySQL System Functions](https://dev.mysql.com/doc/refman/8.0/en/information-functions.html)

### Examples:

Create a simple UDF that returns the sum of the BTC stored in the btc column of the `wallet_addr` table in the `wallets` database.
```sql
DELIMITER //

CREATE FUNCTION sum_btc() RETURNS DECIMAL(10, 2) -- Returns the sum of BTC as a decimal value
    DETERMINISTIC -- Ensures the function always returns the same result for the same input
BEGIN
    DECLARE sum_btc DECIMAL(10, 2); -- Declare a variable to store the sum of BTC
    SELECT SUM(btc) INTO sum_btc -- Calculate the sum of BTC from the wallet_addr table and store it in the variable
    FROM wallets.wallet_addr;
    RETURN sum_btc;
END //

DELIMITER ;
```
This function will return the total sum of BTC stored in the `wallet_addr` table.

Now, you can call this function in a query to get the total sum of BTC:
```sql
SELECT sum_btc();
```
Now lets create a function that takes parameters. For example lets create a function that takes as input a country name from the `country` column then calculates the sum of btc that is stored in `btc` column of the given country.
```sql
DELIMITER //

CREATE FUNCTION sum_btc_by_country(country_name VARCHAR(50)) RETURNS DECIMAL(10, 2)
    DETERMINISTIC -- Ensures the function always returns the same result for the same input
BEGIN
    DECLARE sum_btc DECIMAL(10, 2); -- Declare a variable to store the sum of BTC
    SELECT SUM(btc) INTO sum_btc -- Calculate the sum of BTC from the wallet_addr table for the given country and store it in the variable
    FROM wallets.wallet_addr
    WHERE country = country_name;
    RETURN sum_btc;
END //

DELIMITER ;
```
Now you can call this function with a specific country name to get the total sum of BTC for that country:
```sql
SELECT country AS `Country`, sum_btc_by_country('Greece');
```


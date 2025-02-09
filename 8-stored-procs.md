## Lets learn about stored procedures

Stored procedures are a way to store SQL code that you want to run over and over again
They are precompiled and stored in the database, so they are faster than running the same SQL code over and over again
are named objects that contain one or more instructions laid out and then executed by the database in a sequence when called. 
In the most basic example, a stored procedure can save a common statement under a reusable routine, such as retrieving data 
from the database with often-used filters

Here is the general structure of a stored procedure
```sql
DELIMITER //
CREATE PROCEDURE procedure_name(parameter_1, parameter_2, . . ., parameter_n)
BEGIN
    instruction_1;
    instruction_2;
    . . .
    instruction_n;
END //
DELIMITER ;
```
The first and last instructions in this code fragment are DELIMITER // and DELIMITER ;. 
Usually, MySQL uses the semicolon symbol (;) to delimit statements and indicate when they start and end. 
If you execute multiple statements in the MySQL console separated with semicolons, 
they will be treated as separate commands and executed independently, one after another. 
However, the stored procedure can enclose multiple commands that will be executed sequentially when it gets called. 
This poses a difficulty when trying to tell MySQL to create a new procedure. 
The database engine would encounter the semicolon sign in the stored procedure body and think it should stop executing the statement. 
In this situation, the intended statement is the whole procedure creation code, not a single instruction within the procedure itself,
so MySQL would misinterpret your intentions.

To work around this limitation, you use the DELIMITER command to temporarily change the delimiter from ; to // for 
the duration of the CREATE PROCEDURE call. 
Then, all semicolons inside the stored procedure body will be passed to the server as-is.
After the whole procedure is finished, the delimiter is changed back to ; with the last DELIMITER ;.

So we have our `wallet_addr` table from the previous lesson. In that table we have a `country` column.
Lets assume that we want to get the number of wallet addresses in a particular country e.g. `Greece`.
We can write a stored procedure to do that for us if we use it regularly in our application.

Here is the stored procedure to get the number of wallet addresses in a given country
```sql
USE wallets;
CREATE PROCEDURE get_wallet_addr_count_by_country(IN country_name VARCHAR(255))
BEGIN
    SELECT COUNT(*) FROM wallet_addr WHERE country = country_name;
END;
```
Lets break down the stored procedure
- `USE wallets;` - This is the database we are going to use
- `CREATE PROCEDURE get_wallet_addr_count_by_country(IN country_name VARCHAR(255))` - This is the name of the stored procedure and it takes one parameter `country_name` which is a string
- `BEGIN` - This is the start of the stored procedure
- `SELECT COUNT(*) FROM wallet_addr WHERE country = country_name;` - This is the SQL code that we want to run
- `END;` - This is the end of the stored procedure

Now lets call the stored procedure to get the number of wallet addresses in `Greece`
```sql
CALL get_wallet_addr_count_by_country('Greece');
```
If we want to delete the stored procedure we can do that by running the following command
```sql
DROP PROCEDURE get_wallet_addr_count_by_country;
```
# Creating a Stored Procedure with Input and Output Parameters
In the previous example, we created a stored procedure with an input parameter.
We can also create a stored procedure with an output parameter.
Here is an example of a stored procedure with an input and output parameter
```sql
CREATE PROCEDURE get_wallet_addr_count_by_country(IN country_name VARCHAR(255), OUT wallet_addr_count INT)
BEGIN
    SELECT COUNT(*) INTO wallet_addr_count FROM wallet_addr WHERE country = country_name;
END;
```
Lets break down the stored procedure
- `CREATE PROCEDURE get_wallet_addr_count_by_country(IN country_name VARCHAR(255), OUT wallet_addr_count INT)` - This is the name of the stored procedure and it takes two parameters `country_name` which is a string and `wallet_addr_count` which is an integer
- `BEGIN` - This is the start of the stored procedure
- `SELECT COUNT(*) INTO wallet_addr_count FROM wallet_addr WHERE country = country_name;` - This is the SQL code that we want to run
- `END;` - This is the end of the stored procedure

Now lets call the stored procedure to get the number of wallet addresses in `Greece`
```sql
CALL get_wallet_addr_count_by_country('Greece', @wallet_addr_count); -- This will store the number of wallet addresses in Greece in the variable @wallet_addr_count
SELECT @wallet_addr_count; -- This will print the number of wallet addresses in Greece
```
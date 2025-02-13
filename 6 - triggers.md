## Lets learn about triggers
Triggers are a way to execute a set of commands when an event occurs on a table.
The event can be an insert, update or delete in a table.
The commands can be a set of SQL commands or a call to a stored procedure.
Triggers are useful for enforcing business rules, auditing, and maintaining referential integrity.
Triggers are defined using the CREATE TRIGGER statement.

# Syntax
```
CREATE TRIGGER trigger_name 
BEFORE/AFTER INSERT/UPDATE/DELETE 
ON table_name 
FOR EACH ROW 
BEGIN 
    trigger body 
END;
```

In our `wallet_addr` table, we have a column `balance` which should not be negative.
We can create a trigger to enforce this rule.
If a user tries to update the balance to a negative value, the trigger will rollback the transaction.
If you already have the `customer_wallets` table, from the previous sections then you can skip the following part.
If not, you can create the `customer_wallets` table using the following SQL statement using columns from the `wallet_addr` table.

Create the customer_wallets table:
```sql
CREATE TABLE customer_wallets AS
SELECT
    customer_id AS `Customer ID`,
    bitcoin_addr AS 'Wallet Address',
    btc AS 'Balance',
    date_of_creation AS 'Created At'
FROM
    wallet_addr;
```

Create a trigger in MySQL databes to enforce the balance to be non-negative:
```sql
DELIMITER $$ -- Change the delimiter to `$$` to avoid conflicts with the default delimiter `;`
CREATE TRIGGER balance_check
BEFORE UPDATE -- Trigger will be executed before an update operation
ON customer_wallets
FOR EACH ROW
BEGIN
    IF NEW.`Balance` < 0 THEN -- Check if the new balance is negative
        SIGNAL SQLSTATE '45000' -- Raise an error with SQLSTATE code 45000 which is a generic error code indicating an exception
        SET MESSAGE_TEXT = 'Balance cannot be negative';
    END IF;
END$$
DELIMITER ; -- Reset the delimiter back to `;`
```
Now, let's try to update the balance to a negative value
```sql
UPDATE customer_wallets
SET `Balance` = -10
WHERE `Customer ID` = 1;
```
You should see an error message like `Error Code: 1644. Balance cannot be negative` indicating that the trigger has prevented the update operation.
You can also create triggers for other events like INSERT and DELETE to enforce business rules, maintain referential integrity, or perform auditing tasks.

The error you're encountering is due to the incorrect use of `ON DATABASE` in the `CREATE TRIGGER` statement. MySQL does not support database-level triggers directly. Triggers in MySQL are defined on specific tables, not on the entire database.

Note that MySQL does not support database-level triggers directly. Triggers in MySQL are defined on specific tables, not on the entire database.
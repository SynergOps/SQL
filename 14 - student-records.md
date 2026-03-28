# Working with Student Records

Learn practical SQL skills using a student database. This lesson demonstrates real-world scenarios such as managing student records, tracking meal preferences, and generating reports.

## Setup

Create a new database and import the student dataset:

```bash
# PostgreSQL
createdb iekstudents
psql iekstudents < iekstudents.portable.sql

# MySQL/MariaDB
mysql -u root -p -e "CREATE DATABASE iekstudents;"
mysql -u root -p iekstudents < iekstudents.mysql.sql
```

Or in your SQL client:
```sql
CREATE DATABASE iekstudents;
USE iekstudents;
-- Then import iekstudents.portable.sql (PostgreSQL) or iekstudents.mysql.sql (MySQL/MariaDB)
```

The database contains student information with meal preferences:
- `dinners`: Student records with names, birthdates, and meal preferences (entree, side, dessert)

## Basic Queries

### List all students

```sql
SELECT id, name, birthdate, entree, side, dessert
FROM dinners
ORDER BY name;
```

### Find students by entree preference

```sql
SELECT id, name, birthdate, entree, side, dessert
FROM dinners
WHERE entree = 'Chicken'
ORDER BY name;
```

### Students born after a specific year

```sql
SELECT id, name, birthdate, entree, side, dessert
FROM dinners
WHERE EXTRACT(YEAR FROM birthdate) > 2000
ORDER BY birthdate DESC;
```

**Dialect note:**
- PostgreSQL: `EXTRACT(YEAR FROM birthdate)`
- MySQL/MariaDB: `YEAR(birthdate)`
- Microsoft SQL Server: `YEAR(birthdate)`

## Meal Preferences Analysis

### Count preferences by entree

```sql
SELECT 
    entree,
    COUNT(*) AS student_count,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM dinners), 2) AS percentage
FROM dinners
WHERE entree IS NOT NULL
GROUP BY entree
ORDER BY COUNT(*) DESC;
```

### Popular side dishes

```sql
SELECT 
    side,
    COUNT(*) AS count
FROM dinners
WHERE side IS NOT NULL
GROUP BY side
ORDER BY COUNT(*) DESC;
```

### Combination analysis: Entree + Side

```sql
SELECT 
    entree,
    side,
    COUNT(*) AS combination_count
FROM dinners
WHERE entree IS NOT NULL AND side IS NOT NULL
GROUP BY entree, side
ORDER BY COUNT(*) DESC;
```

## Age Calculations

### Calculate student ages

```sql
SELECT 
    id,
    name,
    birthdate,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, birthdate))::INT AS age,
    entree,
    side,
    dessert
FROM dinners
ORDER BY age;
```

**Dialect note:**
- PostgreSQL: `EXTRACT(YEAR FROM AGE(CURRENT_DATE, birthdate))`
- MySQL/MariaDB: `TIMESTAMPDIFF(YEAR, birthdate, CURDATE())`
- Microsoft SQL Server: `DATEDIFF(YEAR, birthdate, CAST(GETDATE() AS DATE))`

### Students by age group

```sql
SELECT 
    CASE 
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, birthdate)) < 18 THEN 'Under 18'
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, birthdate)) < 21 THEN '18-20'
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, birthdate)) < 25 THEN '21-24'
        ELSE '25+'
    END AS age_group,
    COUNT(*) AS student_count
FROM dinners
WHERE birthdate IS NOT NULL
GROUP BY age_group
ORDER BY age_group;
```

## Data Quality Checks

### Find students with missing preferences

```sql
SELECT 
    id,
    name,
    birthdate,
    entree,
    side,
    dessert
FROM dinners
WHERE entree IS NULL OR side IS NULL OR dessert IS NULL
ORDER BY name;
```

### Count students by completeness

```sql
SELECT 
    CASE 
        WHEN entree IS NOT NULL AND side IS NOT NULL AND dessert IS NOT NULL THEN 'Complete'
        WHEN entree IS NOT NULL OR side IS NOT NULL OR dessert IS NOT NULL THEN 'Partial'
        ELSE 'Missing'
    END AS preference_status,
    COUNT(*) AS count
FROM dinners
GROUP BY preference_status
ORDER BY count DESC;
```

## Sorting and Filtering

### Students by birthday (upcoming)

```sql
SELECT 
    id,
    name,
    birthdate,
    EXTRACT(MONTH FROM birthdate) AS birth_month,
    EXTRACT(DAY FROM birthdate) AS birth_day
FROM dinners
ORDER BY birth_month, birth_day;
```

### Students born in a specific month

```sql
SELECT 
    id,
    name,
    birthdate,
    entree,
    side,
    dessert
FROM dinners
WHERE EXTRACT(MONTH FROM birthdate) = 3  -- March
ORDER BY EXTRACT(DAY FROM birthdate);
```

**Dialect note:**
- PostgreSQL: `EXTRACT(MONTH FROM birthdate)`
- MySQL/MariaDB: `MONTH(birthdate)`
- Microsoft SQL Server: `MONTH(birthdate)`

## Text Manipulation

### Extract initials

```sql
SELECT 
    id,
    name,
    CONCAT(LEFT(name, 1), ' ') AS initials,
    entree
FROM dinners
ORDER BY name;
```

**Dialect note:**
- PostgreSQL: `SUBSTRING(name FROM 1 FOR 1)` or `LEFT(name, 1)` in some versions
- MySQL/MariaDB: `LEFT(name, 1)`
- Microsoft SQL Server: `LEFT(name, 1)`

### Find students by name pattern

```sql
-- Students whose names start with 'J'
SELECT id, name, birthdate, entree
FROM dinners
WHERE name ILIKE 'J%'  -- PostgreSQL (case-insensitive)
ORDER BY name;
```

**Dialect note:**
- PostgreSQL: Use `ILIKE` for case-insensitive matching
- MySQL/MariaDB: Use `LIKE` (usually case-insensitive by default)
- Microsoft SQL Server: Use `LIKE` (case depends on collation)

## Summary Reports

### Student distribution by entree

```sql
SELECT 
    entree,
    side,
    dessert,
    COUNT(*) AS count
FROM dinners
WHERE entree IS NOT NULL
GROUP BY entree, side, dessert
ORDER BY entree, COUNT(*) DESC;
```

### Preferences overview

```sql
SELECT 
    'Entree' AS preference_type,
    entree AS option,
    COUNT(*) AS count
FROM dinners
WHERE entree IS NOT NULL
GROUP BY entree

UNION ALL

SELECT 
    'Side' AS preference_type,
    side AS option,
    COUNT(*) AS count
FROM dinners
WHERE side IS NOT NULL
GROUP BY side

UNION ALL

SELECT 
    'Dessert' AS preference_type,
    dessert AS option,
    COUNT(*) AS count
FROM dinners
WHERE dessert IS NOT NULL
GROUP BY dessert

ORDER BY preference_type, count DESC;
```

## Practice Exercises

1. Find the most common entree/side/dessert combinations.
2. Create a report showing students older than 21 with their preferences.
3. Find students who prefer the same entree and sort by last birthday.
4. Count how many students have complete preference data by age group.
5. Create a query that shows which meal options are most popular among students born in each year.

---

**Database imports:** Use `iekstudents.portable.sql` for all SQL dialects, or `iekstudents.mysql.sql` if using MySQL/MariaDB directly.

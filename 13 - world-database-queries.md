# Advanced Queries with the World Database

Learn advanced query techniques using a realistic, multi-table dataset. The World database contains countries, cities, and language data.

## Setup

Create a new database and import the World dataset:

```bash
# PostgreSQL
createdb world
psql world < world-db/world.portable.sql

# MySQL/MariaDB
mysql -u root -p -e "CREATE DATABASE world;"
mysql -u root -p world < world-db/world.mysql.sql
```

Or in your SQL client:
```sql
CREATE DATABASE world;
USE world;
-- Then import world-db/world.portable.sql (PostgreSQL) or world-db/world.mysql.sql (MySQL/MariaDB)
```

The database contains three main tables:
- `country`: Country codes, names, continents, populations, GNP, etc.
- `city`: Cities with country codes, districts, populations
- `countrylanguage`: Languages spoken in each country with percentage of speakers

## Basic Queries

### Find all countries in Asia

```sql
SELECT code, name, continent, region, population
FROM country
WHERE continent = 'Asia'
ORDER BY population DESC;
```

### Find the most populous city in Europe

```sql
SELECT name, countrycode, district, population
FROM city
WHERE countrycode IN (SELECT code FROM country WHERE continent = 'Europe')
ORDER BY population DESC
LIMIT 1;
```

### List all official languages by country

```sql
SELECT c.name AS country, cl.language, cl.percentage
FROM country c
INNER JOIN countrylanguage cl ON c.code = cl.countrycode
WHERE cl.isofficial = 'T'
ORDER BY c.name, cl.percentage DESC;
```

## Aggregation Queries

### Count cities per country

```sql
SELECT 
    c.name AS country,
    COUNT(ci.id) AS city_count,
    SUM(ci.population) AS total_city_population
FROM country c
LEFT JOIN city ci ON c.code = ci.countrycode
GROUP BY c.code, c.name
ORDER BY city_count DESC
LIMIT 20;
```

### Average city population by continent

```sql
SELECT 
    c.continent,
    AVG(ci.population) AS avg_city_population,
    COUNT(DISTINCT ci.id) AS total_cities
FROM country c
INNER JOIN city ci ON c.code = ci.countrycode
GROUP BY c.continent
ORDER BY avg_city_population DESC;
```

### Languages per country

```sql
SELECT 
    c.name AS country,
    COUNT(cl.language) AS languages_spoken,
    STRING_AGG(cl.language, ', ' ORDER BY cl.language) AS language_list
FROM country c
LEFT JOIN countrylanguage cl ON c.code = cl.countrycode
GROUP BY c.code, c.name
HAVING COUNT(cl.language) > 0
ORDER BY COUNT(cl.language) DESC;
```

**Dialect note:**
- PostgreSQL: `STRING_AGG(cl.language, ', ')`
- MySQL/MariaDB: `GROUP_CONCAT(cl.language SEPARATOR ', ')`
- Microsoft SQL Server: `STRING_AGG(cl.language, ', ')`

## Multi-Table Joins

### Countries with their capital cities

```sql
SELECT 
    c.name AS country,
    c.continent,
    ci.name AS capital_city,
    ci.population AS capital_population,
    c.population AS country_population
FROM country c
LEFT JOIN city ci ON c.capital = ci.id
ORDER BY c.population DESC;
```

### Cities and their country information

```sql
SELECT 
    ci.name AS city,
    ci.district,
    c.name AS country,
    c.continent,
    c.region,
    ci.population AS city_population,
    c.population AS country_population
FROM city ci
INNER JOIN country c ON ci.countrycode = c.code
WHERE c.continent = 'Europe'
ORDER BY ci.population DESC
LIMIT 50;
```

## Window Functions

### Rank countries by population within each continent

```sql
SELECT 
    name,
    continent,
    population,
    RANK() OVER (PARTITION BY continent ORDER BY population DESC) AS continent_rank
FROM country
WHERE population > 0
ORDER BY continent, continent_rank;
```

### Calculate percentage of continent's population

```sql
SELECT 
    name,
    continent,
    population,
    ROUND(100.0 * population / SUM(population) OVER (PARTITION BY continent), 2) AS pct_of_continent
FROM country
WHERE population > 0
ORDER BY continent, population DESC;
```

**Dialect note:**
- PostgreSQL: Window functions with `PARTITION BY` and `ORDER BY` (shown above)
- MySQL 8.0+: Same syntax as PostgreSQL
- MySQL 5.7 and below: Use subqueries or temporary tables instead
- Microsoft SQL Server: Same syntax as PostgreSQL

## Complex Filtering

### Countries with more than 5 languages

```sql
SELECT 
    c.code,
    c.name,
    COUNT(cl.language) AS language_count
FROM country c
LEFT JOIN countrylanguage cl ON c.code = cl.countrycode
GROUP BY c.code, c.name
HAVING COUNT(cl.language) >= 5
ORDER BY language_count DESC;
```

### Cities in countries with multiple official languages

```sql
SELECT DISTINCT
    ci.name AS city,
    c.name AS country
FROM city ci
INNER JOIN country c ON ci.countrycode = c.code
WHERE c.code IN (
    SELECT countrycode
    FROM countrylanguage
    WHERE isofficial = 'T'
    GROUP BY countrycode
    HAVING COUNT(*) > 1
)
ORDER BY c.name, ci.name;
```

## Common Table Expressions (CTE)

### Find countries larger than the average

```sql
WITH country_stats AS (
    SELECT 
        AVG(population) AS avg_population,
        MIN(population) AS min_population,
        MAX(population) AS max_population
    FROM country
    WHERE population > 0
)
SELECT 
    c.name,
    c.continent,
    c.population,
    ROUND(c.population - cs.avg_population) AS diff_from_avg
FROM country c, country_stats cs
WHERE c.population > cs.avg_population
ORDER BY c.population DESC;
```

### Multi-level CTE: Cities with language data

```sql
WITH country_languages AS (
    SELECT 
        countrycode,
        COUNT(language) AS language_count,
        STRING_AGG(CASE WHEN isofficial = 'T' THEN language END, ', ') AS official_languages
    FROM countrylanguage
    GROUP BY countrycode
),
city_aggregates AS (
    SELECT 
        countrycode,
        COUNT(id) AS city_count,
        MAX(population) AS largest_city_pop
    FROM city
    GROUP BY countrycode
)
SELECT 
    c.name AS country,
    c.continent,
    ca.city_count,
    ca.largest_city_pop,
    cl.language_count,
    cl.official_languages
FROM country c
LEFT JOIN city_aggregates ca ON c.code = ca.countrycode
LEFT JOIN country_languages cl ON c.code = cl.countrycode
WHERE ca.city_count > 0
ORDER BY ca.city_count DESC;
```

## Practice Exercises

1. Find all cities in countries where English is an official language.
2. List the top 10 countries by GNP and their most populous city.
3. Create a view showing countries with their total urban population (sum of all cities).
4. Find continents where the average country population exceeds 10 million.
5. Identify countries where the largest city contains more than 5% of the country's population.

---

**Database imports:** Use `world-db/world.portable.sql` for all SQL dialects, or `world-db/world.mysql.sql` if using MySQL/MariaDB directly.

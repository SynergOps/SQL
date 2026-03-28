-- Portable SQL schema for the world dataset
-- Cross-dialect and PostgreSQL-safe.
-- This script includes schema and minimal seed rows.
-- For the full native dump data, use world.mysql.sql with MySQL/MariaDB.

BEGIN;

DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS countrylanguage;
DROP TABLE IF EXISTS country;

CREATE TABLE country (
    code CHAR(3) PRIMARY KEY,
    name CHAR(52) NOT NULL,
    continent VARCHAR(20) NOT NULL,
    region CHAR(26) NOT NULL,
    surfacearea NUMERIC(10,2) NOT NULL DEFAULT 0.00,
    indepyear SMALLINT,
    population INTEGER NOT NULL DEFAULT 0,
    lifeexpectancy NUMERIC(3,1),
    gnp NUMERIC(10,2),
    gnpold NUMERIC(10,2),
    localname CHAR(45) NOT NULL,
    governmentform CHAR(45) NOT NULL,
    headofstate CHAR(60),
    capital INTEGER,
    code2 CHAR(2) NOT NULL
);

CREATE TABLE city (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name CHAR(35) NOT NULL,
    countrycode CHAR(3) NOT NULL,
    district CHAR(20) NOT NULL,
    population INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT city_country_fk FOREIGN KEY (countrycode) REFERENCES country (code)
);

CREATE TABLE countrylanguage (
    countrycode CHAR(3) NOT NULL,
    language CHAR(30) NOT NULL,
    isofficial CHAR(1) NOT NULL DEFAULT 'F',
    percentage NUMERIC(4,1) NOT NULL DEFAULT 0.0,
    CONSTRAINT countrylanguage_pk PRIMARY KEY (countrycode, language),
    CONSTRAINT countrylanguage_country_fk FOREIGN KEY (countrycode) REFERENCES country (code),
    CONSTRAINT countrylanguage_isofficial_chk CHECK (isofficial IN ('T', 'F'))
);

INSERT INTO country (
    code, name, continent, region, surfacearea, indepyear, population,
    lifeexpectancy, gnp, gnpold, localname, governmentform, headofstate, capital, code2
) VALUES
('ABW', 'Aruba', 'North America', 'Caribbean', 193.00, NULL, 103000, 78.4, 828.00, 793.00, 'Aruba', 'Nonmetropolitan Territory of The Netherlands', 'Beatrix', NULL, 'AW');

INSERT INTO city (name, countrycode, district, population) VALUES
('Oranjestad', 'ABW', '-', 29034);

INSERT INTO countrylanguage (countrycode, language, isofficial, percentage) VALUES
('ABW', 'Dutch', 'T', 5.3),
('ABW', 'English', 'F', 9.5),
('ABW', 'Papiamento', 'F', 76.7),
('ABW', 'Spanish', 'F', 7.4);

COMMIT;

-- Portable SQL seed for the iekstudents dataset
-- Cross-dialect and PostgreSQL-safe.

BEGIN;

DROP TABLE IF EXISTS dinners;
DROP TABLE IF EXISTS tourneys;

CREATE TABLE dinners (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(30),
    birthdate DATE,
    entree VARCHAR(30),
    side VARCHAR(30),
    dessert VARCHAR(30)
);

INSERT INTO dinners (name, birthdate, entree, side, dessert) VALUES
('Manolis', '2003-01-19', 'steak', 'salad', 'cake'),
('Thanos', '2003-01-25', 'chicken', 'fries', 'ice cream'),
('Sara', '2005-02-18', 'tofu', 'fries', 'cake'),
('Elpida', '2004-12-25', 'tofu', 'salad', 'ice cream'),
('Georgia', '2006-05-28', 'steak', 'fries', 'ice cream'),
('Sali', '1990-01-01', 'chicken', 'fries', 'ice cream');

CREATE TABLE tourneys (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(30),
    wins DOUBLE PRECISION,
    best DOUBLE PRECISION,
    size DOUBLE PRECISION
);

INSERT INTO tourneys (name, wins, best, size) VALUES
('Manolis', 7, 245, 44),
('Thanos', 4, 280, 45),
('Sara', 9, 266, 38),
('Elpida', 2, 200, 37),
('Georgia', 2, 197, 37),
('Sali', 13, 283, 46);

COMMIT;

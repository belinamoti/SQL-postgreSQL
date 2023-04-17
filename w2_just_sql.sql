-- kill other connections
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'w2_just_sql' AND pid <> pg_backend_pid();
-- (re)create the database
DROP DATABASE IF EXISTS w2_just_sql;
CREATE DATABASE w2_just_sql;
-- connect via psql
\c w2_just_sql

-- database configuration
SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET default_tablespace = '';
SET default_with_oids = false;


CREATE TABLE products (
    id SERIAL,
    name TEXT NOT NULL,
    discontinued BOOLEAN NOT NULL,
    supplier_id INT,
    category_id INT,
    PRIMARY KEY (id)
);



CREATE TABLE orders (
    id SERIAL,
    item text NOT NULL,
    price INTEGER NOT NULL,
    customer_id INT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE customers (
    id SERIAL,
    name text NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE cars (
    id SERIAL,
    year INT,
    make TEXT NOT NULL,
    model TEXT NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE employees (
    id SERIAL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE territories (
    id SERIAL,
    description TEXT NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE employees_territories (
    employee_id INT,
    territory_id INT,
    PRIMARY KEY(employee_id, territory_id)
);



ALTER TABLE employees_territories
ADD CONSTRAINT fk_employee_territories_employees
FOREIGN KEY (employee_id)
REFERENCES employees (id);

-- INSERTING ROWS

INSERT INTO cars (year, make, model)
VALUES (2020, 'Toyota', 'Yaris');

INSERT INTO cars (year, make, model)
VALUES (2002, 'Acura', 'TL');


-- Adding new Column

ALTER TABLE cars
ADD color text;

ALTER TABLE cars
ADD wheel_count INT NOT NULL DEFAULT 4;
--

INSERT INTO cars (year, make, model, color, wheel_count)
VALUES (2010, 'Toyota', 'Yaris', 'red', 3);

INSERT INTO cars (year, make, model, wheel_count)
VALUES (2014, 'Honda', 'Civic', 2);
-- year will be null
INSERT INTO cars (make, model, color, wheel_count)
VALUES ('Chevy', 'Tahoe', 'black', 7);

INSERT INTO employees (first_name, last_name)
VALUES ('Moti', 'Belina');

INSERT INTO employees (first_name, last_name)
VALUES ('Kanu', 'Tolesa');

INSERT INTO territories (description)
VALUES ('A Software engineer');

INSERT INTO territories (description)
VALUES ('A mechanical engineer');

INSERT INTO employees_territories (employee_id, territory_id)
VALUES (1, 1);

-- Updating Tables where make is Honda replace it by Lexus

UPDATE cars
SET make = 'Lexus'
WHERE make = 'Honda';


-- Deleting Rows where year is NULL so this will delete the chevy row

DELETE FROM cars
WHERE year IS NULL;

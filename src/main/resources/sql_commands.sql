---------------------------------- DDL
-- CREATE
CREATE DATABASE online_store_db;

CREATE TABLE "user"
(
    id       SERIAL PRIMARY KEY,
    name     varchar,
    age      int,
    birthday DATE
);

CREATE TABLE address
(
    addressLine1 VARCHAR,
    addressLine2 VARCHAR(255),
    user_id      int REFERENCES "user" (id)
);

CREATE TABLE IF NOT EXISTS address
(
    address_line_1 VARCHAR,
    address_line_2 VARCHAR(255),
    user_id        int REFERENCES "user" (id)
);

-- ALTER
ALTER TABLE address
    RENAME COLUMN addressLine1 TO address_line_1;
ALTER TABLE address
    RENAME COLUMN addressLine2 TO address_line_2;

ALTER TABLE "user"
    ADD COLUMN phone_numbers VARCHAR[];

ALTER TABLE "user"
    DROP COLUMN phone_numbers;

-- DROP
DROP TABLE address;
DROP DATABASE online_store_db;
DROP TABLE IF EXISTS address;

---------------------------------- DSL
CREATE USER custom_user WITH PASSWORD 'admin';
GRANT ALL PRIVILEGES ON DATABASE online_store_db TO custom_user;

---------------------------------- DML
-- INSERT
INSERT INTO "user"(name, age, birthday)
VALUES ('John', 18, '2000-10-10');

INSERT INTO "user"
VALUES (DEFAULT, 'John', 18, '2000-10-10');

-- 1, 2, 3, 4, 5, 6, 7, 8, 9, [10]

-- UPDATE
UPDATE "user"
SET age = 19
WHERE name = 'John';

-- DELETE
DELETE FROM "user"
WHERE id = 9;

-- SELECT
SELECT * FROM "user";

SELECT id FROM "user";

-- where
SELECT * FROM "user" WHERE id = 1;

SELECT * FROM "user" WHERE age = 19;

SELECT * FROM "user" WHERE age > 22;

SELECT * FROM "user" WHERE age < 2;

-- and
SELECT * FROM "user" WHERE age > 22 AND name = 'John';

-- or
SELECT * FROM "user" WHERE age = 21 OR age = 22;

-- not
SELECT * FROM "user" WHERE NOT name = 'John';

-- Порядок выполнения: not, and, or
-- http://www.sql-tutorial.ru/ru/book_predicates_1/page2.html

-- order by
SELECT * FROM "user" ORDER BY age;

SELECT * FROM "user" ORDER BY age DESC;

-- выбрать все имена всех юзеров
SELECT name FROM "user";

-- выбрать уникальные имена всех юзеров
SELECT DISTINCT name FROM "user";



















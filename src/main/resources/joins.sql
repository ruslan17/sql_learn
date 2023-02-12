-- one to one
CREATE TABLE "user"
(
    id         SERIAL PRIMARY KEY,
    name       varchar NOT NULL,
    age        int,
    birthday   DATE,
    address_id BIGINT
);

CREATE TABLE address
(
    id          SERIAL PRIMARY KEY,
    addressLine VARCHAR
);

-- one to many
CREATE TABLE "order"
(
    id      SERIAL PRIMARY KEY,
    name    VARCHAR,
    user_id BIGINT REFERENCES "user" (id)
);

-- many to many
CREATE TABLE item
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR
);

SELECT o.name, i.name
FROM order_item
         JOIN "order" o on o.id = order_item.order_id
         JOIN item i on order_item.item_id = i.id;

-- SELECT o.name, i.name
-- FROM order_item, "order" o, item i
-- WHERE o.id = order_item.order_id AND order_item.item_id = i.id;

-- CREATE TABLE order_item_reference
CREATE TABLE order_item
(
    order_id BIGINT REFERENCES "order" (id),
    item_id  BIGINT REFERENCES item (id)
);



CREATE TABLE employee
(
    id            SERIAL PRIMARY KEY,
    name          VARCHAR(100),
    department_id INT,
    manager_id    BIGINT REFERENCES employee (id)
);

CREATE TABLE department
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

-- JOINS


-- INNER JOIN
SELECT e.name AS employee_name, d.name AS department_name
FROM employee e
         INNER JOIN department d ON e.department_id = d.id;

SELECT e.name AS employee_name, d.name AS department_name
FROM employee e
         JOIN department d ON e.department_id = d.id;

SELECT e.name AS employee_name, d.name AS department_name
FROM employee e,
     department d
WHERE e.department_id = d.id;

-- OUTER JOIN
-- LEFT
SELECT e.name AS employee_name, d.name AS department_name
FROM employee e
         LEFT OUTER JOIN department d ON e.department_id = d.id;

SELECT e.name AS employee_name, d.name AS department_name
FROM employee e
         LEFT JOIN department d ON e.department_id = d.id;

-- RIGHT
SELECT e.name AS employee_name, d.name AS department_name
FROM employee e
         RIGHT JOIN department d ON e.department_id = d.id;
-- тоже самое что left в обратную сторону
-- SELECT e.name AS employee_name, d.name AS department_name
-- FROM department d
--          LEFT JOIN employee e ON e.department_id = d.id;

-- FULL
SELECT e.name AS employee_name, d.name AS department_name
FROM employee e
         FULL JOIN department d ON e.department_id = d.id;

-- CROSS JOIN
SELECT e.name AS employee_name, d.name AS department_name
FROM employee e
         CROSS JOIN department d;

SELECT e.name AS employee_name, d.name AS department_name
FROM employee e,
     department d;

-- SELF JOIN
SELECT e.name AS employee_name, m.name AS manager_name
FROM employee e
         JOIN employee m ON e.manager_id = m.id;

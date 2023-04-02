
CREATE TABLE "user"
(
    id       SERIAL PRIMARY KEY,
    name     varchar,
    age      int,
    birthday DATE
);

CREATE INDEX idx_name ON "user"(name);
CREATE INDEX idx_name ON "user"(name, age);

CREATE FUNCTION add_numbers(a INTEGER, b INTEGER)
    RETURNS INTEGER AS
$$
BEGIN
    RETURN a + b;
END;
$$ LANGUAGE plpgsql;

SELECT add_numbers(2, 3);

-- Создаем функцию
CREATE FUNCTION update_last_updated()
    RETURNS TRIGGER AS
$$
BEGIN
    NEW.last_updated = NOW(); -- Обновляем поле last_updated
    RETURN NEW; -- Возвращаем измененную запись
END;
$$ LANGUAGE plpgsql;

-- Создаем триггер
CREATE TRIGGER update_last_updated
    BEFORE INSERT OR UPDATE
    ON users -- Определяем, на какие операции триггер будет реагировать
    FOR EACH ROW -- Определяем, что триггер должен выполняться для каждой строки
EXECUTE FUNCTION update_last_updated(); -- Указываем, какую функцию вызывать


CREATE VIEW customer_orders AS
SELECT customers.customer_name, orders.order_date, orders.total_amount
FROM customers
         JOIN orders ON customers.customer_id = orders.customer_id;


SELECT *
FROM customer_orders
WHERE customer_name = 'John Doe';



CREATE TABLE "user"
(
    id         SERIAL PRIMARY KEY,
    name       varchar,
    age        int,
    birthday   DATE,
    updated_on timestamp,
    deleted    boolean,
    money      int
);


-- functions/procedure
CREATE FUNCTION add_numbers(a INTEGER, b INTEGER)
    RETURNS INTEGER AS
$$
BEGIN
    RETURN a + b;
END;
$$ LANGUAGE plpgsql;

-- triggers
-- Создаем функцию
CREATE FUNCTION set_updated_on()
    RETURNS TRIGGER AS
$$
BEGIN
    NEW.updated_on = NOW(); -- Обновляем поле last_updated
    RETURN NEW; -- Возвращаем измененную запись
END;
$$ LANGUAGE plpgsql;

-- Создаем триггер
CREATE TRIGGER set_updated_on
    BEFORE INSERT OR UPDATE
    ON "user" -- Определяем, на какие операции триггер будет реагировать
    FOR EACH ROW -- Определяем, что триггер должен выполняться для каждой строки
EXECUTE FUNCTION set_updated_on();
-- Указываем, какую функцию вызывать

-- view
-- VIEW может быть использована для:
--
-- Сокрытия сложной структуры таблицы от пользователя. Например, можно создать VIEW, которая отображает только несколько полей из таблицы, скрывая сложные вычисления и преобразования, которые могут быть использованы для получения этих полей.
-- Обеспечения безопасности. Можно создать VIEW, которая отображает только необходимые поля из таблицы, скрывая конфиденциальные данные.
-- Упрощения работы с данными. Например, можно создать VIEW, которая объединяет данные из нескольких таблиц в единую таблицу, чтобы упростить выполнение запросов.
-- ещё: https://habr.com/ru/post/47031/

CREATE MATERIALIZED VIEW active_users AS
SELECT *
FROM "user"
where deleted <> TRUE;

CREATE MATERIALIZED VIEW m_active_users AS
SELECT *
FROM "user"
where deleted <> TRUE;

-- alter table "user" add column money int;

select *
from active_users;

BEGIN;
update "user" set money = money - 50 where id = 1;
update "user" set money = money + 50 where id = 3;
COMMIT;

select * from "user" where id = 1;

BEGIN;
UPDATE "user" SET name = 'Dan55' WHERE id = 1;
SAVEPOINT my_save;
UPDATE "user" SET name = 'Dan55' WHERE id = 3;
ROLLBACK TO my_save;
UPDATE "user" SET name = 'Dan55' WHERE id = 5;
COMMIT;




begin; --repeatable read
select * from "user";
-- some logic
select * from "user";
commit;

begin;
-- insert into "user"
commit;
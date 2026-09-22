PRAGMA foreign_keys = ON;

-- 1. Очистка старых таблиц
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- 2. Создание структуры БД
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT,
    email TEXT,
    phone TEXT,
    status TEXT DEFAULT 'active', -- active, inactive, banned
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    category TEXT NOT NULL,
    price REAL NOT NULL,
    stock_quantity INTEGER NOT NULL DEFAULT 0,
    is_available BOOLEAN DEFAULT 1
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status TEXT DEFAULT 'new', -- new, processing, completed, cancelled
    total_amount REAL DEFAULT 0.0,
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

CREATE TABLE order_items (
    item_id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price REAL NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders (order_id),
    FOREIGN KEY (product_id) REFERENCES products (product_id)
);

-- 3. Наполнение тестовыми данными
INSERT INTO customers (customer_id, first_name, last_name, email, phone, status, created_at) VALUES
(1, 'Иван', 'Петров', 'ivan.petrov@example.com', '+79991112233', 'active', '2026-01-10 10:00:00'),
(2, 'Анна', 'Сидорова', 'anna.sidorova@example.com', NULL, 'active', '2026-01-15 12:30:00'),
(3, 'Алексей', 'Смирнов', NULL, '+79993334455', 'inactive', '2026-02-01 09:15:00'),
(4, 'Елена', 'Ковалева', 'elena.k@example.com', '+79995556677', 'banned', '2026-02-10 16:45:00'),
(5, 'Дмитрий', 'Морозов', 'dmitry.m@example.com', NULL, 'active', '2026-03-01 11:20:00'),
(6, 'Ольга', 'Васильева', NULL, NULL, 'active', '2026-03-05 14:00:00');

INSERT INTO products (product_id, name, category, price, stock_quantity, is_available) VALUES
(101, 'Смартфон Alpha', 'Электроника', 29990.00, 15, 1),
(102, 'Ноутбук Pro 15', 'Электроника', 89990.00, 3, 1),
(103, 'Беспроводные наушники', 'Аксессуары', 4990.00, 0, 0),
(104, 'Механическая клавиатура', 'Аксессуары', 7500.00, 8, 1),
(105, 'Монитор 27"', 'Электроника', 22000.00, 5, 1),
(106, 'Защитное стекло', 'Аксессуары', 500.00, 100, 1);

INSERT INTO orders (order_id, customer_id, order_date, status, total_amount) VALUES
(1001, 1, '2026-02-15 14:20:00', 'completed', 37490.00),
(1002, 1, '2026-03-01 10:05:00', 'processing', 89990.00),
(1003, 2, '2026-03-02 16:40:00', 'completed', 5490.00),
(1004, 4, '2026-03-10 11:00:00', 'cancelled', 7500.00),
(1005, 5, '2026-03-12 18:30:00', 'new', 1000.00);

INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price) VALUES
(1, 1001, 101, 1, 29990.00),
(2, 1001, 104, 1, 7500.00),
(3, 1002, 102, 1, 89990.00),
(4, 1003, 103, 1, 4990.00),
(5, 1003, 106, 1, 500.00),
(6, 1004, 104, 1, 7500.00),
(7, 1005, 106, 1, 500.00);
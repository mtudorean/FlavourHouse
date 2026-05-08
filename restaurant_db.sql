CREATE DATABASE IF NOT EXISTS restaurant_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE restaurant_db;

-- ------------------------------------------------------------
-- 1. USERS
-- ------------------------------------------------------------
CREATE TABLE users (
  id          INT           NOT NULL AUTO_INCREMENT,
  name        VARCHAR(100)  NOT NULL,
  email       VARCHAR(150)  NOT NULL UNIQUE,
  password    VARCHAR(255)  NOT NULL,          -- bcrypt hash
  role        ENUM('client','admin') NOT NULL DEFAULT 'client',
  created_at  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
);

-- ------------------------------------------------------------
-- 2. TABLES  (mesele din restaurant)
-- ------------------------------------------------------------
CREATE TABLE tables (
  id          INT           NOT NULL AUTO_INCREMENT,
  number      INT           NOT NULL UNIQUE,   -- numarul mesei (ex: 1, 2, 3...)
  capacity    INT           NOT NULL,          -- nr. maxim de persoane
  location    VARCHAR(100)  NOT NULL,          -- ex: 'Terasa', 'Interior', 'Privat'
  is_active   BOOLEAN       NOT NULL DEFAULT TRUE,
  PRIMARY KEY (id)
);

-- ------------------------------------------------------------
-- 3. RESERVATIONS
-- ------------------------------------------------------------
CREATE TABLE reservations (
  id          INT           NOT NULL AUTO_INCREMENT,
  user_id     INT           NOT NULL,
  table_id    INT           NOT NULL,
  date        DATE          NOT NULL,
  time        TIME          NOT NULL,
  guests      INT           NOT NULL,
  status      ENUM('pending','confirmed','cancelled') NOT NULL DEFAULT 'pending',
  notes       TEXT,
  created_at  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id)  REFERENCES users(id)  ON DELETE CASCADE,
  FOREIGN KEY (table_id) REFERENCES tables(id) ON DELETE CASCADE
);

-- ------------------------------------------------------------
-- 4. MENU_ITEMS
-- ------------------------------------------------------------
CREATE TABLE menu_items (
  id           INT            NOT NULL AUTO_INCREMENT,
  name         VARCHAR(150)   NOT NULL,
  description  TEXT,
  price        DECIMAL(8, 2)  NOT NULL,
  category     VARCHAR(100)   NOT NULL,        -- ex: 'Aperitive', 'Fel principal', 'Desert', 'Bauturi'
  is_available BOOLEAN        NOT NULL DEFAULT TRUE,
  PRIMARY KEY (id)
);

-- ------------------------------------------------------------
-- 5. REVIEWS
-- ------------------------------------------------------------
CREATE TABLE reviews (
  id           INT   NOT NULL AUTO_INCREMENT,
  user_id      INT   NOT NULL,
  menu_item_id INT   NOT NULL,
  rating       INT   NOT NULL CHECK (rating BETWEEN 1 AND 5),
  comment      TEXT,
  created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_user_item (user_id, menu_item_id),   -- un user = o recenzie per preparat
  FOREIGN KEY (user_id)      REFERENCES users(id)      ON DELETE CASCADE,
  FOREIGN KEY (menu_item_id) REFERENCES menu_items(id) ON DELETE CASCADE
);

-- ============================================================
--  DATE DE TEST (Seed Data)
-- ============================================================

-- Admin + 3 clienti (parola pentru toti: "password123" — hash bcrypt)
INSERT INTO users (name, email, password, role) VALUES
  ('Admin Restaurant', 'admin@restaurant.md', '$2b$10$xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'admin'),
  ('Ion Popescu',      'ion@mail.com',        '$2b$10$xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'client'),
  ('Maria Ionescu',    'maria@mail.com',      '$2b$10$xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'client'),
  ('Alex Rusu',        'alex@mail.com',       '$2b$10$xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'client');

-- 6 mese
INSERT INTO tables (number, capacity, location) VALUES
  (1, 2,  'Interior'),
  (2, 4,  'Interior'),
  (3, 4,  'Interior'),
  (4, 6,  'Terasa'),
  (5, 8,  'Terasa'),
  (6, 10, 'Sala privata');

-- Meniu
INSERT INTO menu_items (name, description, price, category) VALUES
  ('Bruschette cu rosii',      'Paine crocanta cu rosii cherry si busuioc', 45.00,  'Aperitive'),
  ('Supa crema de ciuperci',   'Supa de ciuperci cu smantana si crutoane',  55.00,  'Supe'),
  ('File de somon la gratar',  'Somon cu legume la abur si sos de lamaie',  195.00, 'Fel principal'),
  ('Pasta Carbonara',          'Paste cu bacon, ou si parmezan',            120.00, 'Fel principal'),
  ('Pizza Margherita',         'Pizza clasica cu sos de rosii si mozzarela',110.00, 'Fel principal'),
  ('Tort de ciocolata',        'Tort cu crema ganache si fructe de padure',  75.00, 'Desert'),
  ('Inghetata artizanala',     '3 bile la alegere din 12 arome',             55.00, 'Desert'),
  ('Limonada de casa',         'Lamaie, menta si sirop natural',             35.00, 'Bauturi'),
  ('Vin rosu (pahar)',         'Cabernet Sauvignon, sec, 150ml',             60.00, 'Bauturi');

-- Cateva rezervari de test
INSERT INTO reservations (user_id, table_id, date, time, guests, status, notes) VALUES
  (2, 2, '2025-06-10', '19:00', 3, 'confirmed', 'Aniversare — rugam un desert surpriza'),
  (3, 4, '2025-06-11', '20:00', 4, 'pending',   NULL),
  (4, 1, '2025-06-12', '13:00', 2, 'pending',   'Alergic la gluten');

-- Cateva recenzii de test
INSERT INTO reviews (user_id, menu_item_id, rating, comment) VALUES
  (2, 3, 5, 'Somonul a fost perfect, recomand cu caldura!'),
  (3, 4, 4, 'Carbonara buna, dar portia putina cam mica.'),
  (4, 6, 5, 'Cel mai bun tort de ciocolata pe care l-am mancat.');

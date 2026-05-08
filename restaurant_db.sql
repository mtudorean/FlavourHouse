CREATE DATABASE IF NOT EXISTS restaurant_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci; 

USE restaurant_db;

-- ------------------------------------------------------------
-- 1. UTILIZATORI
-- ------------------------------------------------------------
CREATE TABLE utilizatori (
  id            INT           NOT NULL AUTO_INCREMENT,
  nume          VARCHAR(100)  NOT NULL,
  email         VARCHAR(150)  NOT NULL UNIQUE,
  parola        VARCHAR(255)  NOT NULL,          -- bcrypt hash
  rol           ENUM('client','admin') NOT NULL DEFAULT 'client',
  creat_la      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
);

-- ------------------------------------------------------------
-- 2. MESE  (mesele din restaurant)
-- ------------------------------------------------------------
CREATE TABLE mese (
  id            INT           NOT NULL AUTO_INCREMENT,
  numar         INT           NOT NULL UNIQUE,   -- numarul mesei (ex: 1, 2, 3...)
  capacitate    INT           NOT NULL,          -- nr. maxim de persoane
  locatie       VARCHAR(100)  NOT NULL,          -- ex: 'Terasa', 'Interior', 'Sala privata'
  este_activa   BOOLEAN       NOT NULL DEFAULT TRUE,
  PRIMARY KEY (id)
);

-- ------------------------------------------------------------
-- 3. REZERVARI
-- ------------------------------------------------------------
CREATE TABLE rezervari (
  id            INT           NOT NULL AUTO_INCREMENT,
  utilizator_id INT           NOT NULL,
  masa_id       INT           NOT NULL,
  data          DATE          NOT NULL,
  ora           TIME          NOT NULL,
  nr_persoane   INT           NOT NULL,
  status        ENUM('in_asteptare','confirmata','anulata') NOT NULL DEFAULT 'in_asteptare',
  observatii    TEXT,
  creat_la      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (utilizator_id) REFERENCES utilizatori(id) ON DELETE CASCADE,
  FOREIGN KEY (masa_id)       REFERENCES mese(id)        ON DELETE CASCADE
);

-- ------------------------------------------------------------
-- 4. PREPARATE_MENIU
-- ------------------------------------------------------------
CREATE TABLE preparate_meniu (
  id              INT            NOT NULL AUTO_INCREMENT,
  denumire        VARCHAR(150)   NOT NULL,
  descriere       TEXT,
  pret            DECIMAL(8, 2)  NOT NULL,
  categorie       VARCHAR(100)   NOT NULL,        -- ex: 'Aperitive', 'Fel principal', 'Desert', 'Bauturi'
  este_disponibil BOOLEAN        NOT NULL DEFAULT TRUE,
  PRIMARY KEY (id)
);

-- ------------------------------------------------------------
-- 5. RECENZII
-- ------------------------------------------------------------
CREATE TABLE recenzii (
  id              INT   NOT NULL AUTO_INCREMENT,
  utilizator_id   INT   NOT NULL,
  preparat_id     INT   NOT NULL,
  calificativ     INT   NOT NULL CHECK (calificativ BETWEEN 1 AND 5),
  comentariu      TEXT,
  creat_la        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_utilizator_preparat (utilizator_id, preparat_id),
  FOREIGN KEY (utilizator_id) REFERENCES utilizatori(id)     ON DELETE CASCADE,
  FOREIGN KEY (preparat_id)   REFERENCES preparate_meniu(id) ON DELETE CASCADE
);

-- ============================================================
--  DATE DE TEST
-- ============================================================

-- Admin + 3 clienti 
INSERT INTO utilizatori (nume, email, parola, rol) VALUES
  ('Admin Restaurant', 'admin@restaurant.md', '$2b$10$xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'admin'),
  ('Ion Popescu',      'ion@mail.com',        '$2b$10$xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'client'),
  ('Maria Ionescu',    'maria@mail.com',      '$2b$10$xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'client'),
  ('Alex Rusu',        'alex@mail.com',       '$2b$10$xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 'client');

-- 6 mese
INSERT INTO mese (numar, capacitate, locatie) VALUES
  (1, 2,  'Interior'),
  (2, 4,  'Interior'),
  (3, 4,  'Interior'),
  (4, 6,  'Terasa'),
  (5, 8,  'Terasa'),
  (6, 10, 'Sala privata');

-- Meniu
INSERT INTO preparate_meniu (denumire, descriere, pret, categorie) VALUES
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
INSERT INTO rezervari (utilizator_id, masa_id, data, ora, nr_persoane, status, observatii) VALUES
  (2, 2, '2025-06-10', '19:00', 3, 'confirmata',   'Aniversare — rugam un desert surpriza'),
  (3, 4, '2025-06-11', '20:00', 4, 'in_asteptare', NULL),
  (4, 1, '2025-06-12', '13:00', 2, 'in_asteptare', 'Alergic la gluten');

-- Cateva recenzii de test
INSERT INTO recenzii (utilizator_id, preparat_id, calificativ, comentariu) VALUES
  (2, 3, 5, 'Somonul a fost perfect, recomand cu caldura!'),
  (3, 4, 4, 'Carbonara buna, dar portia cam mica.'),
  (4, 6, 5, 'Cel mai bun tort de ciocolata pe care l-am mancat.');

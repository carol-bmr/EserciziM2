-- 1. Creiamo il contenitore (Database)
CREATE DATABASE sistema_ordini;
USE sistema_ordini;

-- 2. Tabella Clienti (nessuna dipendenza)
CREATE TABLE clienti (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    data_nascita DATE
);

-- 3. Tabella Prodotti (nessuna dipendenza)
CREATE TABLE prodotti (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome_prodotto VARCHAR(100) NOT NULL,
    prezzo DECIMAL(10, 2) NOT NULL
);

-- 4. Tabella Ordini (dipende da Clienti)
CREATE TABLE ordini (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data_ordine DATETIME DEFAULT CURRENT_TIMESTAMP,
    cliente_id INT,
    FOREIGN KEY (cliente_id) REFERENCES clienti(id)
);

-- 5. Tabella Ponte (per la relazione Molti-a-Molti tra Ordini e Prodotti)
CREATE TABLE ordini_prodotti (
    ordine_id INT,
    prodotto_id INT,
    quantita INT DEFAULT 1,
    PRIMARY KEY (ordine_id, prodotto_id),
    FOREIGN KEY (ordine_id) REFERENCES ordini(id),
    FOREIGN KEY (prodotto_id) REFERENCES prodotti(id)
);
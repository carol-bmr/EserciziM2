-- Inseriamo un cliente
INSERT INTO clienti (nome, cognome, email) 
VALUES ('Mario', 'Rossi', 'mario.rossi@email.it');

-- Inseriamo un prodotto
INSERT INTO prodotti (nome_prodotto, prezzo) 
VALUES ('Laptop Pro', 1200.00);

-- Creiamo un ordine per il cliente 1
INSERT INTO ordini (cliente_id) VALUES (1);

-- Colleghiamo il prodotto 1 all'ordine 1
INSERT INTO ordini_prodotti (ordine_id, prodotto_id, quantita) VALUES (1, 1, 1);
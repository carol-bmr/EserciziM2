# ==============================================================================
# Esercizio W7 - 1
# ==============================================================================

# Per prima cosa mi connetto con il database interessato.
USE AdventureWorksDW;

# ------------------------------------------------------------------------------
# Scrivi una query per verificare che il campo ProductKey nella tabella
# DimProduct sia una chiave primaria.
# Quali considerazioni/ragionamenti è necessario che tu faccia?
# ------------------------------------------------------------------------------

# Una Primary Key deve garantire due proprietà fondamentali:
# 1) Non deve contenere valori NULL.
# 2) Deve contenere valori UNIVOCI (nessun duplicato).

# Controllo preliminare della struttura della tabella
DESCRIBE dimproduct;

# 1° Verifica: Assenza di valori NULL
SELECT ProductKey
FROM dimproduct
WHERE ProductKey IS NULL;

# 2° Verifica: Assenza di duplicati (il set deve risultare vuoto)
SELECT 
    ProductKey,
    COUNT(*) AS Conteggio
FROM dimproduct
GROUP BY ProductKey
HAVING COUNT(*) > 1; 

# potremmo aggiungere anche:
# OR ProductKey IS NULL;

# Metodo alternativo di verifica combinata (confronto totali e distinti)
SELECT 
    COUNT(*) AS TotaleRighe,
    COUNT(ProductKey) AS TotaleRigheProductKeyNotNull,
    COUNT(DISTINCT ProductKey) AS ProductKeyDistinti
FROM dimproduct;
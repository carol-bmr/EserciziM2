# ==============================================================================
# Esercizio W7 - 2
# ==============================================================================

# Per prima cosa mi connetto con il database interessato
USE AdventureWorksDW;

# ------------------------------------------------------------------------------
# 2. Scrivi una query per verificare che la combinazione dei campi 
#    SalesOrderNumber e SalesOrderLineNumber sia una PK.
# ------------------------------------------------------------------------------

# Trattandosi di una chiave primaria composta, la combinazione (coppia) 
# dei due campi deve essere sempre valorizzata (NOT NULL) e mai duplicata nel dataset.

# Controllo preliminare della struttura della tabella dei fatti
DESCRIBE factresellersales;

# 1° Verifica: Assenza di duplicati sulla coppia di campi
SELECT
    SalesOrderNumber,
    SalesOrderLineNumber,
    COUNT(*) AS Conteggio
FROM factresellersales
GROUP BY 
    SalesOrderNumber,
    SalesOrderLineNumber
HAVING COUNT(*) > 1;

# 2° Verifica: Assenza di NULL in entrambi i campi della chiave
SELECT *
FROM factresellersales
WHERE SalesOrderNumber IS NULL OR SalesOrderLineNumber IS NULL;

# ------------------------------------------------------------------------------
# 3. Conta il numero transazioni (SalesOrderLineNumber) realizzate 
#    ogni giorno a partire dal 1 Gennaio 2020.
# ------------------------------------------------------------------------------

# Usiamo OrderDateKey o OrderDate a seconda del formato nel DB (qui OrderDate).
# Filtriamo con WHERE per la data e raggruppiamo per giorno.

SELECT 
    OrderDate AS DataTransazione,
    COUNT(SalesOrderLineNumber) AS NumeroTransazioni
FROM factresellersales
WHERE OrderDate >= '2020-01-01'
GROUP BY OrderDate
ORDER BY OrderDate ASC;
# Se scrivessimo ORDER BY 1 ASC è la stessa cosa perchè 1 fa riferimento alla prima colonna.

# ------------------------------------------------------------------------------
# 4. Calcola il fatturato totale (SalesAmount), quantità totale venduta 
#	(OrderQuantity) e prezzo medio di vendita (UnitPrice) per prodotto 
#	a partire dal 1 Gennaio 2020.
#	Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, 
#	la quantità totale venduta e il prezzo medio di vendita. 
#	I campi in output devono essere parlanti!
# ------------------------------------------------------------------------------

#Calcola il fatturato totale (FactResellerSales.SalesAmount), la quantità totale venduta (FactResellerSales.OrderQuantity) 
# e il prezzo medio di vendita (FactResellerSales.UnitPrice) per prodotto (DimProduct) a partire dal 1 Gennaio 2020. 
#Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, la quantità totale venduta e il prezzo medio di vendita. 
#I campi in output devono essere parlanti!

# Mettiamo in JOIN la tabella dei fatti (factresellersales) con la dimensione 
# prodotto (dimproduct) per estrarre il nome testuale del prodotto.

SELECT 
    p.EnglishProductName AS NomeProdotto,
    f.OrderDate AS OrdineData,
    SUM(f.SalesAmount) AS FatturatoTotale,
    SUM(f.OrderQuantity) AS QuantitaTotaleVenduta,
    AVG(f.UnitPrice) AS PrezzoMedioVendita
FROM factresellersales f
LEFT JOIN dimproduct p ON f.ProductKey = p.ProductKey
WHERE f.OrderDate >= '2020-01-01'
GROUP BY p.EnglishProductName
ORDER BY FatturatoTotale DESC;
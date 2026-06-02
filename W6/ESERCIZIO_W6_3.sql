# ==============================================================================
# Esercizio W6 - 3
# ==============================================================================

#Esercizio 2.2:
#Scrivi unʼaltra query al fine di esporre lʼelenco dei prodotti finiti 
#il cui prezzo di listino è compreso tra 1000 e 2000.

#come prima cosa sempre connettersi al DB di riferimento:
USE AdventureWorksDW; 
#ora posso generare la query:

SELECT *
FROM dimproduct
WHERE FinishedGoodsFlag = 1 
AND ListPrice BETWEEN 1000 AND 2000;

#Esercizio 2.3:
#Esplora la tabella degli impiegati aziendali (DimEmployee)

SHOW CREATE TABLE dimemployee;

#Esercizio 2.4:
#Esponi, interrogando la tabella degli impiegati aziendali, lʼelenco dei soli agenti.
#Gli agenti sono i dipendenti per i quali il campo SalespersonFlag è uguale a 1.

SELECT *
FROM dimemployee
WHERE SalesPersonFlag = 1;

#Esercizio 2.5:
#Interroga la tabella delle vendite (FactResellerSales).
#Esponi in output lʼelenco delle transazioni registrate a partire dal 1 gennaio 2020:
#dei soli codici prodotto: 597, 598, 477, 214.
#Calcola per ciascuna transazione il profitto (SalesAmount - TotalProductCost).

SELECT 
ProductKey, 
OrderDate, 
SalesAmount, 
TotalProductCost,
(SalesAmount - TotalProductCost) AS Profitto

#per il momento ho selezionato solo fino a qui e ho dato il comando esegui
#per assicurarmi in che formato la data si trovasse.
#dopo verifica, posso essere sicura di trascrivere la formula in modo corretto:

FROM factresellersales
WHERE OrderDate >= '2020-01-01'
AND ProductKey IN (597, 598, 477, 214);
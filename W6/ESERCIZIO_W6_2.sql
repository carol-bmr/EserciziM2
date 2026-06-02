# ==============================================================================
# Esercizio W6 - 2
# ==============================================================================

#Esercizio 5:
#Scrivi una nuova query al fine di esporre in output:
#i prodotti il cui codice modello (ProductAlternateKey) comincia con FR oppure BK.
#Il result set deve contenere: il codice prodotto ProductKey, il modello,
#il nome del prodotto, il costo standard (StandardCost) e il prezzo di listino (ListPrice).

#come prima cosa sempre connettersi al DB di riferimento:
USE AdventureWorksDW; 
#ora posso generare la query:

SELECT 
ProductKey,
ProductAlternateKey AS CodiceModello,
EnglishProductName AS NomeProdotto,
StandardCost AS CostoStandard,
ListPrice AS PrezzoDiListino
FROM dimproduct
WHERE ProductAlternateKey LIKE 'FR%' OR ProductAlternateKey LIKE 'BK%';
#WHERE LEFT (ProductAlternateKey, 2) IN ('FR', 'BK')

#Esercizio 2.1:
#Arricchisci il risultato della query scritta nel passaggio precedente
#del Markup applicato dallʼazienda (ListPrice - StandardCost)

SELECT 
ProductKey,
ProductAlternateKey AS CodiceModello,
EnglishProductName AS NomeProdotto,
StandardCost AS CostoStandard,
ListPrice AS PrezzoDiListino,
(ListPrice - StandardCost) AS Markup
FROM dimproduct
WHERE ProductAlternateKey LIKE 'FR%' OR ProductAlternateKey LIKE 'BK%';
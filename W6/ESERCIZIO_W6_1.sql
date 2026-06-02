# ==============================================================================
# Esercizio W6 - 1
# ==============================================================================

#Esercizio 1: 
#Connettiti al DB Aziendale

USE AdventureWorksDW;

#Esercizio 2: 
#Esplora la tabella dei prodotti (DimProduct)

SHOW CREATE TABLE dimproduct;

#Esercizio 3: 
#Interroga la tabella dei prodotti (DimProduct)
#esponi in output i campi ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, FinishedGoodsFlag. 
#Il result set deve essere parlante per cui assegna un alias se lo ritieni opportuno

SELECT 
ProductKey,
ProductAlternateKey AS CodiceModello,
EnglishProductName AS NomeProdotto,
Color AS Colore, 
StandardCost AS CostoStandard, 
FinishedGoodsFlag AS ProdottoFinito
FROM dimproduct;

#Esercizio 4:
#Partendo dalla query scritta nel passaggio precedente,
#esponi in output i soli prodotti finiti 
#cioè quelli per cui il campo FinishedGoodsFlag è uguale a 1.

SELECT 
ProductKey, 
ProductAlternateKey AS CodiceModello, 
EnglishProductName AS NomeProdotto, 
Color AS Colore, 
StandardCost AS CostoStandard, 
FinishedGoodsFlag AS ProdottoFinito
FROM dimproduct
WHERE FinishedGoodsFlag = 1;
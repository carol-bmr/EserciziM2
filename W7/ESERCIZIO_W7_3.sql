# ==============================================================================
# Esercizio W7 - 3
# ==============================================================================

# Per prima cosa mi connetto con il database interessato.
USE AdventureWorksDW;

# ------------------------------------------------------------------------------
# 1. Calcola il fatturato totale (FactResellerSales.SalesAmount) e 
#	la quantità totale venduta (FactResellerSales.OrderQuantity) 
#	per Categoria prodotto (DimProductCategory).
#	Il result set deve esporre pertanto il nome della categoria prodotto,
#	il fatturato totale e la quantità totale venduta.
#	I campi in output devono essere parlanti!
# ------------------------------------------------------------------------------

# Per arrivare alla categoria partendo dai fatti dobbiamo seguire la catena:
# factresellersales -> dimproduct -> dimproductsubcategory -> dimproductcategory

SELECT 
    pc.EnglishProductCategoryName AS CategoriaProdotto,
    SUM(f.SalesAmount) AS FatturatoTotale,
    SUM(f.OrderQuantity) AS QuantitaTotaleVenduta
FROM factresellersales f
JOIN dimproduct p ON f.ProductKey = p.ProductKey
JOIN dimproductsubcategory psc ON p.ProductSubcategoryKey = psc.ProductSubcategoryKey
JOIN dimproductcategory pc ON psc.ProductCategoryKey = pc.ProductCategoryKey
GROUP BY pc.EnglishProductCategoryName
ORDER BY FatturatoTotale DESC;


# ------------------------------------------------------------------------------
# 2. Calcola il fatturato totale per area città (DimGeography.City) 
#	realizzato a partire dal 1 Gennaio 2020. 
#	Il result set deve esporre lʼelenco delle città
#	con fatturato realizzato superiore a 60K.
# ------------------------------------------------------------------------------

# Colleghiamo i fatti alla geografia tramite la dimensione del cliente/reseller.
# In AdventureWorksDW, la tabella di snodo classica è dimreseller (o dimcustomer). 
# Assumendo le vendite reseller (factresellersales): f -> dimreseller -> dimgeography.
# Per filtrare l'aggregato (> 60000) è obbligatorio usare HAVING.

SELECT 
    g.City AS Citta,
    SUM(f.SalesAmount) AS FatturatoTotale
FROM factresellersales f
JOIN dimreseller r ON f.ResellerKey = r.ResellerKey
JOIN dimgeography g ON r.GeographyKey = g.GeographyKey
WHERE f.OrderDate >= '2020-01-01'
GROUP BY g.City
HAVING SUM(f.SalesAmount) > 60000
ORDER BY FatturatoTotale DESC;
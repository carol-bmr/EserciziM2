# ==============================================================================
# Esercizio W6 - 5
# ==============================================================================

#Esercizio 2.1: 
#Esponi lʼelenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto.

#come prima cosa sempre connettersi al DB di riferimento:
USE AdventureWorksDW; 
#ora posso generare la query:

SELECT 
    f.salesordernumber AS NumeroVendita,
    f.SalesOrderLineNumber AS NumeroRiga,
    f.OrderDate AS DataOrdine,
    p.EnglishProductName AS NomeProdotto,
    c.englishproductcategoryname AS Categoria
FROM factresellersales f
LEFT JOIN dimproduct p 
	ON f.productkey = p.productkey
LEFT JOIN dimproductsubcategory s 
	ON p.productsubcategorykey = s.productsubcategorykey
LEFT JOIN dimproductcategory c 
	ON s.productcategorykey = c.productcategorykey;

#Esercizio 2.2: 
#Esplora la tabella DimReseller.

SELECT * FROM dimreseller;

#Esercizio 2.3: 
#Esponi in output lʼelenco dei reseller indicando, per ciascun reseller, anche la sua area geografica. 

SELECT 
    r.resellername AS nome_reseller, 
    g.englishcountryregionname AS nazione,
    g.stateprovincename AS regione
FROM dimreseller r
JOIN dimgeography g
	ON r.geographykey = g.geographykey;

#Esercizio 2.4: 
#Esponi lʼelenco delle transazioni di vendita.
#Il result set deve esporre i campi: SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost.
#Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, il nome del reseller e lʼarea geografica.

SELECT 
    f.salesordernumber,
    f.salesorderlinenumber,
    f.orderdate,
    f.unitprice,
    f.orderquantity AS quantity, 
    f.totalproductcost,
    p.englishproductname AS nome_prodotto,
    c.englishproductcategoryname AS categoria_prodotto,
    r.resellername AS nome_reseller,
    g.englishcountryregionname AS area_geografica
FROM factresellersales f
JOIN dimproduct p 
	ON f.productkey = p.productkey
JOIN dimproductsubcategory s 
	ON p.productsubcategorykey = s.productsubcategorykey
JOIN dimproductcategory c 
	ON s.productcategorykey = c.productcategorykey
JOIN dimreseller r 
	ON f.resellerkey = r.resellerkey
JOIN dimgeography g 
	ON r.geographykey = g.geographykey;

# ==============================================================================
# Esercizio W6 - 4
# ==============================================================================

#Dove possibile svolgi gli esercizi utilizzando sia JOIN che SUBQUERY

#Esercizio 1: 
#Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria (DimProduct, DimProductSubcategory).

#cerchiamo di capire quale delle due tabelle è forte e quale debole
#analizziamo la tabella forte:

#come prima cosa sempre connettersi al DB di riferimento:
USE AdventureWorksDW; 
#ora posso generare la query:

SELECT *
FROM dimproductsubcategory; #(questa è la chiave forte)

#cerchiamo qual'è la chiave nella tabella forte?
#analizziamo la tabella debole:

SELECT *
FROM dimproduct; #(dimproduct è la tabella debole)

#ho la chiave in tabella debole?
#che tipo di join applico? inner o left?
#(ci saranno con la inner solo quelli con la chiave 
#mentre con la left ci saranno anche i risultati con null)

#se scriviamo solo JOIN in automatico viene utilizzata la INNER
#La LEFT è più utile per non perdere i dati

SELECT 
    p.englishproductname AS nomeprodotto, 
    s.englishproductsubcategoryname AS sottocategoria 
#volendo potremmo scrivere anche semplicemente la parola sottocategoria
#senza l'utilizzo di AS poichè lo legge comunque come alias
FROM dimproduct p #diamo sempre un alias come scritto sopra 
LEFT JOIN dimproductsubcategory s 
ON p.productsubcategorykey = s.productsubcategorykey; #PK di s 

#Esercizio 2: 
#Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria e la sua categoria (DimProduct, DimProductSubcategory, DimProductCategory).

SELECT *
FROM dimproductcategory;
#la chiave è producategorykey
SELECT*
FROM dimproduct;
#abbiamo solo la chiave della sottocategory
SELECT*
FROM dimproductsubcategory;
#qui abbiamo producategorykey
#quindi abbiamo 3 tabelle 1 a molti consecutive

SELECT 
    p.englishproductname AS nome_prodotto, 
    s.englishproductsubcategoryname AS sottocategoria,
    c.englishproductcategoryname AS categoria
FROM dimproduct p
LEFT JOIN dimproductsubcategory s
	ON p.productsubcategorykey = s.productsubcategorykey
LEFT JOIN dimproductcategory c
	ON s.productcategorykey = c.productcategorykey;

#con tasto destro sull'attributo dell'entità e selezionando:
#"Select Rows - Limit 1000" in automatico scrive una SELECT *
#che da' la possibilità di visualizzare tutti gli attributi in maniera più comoda.

#Esercizio 3: 
#Esponi lʼelenco dei soli prodotti venduti (DimProduct, FactResellerSales).

USE AdventureWorksDW;

SELECT *
FROM dimproduct;

SELECT DISTINCT p. *
FROM dimproduct p
JOIN factresellersales f
	ON p.productkey = f.productkey;
#Risultato della INNER JOIN 

SELECT DISTINCT *
FROM dimproduct
WHERE productkey IN (SELECT productkey FROM factresellersales);

#Esercizio 4: 
#Esponi lʼelenco dei prodotti non venduti (considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1.

#Con la JOIN:
SELECT DISTINCT EnglishProductName
FROM dimproduct p
LEFT JOIN factresellersales f 
	ON p.ProductKey = f.ProductKey
WHERE FinishedGoodsFlag = 1 
AND f.ProductKey IS NULL;
#attraverso la "AND ... IS NULL" troviamo tutti i valori non venduti richiesti.

#Considerando che usiamo una LEFT JOIN 
#abbiamo dei null in corrispondenza delle vendite della productkey perchè non c'è corrispondenza
#visto che si cercava i soli prodotti non venduti.
#attraverso la WHERE troviamo i NULL e quindi i prodotti non venduti 
#cosa vogliamo visualizzare? il numero e il nome del prodotto.
#Quando facciamo la LEFT prende tutto della prima tabella quindi in mancanza di dati dalla tabella RIGHT è normale che riporta il NULL.
#in questo caso la ANTI JOIN sarebbe stata perfetta per la pulizia di dati.

#ora usiamo la SUBQUERY:
SELECT englishproductname
FROM dimproduct
WHERE finishedgoodsflag = 1 
AND productkey NOT IN (SELECT productkey FROM factresellersales);

#Esercizio 5: 
#Esponi lʼelenco delle transazioni di vendita (FactResellerSales) indicando anche il nome del prodotto venduto (DimProduct).

SELECT 
    f.*, 
    p.englishproductname AS nome_prodotto
FROM factresellersales f
JOIN dimproduct p ON f.productkey = p.productkey;
/*ESERCIZIO 1:
ESPONI DIMPRODUCT E DIMPRODUCTSUBCATEGORY 
COLONNE SCELTE PER SEMPLIFICARE: ENGLISHPRODUCTNAME/englishproductsubcategoryname con ID comune= ProductSubcategoryKey*/
SELECT  P.EnglishProductName AS Product,
		P.ProductKey,
 		sub.EnglishProductSubCategoryName AS Subcategory
FROM dimproduct AS P
JOIN dimproductsubcategory AS sub ON P.ProductSubcategoryKey = sub.ProductSubcategoryKey;

/*ESERCIZIO 2:
#ESPORRE ANAGRAFICA DEI PRODOTTI CON INCLUSA ANCHE CATEGORIA
#AGGOIUNGERE A ESERCIZIO 1 LA CATEGORIA usare ProductCategoryKey in subcategory 
esponi englishproductcategoryname*/
SELECT  P.EnglishProductName AS Product,
		P.ProductKey,
 		sub.EnglishProductSubCategoryName AS Subcategory,
        C.englishproductcategoryname
FROM dimproduct AS P
JOIN dimproductsubcategory AS sub ON P.ProductSubcategoryKey = sub.ProductSubcategoryKey
LEFT JOIN dimproductcategory AS C ON sub.ProductCategoryKey = C.ProductCategoryKey;

/*ESERCIZIO 3:
Esponi lʼelenco dei soli prodotti venduti DimProduct, FactResellerSales.*/
SELECT  P.ProductKey,
		P.EnglishProductName,
        S.SalesOrderNumber
FROM dimproduct AS P
JOIN factresellersales AS S ON P.ProductKey = S.ProductKey;

/*ESERCIZIO 4:
Esponi lʼelenco dei prodotti non venduti 
(considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1*/
SELECT  P.ProductKey,
		P.EnglishProductName,
        P.FinishedGoodsFlag,
        S.SalesOrderNumber
FROM dimproduct AS P
LEFT JOIN factresellersales AS S ON P.ProductKey = S.ProductKey
WHERE SalesOrderNumber IS NULL
AND FinishedGoodsFlag = 1; 


/*ESERCIZIO 1 pag2:
Esponi lʼelenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto
category: */
SELECT  FS.SalesOrderNumber,
		FS.OrderDate,
        FS.OrderQuantity,
        FS.SalesAmount,
        P.EnglishProductName AS Product,
        C.EnglishProductCategoryName AS Category
FROM factresellersales FS
JOIN dimproduct P ON FS.ProductKey = P.ProductKey
JOIN dimproductsubcategory SUB ON P.ProductSubcategoryKey = SUB.ProductSubcategoryKey
JOIN dimproductcategory C ON SUB.ProductCategoryKey = C.ProductCategoryKey;
#3 JOIN sono l'ideale? posso ridurre con un subquery? come? 
# risposta trovata: sarebbe possibile ma l'ideale e piu pulito e' con le join.


/*ESERCIZIO 2 pag2
Esplora la tabella DimReseller.*/
SELECT * FROM dimreseller;
DESCRIBE dimreseller;
SELECT * FROM dimgeography;
DESCRIBE dimgeography;

/*ESERCIZIO 3 Pag2
Esponi in output lʼelenco dei reseller indicando, per ciascun reseller, anche la sua area geografica. */

SELECT  R.ResellerKey,
		R.ResellerName,
        City,
        EnglishCountryRegionName AS Region
FROM dimreseller R
JOIN dimgeography G ON R.GeographyKey = G.GeographyKey;

/*ESERCIZIO 4 pag2
Esponi lʼelenco delle transazioni di vendita. Il result set deve esporre i campi: SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost. 
Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, il nome del reseller e lʼarea geografica.*/
SELECT  rs.SalesOrderNumber AS SalesKey,
		rs.SalesOrderLineNumber AS LineNumber,
        rs.OrderDate,
        rs.UnitPrice,
        rs.OrderQuantity,
        rs.TotalProductCost AS Cost,
        p.EnglishProductName AS Product,
		c.EnglishProductCategoryName AS ProductCategory,
        r.ResellerName AS Reseller,
        g.City,
        g.EnglishCountryRegionName AS Country,
        g.StateProvinceName AS Province
FROM factresellersales rs
JOIN dimproduct p ON rs.ProductKey = p.ProductKey
JOIN dimproductsubcategory s ON p.ProductSubcategoryKey = s.ProductSubcategoryKey
JOIN dimproductcategory c ON s.ProductCategoryKey = c.ProductCategoryKey
JOIN dimreseller r ON rs.ResellerKey = r.ResellerKey
JOIN dimgeography g ON r.GeographyKey = g.GeographyKey
;

/*ESERCIZIO 1-
Implementa una vista denominata Product al fine di creare unʼanagrafica (dimensione) prodotto completa.
 La vista, se interrogata o utilizzata come sorgente dati,
 deve esporre il nome prodotto, il nome della sottocategoria associata e il nome della categoria associata.*/
DROP VIEW IF EXISTS product;
CREATE VIEW PRODUCT AS 
SELECT  P.ProductKey,
		P.EnglishProductName AS Product,
        P.StandardCost,
		P.ListPrice,
        SUB.EnglishProductSubcategoryName AS Subcategory,
        C.EnglishProductCategoryName AS Category
FROM dimproduct P
JOIN dimproductsubcategory SUB ON P.ProductSubcategoryKey = SUB.ProductSubcategoryKey
JOIN dimproductcategory C ON SUB.ProductCategoryKey = C.ProductCategoryKey
;
/*ESERCIZIO 2-
Implementa una vista denominata Reseller al fine di creare unʼanagrafica (dimensione) reseller completa. 
La vista, se interrogata o utilizzata come sorgente dati, deve esporre il nome del reseller, il nome della città e il nome della regione.*/
CREATE VIEW RESELLER AS
SELECT  R.ResellerKey,
		R.ResellerName,
        R.BusinessType,
		G.City,
        G.EnglishCountryRegionName AS Region,
		R.AddressLine1 AS Address
FROM dimreseller R
JOIN dimgeography G ON R.GeographyKey = G.GeographyKey
;

/*ESERCIZIO 3-
Crea una vista denominata Sales che deve restituire la data dellʼordine,
il codice documento, la riga di corpo del documento, la quantità venduta, lʼimporto totale e il profitto.*/
CREATE VIEW SALES AS
SELECT  FS.SalesOrderNumber AS OrderID,
		FS.SalesOrderLineNumber AS LineID,
        FS.OrderDate,
        FS.OrderQuantity AS Quantity,
        FS.SalesAmount,
        (FS.SalesAmount-(P.StandardCost*FS.OrderQuantity)) AS Profit,
        P.ProductKey,
        FS.ResellerKey
FROM factresellersales FS
JOIN dimproduct P ON FS.ProductKey = P.ProductKey
;
select * from product

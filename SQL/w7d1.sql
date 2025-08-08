/*Esercizio 1- 
Schema concettuale Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria.
Quali considerazioni/ragionamenti è necessario che tu faccia?*/
#Come prima cosa verificherei se il campo e' disposto not null con una bella 'DESCRIBE', la quale vedro anche se il campo e' disposto come chiave
DESCRIBE dimproduct; /*notnull-PrimaryKey ma sara davvero cosi? verifichiamo con un COUNT per vedere la unicita del campo*/

SELECT ProductKey, 
COUNT(*) AS Occorrenze
FROM dimproduct
GROUP BY ProductKey
HAVING COUNT(*) > 1; /*in questo modo verifico se nel campo ci sono duplicati*/
#cosi abbiamo confermato la non nullabilita del campo e la sua unicita! ProductKey e' una Key affidabile.

/*Esercizio 2- 
Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK*/
DESCRIBE factresellersales;
SHOW CREATE TABLE factresellersales;

SELECT  
    SalesOrderNumber,
    SalesOrderLineNumber,
    COUNT(*) AS Occorrenze
FROM factresellersales
GROUP BY SalesOrderNumber, SalesOrderLineNumber
HAVING COUNT(*) > 1;
/*Questa query conta se le due colonne insieme sono univoci, restituisce vuoto,
quindi confermato che sia univoco le due colonne insieme
ovvero salesordernumber che vuol dire l'ordine e 
salesorderlinenumber che fa riferimento ad ogni prodotto acquistato
insieme sono unici*/

SELECT COUNT(*) AS NullCount
FROM factresellersales
WHERE SalesOrderNumber IS NULL
   OR SalesOrderLineNumber IS NULL;
/* questa query verifica se ci sono campi nulli sia in uno che nell'altro*/

/*ESERCIZIO 3-
Conta il numero transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020.*/
SELECT  SalesOrderLineNumber,
		OrderDate,
		SUM(SalesAmount) AS Sales
FROM factresellersales
WHERE OrderDate >= '2020-01-01'
GROUP BY SalesOrderLineNumber,
		 OrderDate;
#WHERE OR HAVING? - WHERE PRIMA DELL'INPUT E HAVING DOPO, QUANDO E' GIA STATA RAGGRUPATA.

/*ESERCIZIO-4
Calcola il fatturato totale (FactResellerSales.SalesAmount), la quantità totale venduta (FactResellerSales.OrderQuantity) e
il prezzo medio di vendita (FactResellerSales.UnitPrice) per prodotto (DimProduct) a partire dal 1 Gennaio 2020.
Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, la quantità totale venduta e il prezzo medio di vendita.
I campi in output devono essere parlanti!*/

SELECT  P.EnglishProductName AS Product,
        FS.OrderDate,
		SUM(FS.SalesAmount) AS Sales,
        AVG(FS.UnitPrice) AS Cost,
		SUM(FS.OrderQuantity) AS Quantity
FROM factresellersales FS
JOIN dimproduct P ON FS.ProductKey = P.ProductKey
WHERE FS.OrderDate >= '2020-01-01'
GROUP BY P.EnglishProductName
ORDER BY Sales DESC;

/*ESERCIZIO 1 PAG2
Calcola il fatturato totale (FactResellerSales.SalesAmount) e la quantità totale venduta (FactResellerSales.OrderQuantity) 
per Categoria prodotto (DimProductCategory). Il result set deve esporre pertanto il nome della categoria prodotto,
 il fatturato totale e la quantità totale venduta. I campi in output devono essere parlanti!*/
 
SELECT  C.EnglishProductCategoryName AS Category,
		SUM(FS.SalesAmount) AS Sales,
		SUM(FS.OrderQuantity) AS Quantity
FROM factresellersales FS
JOIN dimproduct P ON FS.ProductKey = P.ProductKey
JOIN dimproductsubcategory SUB ON P.ProductSubcategoryKey = SUB.ProductSubcategoryKey
JOIN dimproductcategory C ON SUB.ProductCategoryKey = C.ProductCategoryKey
GROUP BY C.EnglishProductCategoryName
ORDER BY Sales ASC
;

/*ESERCIZIO 2 PAG2
Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020. 
Il result set deve esporre lʼelenco delle città con fatturato realizzato superiore a 60K.*/

SELECT  G.City,
		SUM(FS.SalesAmount) AS Sales,
        SUM(OrderQuantity) AS Quantity,
        AVG(UnitPrice) AS AVG_Price
FROM factresellersales FS
JOIN dimreseller R ON FS.ResellerKey = R.ResellerKey
JOIN dimgeography G ON R.GeographyKey = G.GeographyKey
WHERE FS.OrderDate >= '2020-01-01'
GROUP BY G.City
HAVING SUM(FS.SalesAmount) > 60000
ORDER BY Sales DESC;


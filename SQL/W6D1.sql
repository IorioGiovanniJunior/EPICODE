#USO IL COMANDO PER VEDERE LA TABELLA DIMPRODUCT
SELECT *
FROM dimproduct;

#FACCIO OUTPUT DEI VALORI RICHIESTI:
SELECT  ProductKey AS ID, 
		ProductAlternateKey AS ProductKEY, 
        EnglishProductName AS Product, Color, 
        StandardCost AS Cost, 
        FinishedGoodsFlag AS Finished 
FROM dimproduct;

#FACCIO OUTPUT DEI PRODOTTI FINITI OVVERO FINISHED=1
SELECT  ProductKey AS ID, 
		ProductAlternateKey AS ProductKEY, 
        EnglishProductName AS Product, 
        Color, 
        StandardCost AS Cost, 
        FinishedGoodsFlag AS Finished 
FROM dimproduct
WHERE FinishedGoodsFlag=1;

#PRODUCTALTERNATEKEY = FR/BK -- DEVE AVERE PRODUCTKEY, MODELLO (PRODUCTALTERNATEKEY), ENGLISHPRODUCTNAME, STANDARDCOST E LISTPRICE
SELECT  ProductKey AS ID,
		ProductAlternateKey AS Model, 
        EnglishProductName AS Product, 
        StandardCost AS Cost, 
        FinishedGoodsFlag AS Finished, 
        ListPrice AS Price 
FROM dimproduct 
WHERE (FinishedGoodsFlag=1) AND (ProductAlternateKey LIKE 'BK%' OR ProductAlternateKey LIKE 'FR%');

#INSERIRE CAMPO CALCOLATO MARKUP = LISTPRICE-STANDARDCOST
SELECT  ProductKey AS ID,
		ProductAlternateKey AS Model, 
        EnglishProductName AS Product, 
        StandardCost AS Cost, 
        FinishedGoodsFlag AS Finished, 
        ListPrice AS Price,
        (ListPrice - StandardCost) AS Markup
FROM dimproduct 
WHERE (FinishedGoodsFlag=1) AND (ProductAlternateKey LIKE 'BK%' OR ProductAlternateKey LIKE 'FR%');

#VISUALIZZARE I PRODOTTI FINITI CHE IL PREZZO DI LISTINO (LISTPRICE) E' COMPRESO TRA 1000 e 2000
SELECT  ProductKey AS ID,
		ProductAlternateKey AS Model, 
        EnglishProductName AS Product, 
        StandardCost AS Cost, 
        FinishedGoodsFlag AS Finished, 
        ListPrice AS Price
FROM dimproduct 
WHERE ListPrice BETWEEN 1000 AND 2000;
#FINITO QUI LE QUERY DELLA TABELLA DIMPRODUCT

#INIZIAMO A ESPLORARE LA TABELLA DIMEMPLOYEE
SELECT *
FROM dimemployee;

#ESPORRE SOLO GLI AGENTE OVVERO DOVE SALESPERSONFLAG = 1
SELECT *
FROM dimemployee
WHERE SalesPersonFlag = 1;
#FINITO LA QUERY SU DIMEMPLOYEE

#ESPLORARE LA TABELLA DI FACTRESELLERSALES
SELECT *
FROM factresellersales;

#orderdata >= 2020-1-1, PRODUCTKEY IN (597,598,477,214), CALCOLA PROFIT (SALESAMOUNT-TOTALPRODUCTCOST)
SELECT  SalesOrderNumber,
		OrderDate,
        ProductKey,
        TotalProductCost,
        SalesAmount,
        (SalesAmount - TotalProductCost) AS Profit
FROM factresellersales
WHERE (OrderDate >= '2020-1-1') AND (ProductKey IN (597,598,477,214));
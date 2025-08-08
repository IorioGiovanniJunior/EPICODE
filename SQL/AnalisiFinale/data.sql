/*Task 2-
Task 2: Descrivi la struttura delle tabelle che reputi utili e sufficienti a modellare lo scenario proposto tramite la sintassi DDL. 
Implementa fisicamente le tabelle utilizzando il DBMS SQL Server(o altro).*/
CREATE DATABASE ToysGroup; #Creo il database
USE ToysGroup; #importante definire l'utilizzo della medesima

CREATE TABLE category (
categoryID INT AUTO_INCREMENT PRIMARY KEY,
CategoryName VARCHAR(50)
); #Creo la tabella category

CREATE TABLE Region (
regionID INT AUTO_INCREMENT PRIMARY KEY,
RegionName VARCHAR(50),
RegionCode VARCHAR(10)
); #Creo la tabella Region
/*Cosi ho creato prima le tabelle indipendenti ovvero quelle che non hanno foreign key
cosi da non avere errore di sintasse con le KEY*/

CREATE TABLE product (
productID INT AUTO_INCREMENT PRIMARY KEY,
categoryID INT NOT NULL,
StandardCost DECIMAL (10,2) NOT NULL,
ProductName VARCHAR (50) NOT NULL,
ProductSize INT, #Qua ho voluto creare un 'size' fittizio tipo cm3 che ottimizza dopo il processo di selezione delle scatole per contenere 1 o piu prodotti.
Color VARCHAR (50),
StockQuantity INT,
CONSTRAINT fk_category_product FOREIGN KEY (categoryID) REFERENCES category (categoryID) 
); #Creo la tabella Product

CREATE TABLE state (
stateID INT AUTO_INCREMENT PRIMARY KEY,
regionID INT NOT NULL,
PostalCode INT,
StateName VARCHAR(50) NOT NULL,
StateCode VARCHAR(10),
CONSTRAINT fk_region_state FOREIGN KEY (regionID) REFERENCES region (regionID)
);
#Ho creato le tabelle che dipendono da altre in secondo luogo

CREATE TABLE sales (
salesID INT AUTO_INCREMENT,
productID INT NOT NULL,
stateID INT NOT NULL,
SalesDetailID INT NOT NULL, #Qua ho voluto creare una specie di OrderLine (ad esempio se cliente ordina 2 prodotti il salesID fa riferimento al suo ordine in generale e la orderLine fa riferimento al prodotto line 1 = prodotto 1, line 2 = prodotto 2)
OrderDate DATE NOT NULL,
ShipDate DATE,
Quantity INT NOT NULL,
SalesAmount DECIMAL (10,2),

#PrimaryKEY composta:
CONSTRAINT pk_sales PRIMARY KEY (salesID, SalesDetailID),

CONSTRAINT fk_sales_product FOREIGN KEY (productID) REFERENCES product (productID),
CONSTRAINT fk_sales_state FOREIGN KEY (stateID) REFERENCES state (stateID)
);
#Per ultimo creato la tabella che dipende dalle sotto tabelle,
#cosi da non avere problemi di ordine con gli ID nelle esecutare il codice.

/*TASK 3-
Popola le tabelle utilizzando dati a tua discrezione 
(sono sufficienti pochi record per tabella; riporta le query utilizzate) */

INSERT INTO category (CategoryName) VALUES 
('Costruzioni'),
('Bambole e Pupazzi'),
('Veicoli giocattolo'),
('Giochi educativi'),
('Giochi da tavolo');
#Inserisco dati in category

INSERT INTO region (RegionName, RegionCode) VALUES 
('WestEurope', 'WEU'),
('SouthEurope', 'SEU'),
('NorthAmerica', 'NAM');
#inserisco dati in Region

INSERT INTO product (categoryID, StandardCost, ProductName, ProductSize, Color, StockQuantity) VALUES 
(1, 35.00, 'Mattoncini Maxi Set', 20, 'Multicolor', 150),
(1, 20.00, 'Set Costruzione Base', 10, 'Rosso', 200),
(2, 18.00, 'Bambola Sofy', 5, 'Rosa', 100),
(2, 25.00, 'Peluche Orsetto', NULL, 'Marrone', 120),
(3, 30.00, 'Auto da Corsa Rossa', 5, 'Rosso', 90),
(3, 45.00, 'Camion dei Pompieri', NULL, 'Rosso', 70),
(4, 22.00, 'Puzzle Mondo Animale', NULL, 'Multicolor', 80),
(4, 28.00, 'Laptop Giocattolo', 10, 'Blu', 60),
(5, 15.00, 'Gioco Memory', 5, 'Verde', 130),
(5, 32.00, 'Monopoly Junior', NULL, 'Multicolor', 110);
#inserisco dati in Product

INSERT INTO state (regionID, PostalCode, StateName, StateCode) VALUES 
(1, 75000, 'France', 'FR'),
(1, 10115, 'Germany', 'DE'),
(2, 00100, 'Italy', 'IT'),
(2, 10435, 'Greece', 'GR'),
(3, 10001, 'USA', 'US');
#inserisco dati in state

INSERT INTO sales (salesID, salesDetailID, productID, stateID, OrderDate, ShipDate, Quantity, SalesAmount) VALUES
(1001, 1, 1, 1, '2024-11-01', '2024-11-03', 3, 120.00),
(1001, 2, 2, 1, '2024-11-01', '2024-11-03', 2, 50.00),
(1002, 1, 3, 2, '2025-01-10', '2025-01-12', 1, 22.00),
(1003, 1, 4, 3, '2025-02-15', '2025-02-18', 4, 110.00),
(1004, 1, 5, 1, '2025-03-01', '2025-03-03', 2, 70.00),
(1005, 1, 6, 2, '2025-03-10', '2025-03-13', 1, 50.00),
(1006, 1, 7, 3, '2025-04-01', '2025-04-04', 5, 130.00),
(1007, 1, 8, 1, '2025-05-01', NULL, 1, 35.00),
(1008, 1, 9, 2, '2025-05-10', NULL, 3, 50.00),
(1009, 1, 10, 3, '2025-05-15', NULL, 2, 70.00); 
# inserisco dati in Sales


/*TASK 4-
1)	Verificare che i campi definiti come PK siano univoci. In altre parole, 
scrivi una query per determinare l’univocità dei valori di ciascuna PK (una query per tabella implementata).*/

#inizio verificando l'univocita di PK in category
SELECT  categoryID,
		COUNT(*)
FROM category
GROUP BY categoryID
HAVING COUNT(*) > 1;
#Il risultato e' vuoto, quindi non c'e piu di 1 elemento per categoryID

#PK in region
SELECT 	regionID,
		COUNT(*)
FROM region
GROUP BY regionID
HAVING COUNT(*) > 1;
#Confermata univocita

#PK in product
SELECT  productID,
		COUNT(*)
FROM product
GROUP BY productID
HAVING COUNT(*) > 1;
#Confermata univocita

#PK in state
SELECT  stateID,
		COUNT(*)
FROM state
GROUP BY stateID
HAVING COUNT(*) > 1;
#Confermata

#PK in sales
SELECT  salesID,
		salesDetailID,
        COUNT(*) 
FROM sales 
GROUP BY salesID, salesDetailID 
HAVING COUNT(*) > 1;
#confermata

/*2)Esporre l’elenco delle transazioni indicando nel result set il codice documento, la data,
 il nome del prodotto, la categoria del prodotto, il nome dello stato,
 il nome della regione di vendita e un campo booleano valorizzato in base alla condizione 
 che siano passati più di 180 giorni dalla data vendita o meno (>180 -> True, <= 180 -> False)*/

##### CI HO MESSO UN PO PER TROVARE UN MODO E HO VOLUTO LASCIARE TUTTA LA TRACCIA DI QUELLO PROVATO QUI
/*
SELECT DATEDIFF(CURDATE(), OrderDate) AS Oltre180Giorni FROM Sales
WHERE DATEDIFF(CURDATE(), OrderDate) = (select DATEDIFF(CURDATE(), OrderDate) AS Oltre180Giorni from sales
where DATEDIFF(CURDATE(), OrderDate) > 180);

select DATEDIFF(CURDATE(), OrderDate) AS Oltre180giorni from sales
where DATEDIFF(CURDATE(), OrderDate) > 180;

SELECT * FROM Sales;

SELECT DATEDIFF(CURDATE(), OrderDate) > 180 AS Oltre180Giorni FROM Sales;*/
SELECT  s.salesID AS CodiceDocumento,
		s.OrderDate,
		p.ProductName,
		c.CategoryName,
		st.StateName,
		r.RegionName,
		DATEDIFF(CURDATE(), s.OrderDate) > 180 AS Oltre180Giorni #QUESTO MODO RESTITUISCE QUANTO RICHIESTO
FROM Sales S
JOIN product p ON s.productID = p.productID
JOIN category c ON p.categoryID = c.categoryID
JOIN state st ON s.stateID = st.stateID
JOIN region r ON st.regionID = r.regionID
ORDER BY CodiceDocumento ASC;

/*3)Esporre l’elenco dei prodotti che hanno venduto, in totale, una quantità maggiore della media delle vendite realizzate
 nell’ultimo anno censito. (ogni valore della condizione deve risultare da una query e non deve essere inserito a mano).
 Nel result set devono comparire solo il codice prodotto e il totale venduto.*/

#prima faccio una query per scoprire l'ultimo anno
SELECT MAX(YEAR(OrderDate)) AS LastYear FROM sales;  #1- la query ritorna 1 valore ideale per essere usato in subquery (non inserendo il valore a mano come richiesto)

SELECT  s.productID,
        p.ProductName,
		sum(s.quantity) AS quantitySUM
FROM sales s
JOIN product p ON p.productID = s.productID
WHERE YEAR(s.OrderDate) = (SELECT MAX(YEAR(OrderDate)) AS LastYear FROM sales)
GROUP BY productID 
HAVING SUM(s.quantity) > (SELECT AVG(sumquantity) AS Avg_Generale FROM ( #5 - inestato in HAVING PERCHE VIENE ESECUTATA DOPO LA GROUP BY, LA QUERY SCRITTA IN 4, COSI CONFRONTA OGNI VALORE CON QUELLO RESTITUITO IN QUESTA QUERY, SE MAGGIORE LO MOSTRA ALTRIMENTI LO NASCONDE
SELECT SUM(Quantity) AS sumquantity 
FROM sales 
WHERE YEAR(OrderDate) = (SELECT MAX(YEAR(OrderDate)) FROM sales) GROUP BY productID)
AS sub)
ORDER BY quantitySUM desc;  #2- MI RITORNA IL TOTALE DI OGNI PRODOTTO PER L'ULTIMO ANNO 

SELECT AVG(sumquantity) AS Avg_Generale FROM ( #4- a questo punto pero mi serve la media del totale venduto basta fare avg di tutto quello scritto prima (media dei prodotti in generale da inestare dentro la query sopra)
SELECT SUM(Quantity) AS sumquantity 
FROM sales 
WHERE YEAR(OrderDate) = (SELECT MAX(YEAR(OrderDate)) FROM sales) GROUP BY productID)
AS sub; #3- mi restituisce la SOMMA TOTALE DEI PRODOTTI NELL ULTIMO ANNO (aggiunto ALIAS dopo passo 4 perche mi dava errore a riconoscere tutta la tabella derivata


/*4) Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno. */
SELECT 	ProductName,
		YEAR(s.OrderDate) AS OrderYear,
        SUM(s.SalesAmount) AS SalesAmount
FROM sales s	
JOIN product p ON s.productID = p.productID
GROUP BY p.ProductName, YEAR(s.OrderDate)
ORDER BY OrderYear DESC;

/*5)Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente.*/
SELECT  StateName,
		YEAR(s.OrderDate) AS OrderYear,
        SUM(s.SalesAmount) AS SalesAmount
FROM sales s
JOIN state st ON s.stateID = st.stateID
GROUP BY st.StateName, YEAR(s.OrderDate)
ORDER BY StateName, OrderYear DESC; #ESERCIZIO MOLTO SIMILE A QUELLO SOPRA


/*6)Rispondere alla seguente domanda: qual è la categoria di articoli maggiormente richiesta dal mercato?*/

SELECT  c.CategoryName,
		SUM(s.quantity) AS QuantitySUM
FROM sales s
JOIN product p ON s.productID = p.productID
JOIN category c ON p.categoryID = c.categoryID
GROUP BY CategoryName #MI DA IN OUTPUT L'ELENCO DELLE CATEGORIE E LA QUANTITA TOTALE VENDUTA
ORDER BY QuantitySUM DESC #Ordino in modo decrescente cosi da avere nella prima riga quello piu venduto
LIMIT 1; #limito l'output solo alla prima riga, cosi da mostrare solo quello piu venduto

/*7) Rispondere alla seguente domanda: quali sono i prodotti invenduti? Proponi due approcci risolutivi differenti.*/
#Come primo approccio mi viene in mente la NOT IN di prodottiID-sales
SELECT  productID,
		ProductName
FROM product
WHERE productID NOT IN (SELECT DISTINCT productID FROM sales);

#Come secondo si potrebbe fare una JOIN tra product e sales cosi da mettere in evidenza solo quello non venduti (LEFT JOIN)
SELECT 	p.productID, 
		p.ProductName
FROM product p
LEFT JOIN sales s ON p.productID = s.productID
WHERE s.productID IS NULL;

/*8)Creare una vista sui prodotti in modo tale da esporre una “versione denormalizzata” 
delle informazioni utili (codice prodotto, nome prodotto, nome categoria)*/

CREATE VIEW view_product AS
SELECT  p.productID,
		p.ProductName,
        c.CategoryName
FROM product p
JOIN category c ON p.categoryID = c.categoryID;
SELECT * FROM view_product; #seleziono per controllare

/*9)Creare una vista per le informazioni geografiche*/

CREATE VIEW view_geogrphy AS
SELECT  st.stateID,
		st.StateName,
		st.StateCode,
		r.RegionName,
		r.RegionCode
FROM state st
JOIN region r ON st.regionID = r.regionID;
SELECT * FROM view_geography; #mi sono accorto di aver sbagliato nome manca una A 

DROP VIEW view_geogrphy;
CREATE VIEW view_geography AS
SELECT  st.stateID,
		st.StateName,
		st.StateCode,
		r.RegionName,
		r.RegionCode
FROM state st
JOIN region r ON st.regionID = r.regionID;
SELECT * FROM view_geography;
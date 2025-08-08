CREATE DATABASE Store;
USE store;
CREATE TABLE negozi (
IDnegozio INT AUTO_INCREMENT PRIMARY KEY,
NomeNegozio VARCHAR(50) NOT NULL, 
DataApertura DATE NOT NULL,
IDgeo INT NOT NULL,
CONSTRAINT FK_store_geografia FOREIGN KEY (IDgeo) REFERENCES geografia(IDgeo)
);

CREATE TABLE geografia (
IDgeo INT AUTO_INCREMENT PRIMARY KEY,
Citta VARCHAR(50) NOT NULL,
Regione VARCHAR(50) NOT NULL,
Paese VARCHAR (50) NOT NULL
);

INSERT INTO negozi (NomeNegozio,DataApertura,IDgeo) VALUES
('La Bottega d\'Arte Milanese', '2019-01-15', 1),
('Antico Mercato Romano', '2020-05-10', 2),
('Sapori Partenopei Boutique', '2018-09-22', 3),
('Torino Elegance Corner', '2021-03-01', 4),
('Florence Vintage Atelier', '2020-11-30', 5),
('Bologna Gourmet Hub', '2019-06-18', 6),
('Laguna Chic Venezia', '2021-07-04', 7),
('Porto Genovese', '2022-01-12', 8),
('Palermo Mediterranea', '2017-04-08', 9),
('Cagliari Mare Nostrum', '2018-12-21', 10),
('Paris Étoile Boutique', '2020-08-15', 11),
('Lyon Lumière Shop', '2021-02-10', 12),
('Marseille Rivage', '2019-09-05', 13),
('Barceloneta Style', '2020-03-22', 14),
('Madrileño Vintage', '2018-07-17', 15),
('Valencia Sol & Co.', '2022-05-01', 16),
('Lisboa Fado Store', '2019-10-10', 17),
('Porto Douro Boutique', '2020-12-25', 18),
('Berlin Kreuzberg Craft', '2021-06-30', 19),
('Hamburg Hafen Loft', '2023-01-01', 20);

INSERT INTO geografia (citta,regione,paese) VALUES
('Milano', 'Lombardia', 'Italia'),
('Roma', 'Lazio', 'Italia'),
('Napoli', 'Campania', 'Italia'),
('Torino', 'Piemonte', 'Italia'),
('Firenze', 'Toscana', 'Italia'),
('Bologna', 'Emilia-Romagna', 'Italia'),
('Venezia', 'Veneto', 'Italia'),
('Genova', 'Liguria', 'Italia'),
('Palermo', 'Sicilia', 'Italia'),
('Cagliari', 'Sardegna', 'Italia'),
('Parigi', 'Île-de-France', 'Francia'),
('Lione', 'Alvernia-Rodano-Alpi', 'Francia'),
('Marsiglia', 'Provenza-Alpi-Costa Azzurra', 'Francia'),
('Barcellona', 'Catalogna', 'Spagna'),
('Madrid', 'Comunità di Madrid', 'Spagna'),
('Valencia', 'Comunità Valenciana', 'Spagna'),
('Lisbona', 'Lisbona', 'Portogallo'),
('Porto', 'Porto', 'Portogallo'),
('Berlino', 'Berlino', 'Germania'),
('Amburgo', 'Amburgo', 'Germania');

SELECT * FROM negozi;
SELECT * FROM geografia;

UPDATE negozi
SET NomeNegozio = 'Eleganza Torinese'
WHERE IDnegozio = 24
;
UPDATE negozi
SET NomeNegozio = 'Pasticceria Genovese' , IDgeo = 4
WHERE IDnegozio = 28
;

START TRANSACTION;
UPDATE geografia
SET citta = 'Caserta'
WHERE IDgeo = 3;
SELECT * FROM geografia; #devo togliere autocommit per vedere la transazione command (SET autocommit = 0)
ROLLBACK;

ALTER TABLE geografia
ADD IDlocalIp INT UNIQUE;


SET autocommit = 0;
START TRANSACTION;
DELETE FROM geografia
WHERE IDgeo = 21;
SELECT * FROM geografia;
ROLLBACK;
SET autocommit = 1;

INSERT INTO geografia (citta, regione, paese) 
VALUES ('Montichiari', 'Brescia', 'Italia');

DESCRIBE geografia;

ALTER TABLE geografia
MODIFY citta VARCHAR(100); 

SHOW CREATE TABLE negozi;
SHOW CREATE TABLE geografia;

UPDATE geografia
SET Citta = 'Peschiera'
WHERE IDgeo = 21;

SELECT * FROM geografia;

DELETE FROM geografia
WHERE IDgeo = 21;


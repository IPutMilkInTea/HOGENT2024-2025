-- Een aantal statements om VoetbalDB te leren kennen
-- Hoeveel wedstrijden zitten er in de databank?
-- 18630
SELECT COUNT(WedstrijdID) FROM Wedstrijd

-- Van hoeveel wedstrijden zijn er doelpunten beschikbaar in de databank?
-- 14258
SELECT COUNT(DISTINCT wedstrijdID)
FROM doelpunt

-- Wat is het eerste seizoen in de databank?
-- 1960/1961
SELECT MIN(Seizoen) FROM Klassement

-- Wat is het laatste seizoen in de databank
-- 2023/2024
SELECT MAX(Seizoen) FROM Klassement

-- Geef het maximum aantal doelpunten dat ooit gescoord werd door een ploeg gedurende een seizoen
-- 100
SELECT MAX(doelpuntenvoor) FROM klassement

-- Welk soort wedstrijden zijn er?
-- Regulier / Playoff_1 / Playoff_2
SELECT DISTINCT wedstrijdtype FROM Wedstrijd

-- Hoeveel reguliere / Playoff_1 / Playoff_2 wedstrijden zitten er in de databank?
-- Playoff_1	336
-- Regulier	17906
-- Playoff_2	388

SELECT wedstrijdtype, COUNT(wedstrijdID)
FROM wedstrijd
GROUP BY wedstrijdtype

-- Het aantal speeldagen verschilt per seizoen. Geef het aantal speeldagen per seizoen.
-- 1960/1961 	30
-- ...
-- 1973/1974 	30
-- 1974/1975 	38
-- 1975/1976 	38
-- 1976/1977 	34
-- ...
SELECT seizoen, MAX(speeldag)
FROM klassement
GROUP BY seizoen
ORDER BY seizoen


-- Geef het aantal matchen waarbij de thuisploeg won met meer dan 2 doelpunten verschil 
-- 2429
SELECT COUNT(WedstrijdID)
FROM Wedstrijd
WHERE EindstandThuis > EindstandUit + 2

-- Hoe vaak eindigt een reguliere wedstrijd op 0-0
-- 1502
SELECT COUNT(WedstrijdID) 
FROM Wedstrijd
WHERE EindstandThuis = 0 AND EindstandUit = 0 AND wedstrijdtype = 'regulier'

-- Hoe vaak eindigt een wedstrijd op gelijkstand?
-- 4807
SELECT COUNT(WedstrijdID) 
FROM Wedstrijd
WHERE EindstandThuis = EindstandUit 

-- In hoeveel wedstrijden bedroeg het totaal aantal doelpunten meer dan 10 (10 exclusief)?
-- 16
SELECT COUNT(DISTINCT wedstrijdID)
FROM Wedstrijd
WHERE EindstandThuis + EindstandUit > 10


-- Maak een overzicht van hoe vaak elke eindstand voorkomt in de databank
--Eindstand	Aantal
--1:1	2135
--1:0	1742
--0:0	1544
--2:0	1524
--2:1	1507
--0:1	1112
--1:2	1010
--3:1	996
--2:2	963
--3:0	853

SELECT CONCAT(eindstandthuis, ':', eindstanduit) As Eindstand, COUNT(WedstrijdID) As Aantal
FROM Wedstrijd
GROUP BY CONCAT(eindstandthuis, ':', eindstanduit)
ORDER BY 2 DESC



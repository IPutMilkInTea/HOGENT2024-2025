-- Wat was de grootste waarde voor het aantal speeldagen per seizoen?
-- Geef de seizoenen met het aantal speeldagen = maximum aantal speeldagen
--seizoen	aantal speeldagen
--1975/1976 	38
--1974/1975 	38

SELECT seizoen, MAX(speeldag) As 'aantal speeldagen'
FROM klassement
GROUP BY seizoen
HAVING MAX(speeldag) = (SELECT MAX(speeldag) FROM klassement)


-- Geef de ploegen en seizoenen die het maximum aantal doelpunten scoorden in een seizoen
--seizoen	doelpuntenvoor	ploegnaam
--1984/1985 	100	RSC Anderlecht
SELECT DISTINCT k.seizoen, k.doelpuntenvoor, p.ploegnaam
FROM klassement k JOIN ploeg p ON k.stamnummer = p.stamnummer
WHERE k.doelpuntenvoor = (SELECT MAX(doelpuntenvoor) FROM klassement)

-- Geef een overzicht van de ploegen met het grootste aantal verloren matchen in het klassement
--ploegnaam	seizoen	aantalverloren
--Beerschot	2021/2022 	26
--KSC Hasselt	1979/1980 	26
SELECT DISTINCT p.ploegnaam, k.seizoen, k.aantalverloren
FROM ploeg p JOIN klassement k ON p.stamnummer = k.stamnummer
WHERE aantalverloren = (SELECT MAX(aantalverloren) FROM klassement)

-- Geef een overzicht van de ploegen die altijd deelnamen aan de competitie
--ploegnaam	Aantal competities
--Club Brugge	64
--RSC Anderlecht	64
--Standard Luik	64
SELECT p.ploegnaam, COUNT(DISTINCT seizoen) As 'Aantal competities'
FROM ploeg p JOIN klassement k ON p.stamnummer = k.stamnummer
GROUP BY p.ploegnaam
HAVING COUNT(DISTINCT seizoen) = (SELECT COUNT(DISTINCT seizoen) FROM klassement)

-- In hoeveel matchen werd de gelijkmaker in het laatste kwartier gescoord?
-- Merk op dat van sommige wedstrijden het doelpuntenverloop niet bekend is 
-- (=> het aantal wedstrijden met gelijk aantal doelpunten levert na JOIN met Doelpunt levert minder resultaten op)
-- 959
SELECT COUNT(DISTINCT w.wedstrijdID)
FROM wedstrijd w JOIN doelpunt d ON w.wedstrijdID = d.wedstrijdid
WHERE w.eindstandthuis = w.eindstanduit AND 1 = (SELECT COUNT(doelpuntID) FROM doelpunt WHERE wedstrijdid = w.wedstrijdID AND scoreminuten BETWEEN 76 AND 90)


-- Zijn er ploegen die in de helft van het seizoen nog géén enkele wedstrijd verloren hadden?
--seizoen	stamnummer	ploegnaam	aantalverloren
--1971/1972 	3	Club Brugge	0
--1974/1975 	47	RWD Molenbeek	0
--1984/1985 	35	RSC Anderlecht	0
--1986/1987 	2300	KSK Beveren	0
--1987/1988 	1	Royal Antwerp FC	0
--1989/1990 	25	KV Mechelen	0
--1997/1998 	3	Club Brugge	0
--2000/2001 	35	RSC Anderlecht	0
--2007/2008 	16	Standard Luik	0
--2018/2019 	322	KRC Genk	0
--2019/2020 	3	Club Brugge	0
SELECT seizoen, p.stamnummer, p.ploegnaam, aantalverloren
FROM klassement kl JOIN ploeg p ON kl.stamnummer = p.stamnummer
WHERE aantalverloren = 0 AND speeldag = (SELECT MAX(speeldag) / 2 FROM klassement kl1 WHERE kl1.seizoen = kl.seizoen)


-- Hoeveel seizoenen werd een gegeven ploeg kampioen? Dit wil zeggen, stond de ploeg op positie 1 in het klassement op de laatste speeldag.
-- Hoe ga je de laatste speeldag van een seizoen berekenen?
-- Verander de inhoud van de variabele @ploegnaam van 'RSC Anderlecht' naar 'Anderlecht'. Hoe moet je de query aanpassen?
DECLARE @ploegnaam VARCHAR(255) = 'Anderlecht'
SELECT COUNT(DISTINCT seizoen) 
FROM klassement kl JOIN ploeg p ON kl.stamnummer = p.stamnummer
WHERE speeldag = (SELECT MAX(speeldag) FROM klassement kl1 WHERE kl1.seizoen = kl.seizoen) AND positie = 1 AND p.ploegnaam LIKE '%' + @ploegnaam + '%'


-- Geef de seizoenen waarbij de opgegeven ploeg (op de laatste speeldag) niet eindigde in de Top 4 van het klassement
--Seizoen	Positie
--1968/1969 	5
--1972/1973 	5
--1979/1980 	6
--2019/2020 	8
--2022/2023 	11
DECLARE @ploegnaam VARCHAR(255) = 'RSC Anderlecht'
SELECT Seizoen, Positie
FROM Klassement kl JOIN Ploeg p ON kl.Stamnummer = p.stamnummer
WHERE p.ploegnaam = @ploegnaam AND speeldag = (SELECT MAX(Speeldag) FROM klassement kl1 WHERE kl.seizoen = kl1.seizoen) AND positie > 4


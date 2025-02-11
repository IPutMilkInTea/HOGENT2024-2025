-- Creëer het onderstaande overzicht van een geselecteerde ploeg voor een geselecteerd seizoen.
--Speeldag	Positie
--1			4
--2			3
--3			2
--4			3
--5			6
--6			6
--7			6
--8			5
--9			6
-- ...
DECLARE @ploegnaam VARCHAR(255) = 'Club Brugge'
DECLARE @seizoen VARCHAR(10) = '2014/2015'
SELECT k.Speeldag, k.Positie
FROM Klassement k JOIN Ploeg p ON k.Stamnummer = p.stamnummer
WHERE k.Seizoen = @seizoen AND p.ploegnaam = @ploegnaam

-- Geef de namen van de ploegen en de seizoenen die op de 10de speeldag nog geen enkele match hadden gewonnen
--seizoen	ploegnaam
--1964/1965 	KFC Diest
--1965/1966 	Cercle Brugge
--1972/1973 	KFC Diest
--1973/1974 	Beerschot
--1974/1975 	KFC Diest
--1974/1975 	KRC Genk
--1975/1976 	KV Mechelen
--1978/1979 	Berchem Sport
--1978/1979 	KV Kortrijk
--...
SELECT k.seizoen, p.ploegnaam
FROM Klassement k JOIN Ploeg p ON k.Stamnummer = p.stamnummer
WHERE k.Speeldag = 10 AND k.AantalGewonnen = 0
ORDER BY k.seizoen


-- Als de ploegnaam van een club wordt gegeven, hoeveel jaar nam die ploeg deel aan de competitie?
-- 14
DECLARE @ploegnaam VARCHAR(255) = 'KV Oostende'
SELECT COUNT(DISTINCT Seizoen) 
FROM Klassement kl JOIN Ploeg p ON kl.stamnummer = p.stamnummer
WHERE p.ploegnaam = @ploegnaam


-- Als de ploegnamen van 2 clubs worden gegeven, bereken dan hoe vaak de beide ploegen scoorden in de vroegere duels.
-- 52
DECLARE @ploegnaam1 VARCHAR(255) = 'Club Brugge'
DECLARE @ploegnaam2 VARCHAR(255) = 'Cercle Brugge'
SELECT COUNT(DISTINCT w.WedstrijdID)
FROM Wedstrijd w JOIN Ploeg p1 ON w.stamnummerthuis = p1.stamnummer
JOIN Ploeg p2 ON w.stamnummeruit = p2.stamnummer
WHERE p1.ploegnaam in (@ploegnaam1, @ploegnaam2) AND p2.ploegnaam in (@ploegnaam1, @ploegnaam2) AND w.eindstandthuis > 0 AND w.eindstanduit > 0

-- Bij het wedden in de Play Offs zou je eventueel kunnen rekening houden met hoeveel ervaring een club heeft met spelen van de Play Offs
-- Als de ploegnaam van een club gegeven wordt, laat dan zien hoeveel seizoenen een club in Play Off 1 en in Play Off 2 heeft gespeeld tot nu toe.
-- 65
DECLARE @ploegnaam VARCHAR(255) = 'Club Brugge'
SELECT COUNT(DISTINCT YEAR(Speeldatum)) 
FROM Wedstrijd w JOIN Ploeg p1 ON w.stamnummerthuis = p1.stamnummer 
JOIN Ploeg p2 ON w.stamnummeruit = p2.stamnummer
WHERE p1.ploegnaam = @ploegnaam OR p2.ploegnaam = @ploegnaam AND w.wedstrijdType IN ('Playoff_1', 'Playoff_2')




-- Geef de wedstrijden (wedstrijdID, speeldatum, ploegnaam1, ploegnaam2, eindstandthuis, eindstanduit) waar het totaal aantal doelpunten meer dan 10 bedraagt (10 exclusief).
--wedstrijdID	speeldatum	ploegnaam	ploegnaam	eindstandthuis	eindstanduit
--77	1960-11-27	Beerschot	Eendracht Aalst	9	2
--755	1963-10-06	KFC Diest	Beerschot	6	5
--971	1964-09-13	RFC Luik	Beringen FC	8	3
--1049	1964-12-06	RFC Tilleur	Royal Antwerp FC	10	1
--1433	1966-05-14	RSC Anderlecht	Cercle Brugge	12	0
--2096	1969-03-09	Club Brugge	Daring Club Brussel	9	2
--2638	1971-05-09	KAA Gent	Union Saint-Gilloise	4	8
--5098	1979-10-28	Standard Luik	KRC Genk	12	0
--5122	1979-11-17	KSC Lokeren	KSC Hasselt	10	1
--5474	1981-01-25	KSC Lokeren	Berchem Sport	10	1
--6539	1984-08-22	Racing Jet Brussel	RSC Anderlecht	2	9
--6807	1985-05-12	Club Brugge	K. Sint-Niklase SK	9	4
--9023	1992-09-06	R Charleroi SC	Boom FC	7	4
--9258	1993-04-30	Standard Luik	KAA Gent	8	4
--11122	1999-08-08	KVC Westerlo	KRC Genk	6	6
--15587	2014-05-17	KV Oostende	KV Kortrijk	9	8

SELECT wedstrijdID, speeldatum, p1.ploegnaam, p2.ploegnaam, eindstandthuis, eindstanduit 
FROM Wedstrijd w JOIN Ploeg p1 ON w.stamnummerThuis = p1.stamnummer 
JOIN Ploeg p2 ON w.stamnummerUit = p2.stamnummer  
WHERE EindstandThuis + EindstandUit > 10




-- Voeg een kolom Seizoen toe aan Wedstrijd. Dit is iets wat nog zal terugkomen in volgende oefeningen
--wedstrijdID	speeldatum	stamnummerThuis	stamnummerUit	Seizoen
--1	1960-09-04	90	1	1960/1961
--2	1960-09-04	553	30	1960/1961
--3	1960-09-04	246	35	1960/1961
--4	1960-09-04	373	16	1960/1961
--5	1960-09-04	13	33	1960/1961
--6	1960-09-04	2	3434	1960/1961
--7	1960-09-04	3	10	1960/1961
--8	1960-09-04	4	7	1960/1961
--9	1960-09-11	35	4	1960/1961
--10	1960-09-11	33	553	1960/1961
SELECT wedstrijdID, speeldatum, stamnummerThuis, stamnummerUit,
CASE
	WHEN MONTH(speeldatum) IN (1, 2, 3, 4, 5, 6) THEN CAST(YEAR(speeldatum) - 1 AS varchar) + '/' + CAST(YEAR(speeldatum) AS varchar)
	ELSE CAST(YEAR(speeldatum) AS varchar) + '/' + CAST(YEAR(speeldatum) + 1 AS varchar)
END As Seizoen
FROM Wedstrijd

-- Breid de vorige oefening uit zodat nu de namen van de ploegen er staan in plaats van de stamnummers
--wedstrijdID	speeldatum	ploegnaam	ploegnaam	Seizoen
--1	1960-09-04	Eendracht Aalst	Royal Antwerp FC	1960/1961
--2	1960-09-04	Waterschei SV Thor	Lierse SK	1960/1961
--3	1960-09-04	Olympic Charleroi	RSC Anderlecht	1960/1961
--4	1960-09-04	Sint-Truidense VV	Standard Luik	1960/1961
--5	1960-09-04	Beerschot	Verviétois	1960/1961
--6	1960-09-04	Daring Club Brussel	Patro Eisden	1960/1961
--7	1960-09-04	Club Brugge	Union Saint-Gilloise	1960/1961
--8	1960-09-04	RFC Luik	KAA Gent	1960/1961
--9	1960-09-11	RSC Anderlecht	RFC Luik	1960/1961
--10	1960-09-11	Verviétois	Waterschei SV Thor	1960/1961
SELECT wedstrijdID, speeldatum, p1.ploegnaam, p2.ploegnaam,
CASE
	WHEN MONTH(speeldatum) IN (1, 2, 3, 4, 5, 6) THEN CAST(YEAR(speeldatum) - 1 AS varchar) + '/' + CAST(YEAR(speeldatum) AS varchar)
	ELSE CAST(YEAR(speeldatum) AS varchar) + '/' + CAST(YEAR(speeldatum) + 1 AS varchar)
END As Seizoen
FROM Wedstrijd w JOIN Ploeg p1 ON w.stamnummerThuis = p1.stamnummer 
JOIN Ploeg p2 ON w.stamnummerUit = p2.stamnummer  

-- Geef een overzicht van het aantal seizoenen dat elke ploeg deelnam aan de competitie
--ploegnaam	Aantal seizoenen
--Club Brugge	64
--RSC Anderlecht	64
--Standard Luik	64
--KAA Gent	53
--Lierse SK	50
--R Charleroi SC	49
--Cercle Brugge	48
--Royal Antwerp FC	47
--KV Mechelen	45
--...
SELECT ploegnaam, COUNT(DISTINCT seizoen) As 'Aantal seizoenen'
FROM ploeg p JOIN klassement k ON p.stamnummer = k.stamnummer
GROUP BY ploegnaam
ORDER BY 2 DESC


-- Breid de vorige query uit: geef een overzicht van de ploegen die 40 keer of meer deelnamen aan de competitie
--ploegnaam	Aantal seizoenen
--Club Brugge	64
--RSC Anderlecht	64
--Standard Luik	64
--KAA Gent	53
--Lierse SK	50
--R Charleroi SC	49
--Cercle Brugge	48
--Royal Antwerp FC	47
--KV Mechelen	45
--Sint-Truidense VV	44
--KSC Lokeren	42
--KRC Genk	42
SELECT ploegnaam, COUNT(DISTINCT seizoen) As 'Aantal seizoenen'
FROM ploeg p JOIN klassement k ON p.stamnummer = k.stamnummer
GROUP BY ploegnaam
HAVING COUNT(DISTINCT seizoen) >= 40
ORDER BY 2 DESC



-- Geef per ploeg het maximum aantal wedstrijden dat ze ooit wonnen gedurende een seizoen
--ploegnaam	Aantal gewonnen matchen
--AFC Tubize	7
--AS Oostende KM	10
--Beerschot	19
--Berchem Sport	11
--Beringen FC	16
--Boom FC	6
--Cercle Brugge	17
--Club Brugge	26
SELECT ploegnaam, MAX(AantalGewonnen) As 'Aantal gewonnen matchen'
FROM ploeg p JOIN klassement k ON p.stamnummer = k.stamnummer
GROUP BY ploegnaam


-- Geef de ploegen die nooit meer dan 10 keer wonnen gedurende een seizoen
--ploegnaam	Aantal gewonnen matchen
--AS Oostende KM	10
--KAS Eupen	10
--KSV Roeselare	10
--Racing Mechelen	10
--RCC Schaerbeek	9
--Racing Jet Brussel	9
--FCV Dender EH	9
--Waasland-Beveren	9
--Olympic Charleroi	8
--AFC Tubize	7
--Heusden-Zolder	7
--KFC Turnhout	7
--K. Sint-Niklase SK	6
--Boom FC	6
--Patro Eisden	6
--RWDM	5
--Verviétois	5
--KFC Verbroedering Geel	5
--KSC Hasselt	2
SELECT ploegnaam, MAX(AantalGewonnen) As 'Aantal gewonnen matchen'
FROM ploeg p JOIN klassement k ON p.stamnummer = k.stamnummer
GROUP BY ploegnaam
HAVING MAX(AantalGewonnen) <= 10
ORDER BY 2 DESC





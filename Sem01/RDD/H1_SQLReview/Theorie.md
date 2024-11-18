# H1 SQL Review

1. **Basisaggregaties**:
   - **COUNT()**: Telt het aantal rijen, zoals het aantal producten of medewerkers.
   - **SUM()**: Totaliseert de waarden in een numerieke kolom, zoals de voorraadhoeveelheden.
   - **MIN() en MAX()**: Haalt de kleinste of grootste waarden op, bijvoorbeeld geboortedatums of productprijzen.

2. **Voorwaardelijke Filtering met `WHERE`**:
   - Filtert specifieke rijen op basis van voorwaarden, zoals het selecteren van medewerkers met een bepaalde functietitel (`Title = 'Sales Representative'`) of producten onder een bepaalde prijs.

3. **Datumfuncties**:
   - **DATEDIFF**: Berekent het verschil tussen twee datums, zoals in het bepalen van hoe dicht medewerkers bij de pensioenleeftijd van 65 jaar zijn.

4. **Groeperen van Gegevens**:
   - **GROUP BY**: Groepeert rijen met dezelfde waarden in gespecificeerde kolommen; bijvoorbeeld leveranciers groeperen per land of producten per categorie.
   - **HAVING**: Filtert gegroepeerde rijen na aggregatie, zoals het tonen van alleen landen met meer dan één leverancier of leveranciers met minimaal vijf producten onder een bepaalde prijs.

5. **Sorteren van Gegevens**:
   - **ORDER BY**: Rangschikt de uitvoer op basis van gespecificeerde kolommen, zoals het alfabetisch sorteren van landen of het ordenen van leveranciers op naam.

6. **Joins**:
   - **INNER JOIN**: Combineert rijen uit verschillende tabellen waar er een overeenkomst is in gespecificeerde kolommen, zoals het koppelen van leveranciers en producten of producten en categorieën.
   - **LEFT JOIN**: Neemt alle rijen uit de linker tabel op, ook als er geen overeenkomsten zijn in de rechter tabel. Dit werd gebruikt in de query die medewerkers toont met of zonder gekoppelde bestellingen.

7. **Unieke Waarden**:
   - **DISTINCT**: Verwijdert dubbele rijen in de resultaten, zoals bij het verzekeren dat elke leverancier die zuivelproducten levert slechts één keer wordt weergegeven.

8. **Kolom Aliassen**:
   - Tijdelijke namen toekennen aan kolommen (`AS`) om de uitvoer duidelijker te maken, zoals het hernoemen van kolommen als 'Aantal producten' of 'Minimum UnitPrice'.

9. **Complexe Aggregaties en Subtotalen**:
   - Het tellen van unieke bestellingen per leverancier, het vinden van de minimale en maximale hoeveelheden per product, of het samenvatten van producten per categorie toont het gebruik van aggregaties op meerdere niveaus.

10. **Omgaan met NULL-waarden**:
    - Omgaan met potentiële NULL-waarden in gegevens, zoals met `LEFT JOIN`, waarbij niet elke medewerker al bestellingen heeft, en alle medewerkers toch worden weergegeven.

Deze technieken zijn essentieel in SQL voor het uitvoeren van uitgebreide data-analyse, het samenvatten van gegevens en het opstellen van inzichten uit meerdere tabellen. Deze oefeningen demonstreren SQL-vaardigheden die breed toepasbaar zijn voor het uitvoeren van query's en rapportages in relationele databases.

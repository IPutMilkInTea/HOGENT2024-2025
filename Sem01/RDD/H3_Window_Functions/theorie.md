# H3 Window-functies in SQL

Window-functies maken het mogelijk om vergelijkingen en berekeningen te maken binnen specifieke delen van de dataset, zoals verkoopcijfers per jaar of per klant. Dit kan handig zijn voor bedrijfsanalyses waarbij bijvoorbeeld de huidige omzet wordt vergeleken met de vorige maand of het gemiddelde van de laatste drie maanden. Window-functies zijn efficiënter dan subquery's en maken gebruik van de `OVER`-clausule om de data op te delen.

## De `OVER`-clausule

Met de `OVER`-clausule kunnen we een "venster" definiëren over een bepaalde dataset. Door een dataset op te delen in partities (`PARTITION BY`) en deze vervolgens te ordenen (`ORDER BY`), kunnen we bepaalde berekeningen per partitie uitvoeren. Bijvoorbeeld het berekenen van een lopende som of het bepalen van de rang binnen een partitie.

```sql
-- Voorbeeld: Geef een overzicht van UnitsInStock per categorie en per product
SELECT CategoryID, ProductID, UnitsInStock
FROM Products
ORDER BY CategoryID, ProductID;
```

**Lopende som per categorie**  
Hier berekenen we een cumulatieve som per `CategoryID` voor `UnitsInStock` door een venster te maken binnen elke categorie.

```sql
SELECT CategoryID, ProductID, UnitsInStock,
       SUM(UnitsInStock) OVER (PARTITION BY CategoryID ORDER BY ProductID) AS TotalUnitsInStockPerCategory
FROM Products;
```

In plaats van een subquery voor elke rij, gebruikt de `OVER`-clausule minder rekenkracht door de som slechts één keer per categorie te berekenen.

---

## Berekeningen over meerdere jaren

Window-functies zijn bijzonder nuttig bij tijdsafhankelijke data, zoals jaar-op-jaar vergelijkingen.

```sql
-- Geef het cumulatieve aantal bestellingen per klant voor elk jaar
WITH cte AS (
    SELECT CustomerID, YEAR(OrderDate) AS OrderYear, COUNT(OrderID) AS NumberOfOrders
    FROM Orders
    GROUP BY CustomerID, YEAR(OrderDate)
)
SELECT *,
       SUM(NumberOfOrders) OVER (PARTITION BY CustomerID ORDER BY OrderYear) AS TotalOrders
FROM cte;
```

---

## RANGE-opties binnen `OVER`

De `RANGE`-optie geeft aan welke rijen in het venster moeten worden meegenomen voor de berekening. Dit kan bijvoorbeeld zijn:

- **RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW**: Van het begin van de partitie tot de huidige rij.
- **RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING**: Van de huidige rij tot het einde van de partitie.

---

## ROWS-opties

Soms wil je niet werken met een logische `RANGE`, maar juist een fysieke offset van rijen. `ROWS` kan worden gebruikt om specifieke aantallen rijen te betrekken in een berekening.

```sql
-- Voorbeeld: Gemiddeld salaris van de werknemer en de twee voorgaande werknemers
SELECT EmployeeID, FirstName + ' ' + LastName AS FullName, Salary,
       AVG(Salary) OVER (ORDER BY Salary DESC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS AvgSalary2Preceding
FROM Employees;
```

---

## Rangschikkingsfuncties

Window-functies zoals `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()` en `PERCENT_RANK()` kunnen worden gebruikt om rijen binnen een partitie te rangschikken.

- **ROW_NUMBER()**: Geeft een opeenvolgend nummer aan elke rij binnen een partitie.
- **RANK()**: Geeft dezelfde rang aan rijen met dezelfde waarde en slaat nummers over bij gelijkstand.
- **DENSE_RANK()**: Geeft dezelfde rang aan rijen met dezelfde waarde, maar zonder hiaten.
- **PERCENT_RANK()**: Geeft de relatieve positie van een rij binnen een partitie als een percentage van 0 tot 1.

```sql
-- Voorbeeld: Geef elke werknemer een rang op basis van salaris
SELECT EmployeeID, FirstName + ' ' + LastName AS FullName, Title, Salary,
       ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNumber,
       RANK() OVER (ORDER BY Salary DESC) AS Rank,
       DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRank,
       PERCENT_RANK() OVER (ORDER BY Salary DESC) AS PercentRank
FROM Employees;
```

---

## LAG en LEAD

Met `LAG` en `LEAD` kun je waarden van de voorgaande of volgende rij binnen een partitie opvragen. Dit kan handig zijn voor berekeningen waarbij je de vorige of volgende rij moet vergelijken, bijvoorbeeld om verschillen tussen opeenvolgende jaren te berekenen.

```sql
-- Verschil in salaris tussen een werknemer en de vorige werknemer
WITH cte AS (
    SELECT EmployeeID, FirstName + ' ' + LastName AS FullName, Salary,
           LAG(Salary) OVER (ORDER BY Salary DESC) AS PrecedingSalary
    FROM Employees
)
SELECT *, Salary - PrecedingSalary AS SalaryDifference
FROM cte;
```

---

## Oefeningen

1. **Maak een overzicht met een volgnummer per klant binnen elk land**:
  
   ```sql
   SELECT country,
          ROW_NUMBER() OVER (PARTITION BY country ORDER BY CompanyName) AS RowNum,
          CompanyName
   FROM customers
   ORDER BY country;
   ```

2. **Jaar-op-jaar prestatie voor producten**:
   Bereken de verkoop per jaar en vergelijk deze met het vorige jaar:

   ```sql
   WITH cte AS (
       SELECT ProductID, YEAR(OrderDate) AS OrderYear, SUM(Quantity) AS AmountSoldPerYear
       FROM Orders o JOIN OrderDetails od ON o.OrderID = od.OrderID
       GROUP BY ProductID, YEAR(OrderDate)
   )
   SELECT ProductID, OrderYear, AmountSoldPerYear,
          LAG(AmountSoldPerYear) OVER (PARTITION BY ProductID ORDER BY OrderYear) AS AmountSoldPreviousYear
   FROM cte;
   ```

3. **Beloningssysteem op basis van omzet per werknemer per jaar**:

   ```sql
   SELECT o.EmployeeID, YEAR(o.OrderDate) AS OrderYear, SUM(od.UnitPrice * od.Quantity) AS Revenue,
          10000 / RANK() OVER (PARTITION BY YEAR(o.OrderDate) ORDER BY SUM(od.UnitPrice * od.Quantity) DESC) AS Bonus
   FROM Orders o JOIN OrderDetails od ON o.OrderID = od.OrderID
   GROUP BY o.EmployeeID, YEAR(o.OrderDate)
   ORDER BY OrderYear, Revenue DESC;
   ```

---

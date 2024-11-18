# H2 SQL Advanced

---

## 1. **Subqueries in de `WHERE`- of `HAVING`-clausule**

### Subqueries met één waarde

Om producten met de hoogste prijs te vinden, gebruiken we een subquery om eerst de maximale prijs te bepalen:

```sql
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice = (SELECT MAX(UnitPrice) FROM Products);
```

### Subqueries met meerdere kolommen

Om klanten op te halen die een bestelling hebben geplaatst, gebruiken we een subquery die alle unieke `CustomerID`s uit de `Orders`-tabel bevat:

```sql
SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID IN (SELECT DISTINCT CustomerID FROM Orders);
```

### Gecorreleerde Subqueries

Om werknemers te vinden die meer verdienen dan het gemiddelde salaris binnen hun afdeling, kan een gecorreleerde subquery helpen:

```sql
SELECT EmployeeID, LastName, Salary
FROM Employees AS e1
WHERE Salary > (SELECT AVG(Salary)
                FROM Employees AS e2
                WHERE e2.DepartmentID = e1.DepartmentID);
```

---

## 2. **`EXISTS` en `NOT EXISTS`-Operatoren**

### Gebruik van `EXISTS`

Deze query haalt klanten op die minstens één bestelling hebben geplaatst:

```sql
SELECT CustomerID, CompanyName
FROM Customers AS c
WHERE EXISTS (SELECT 1
              FROM Orders AS o
              WHERE o.CustomerID = c.CustomerID);
```

### Gebruik van `NOT EXISTS`

Om vervoerders te vinden die geen bestellingen hebben verzonden:

```sql
SELECT ShipperID, CompanyName
FROM Shippers AS s
WHERE NOT EXISTS (SELECT 1
                  FROM Orders AS o
                  WHERE o.ShipVia = s.ShipperID);
```

---

## 3. **Views**

### Een View Maken

Hier is een view om producten op te sommen met een lage voorraad, inclusief leverancierinformatie:

```sql
CREATE VIEW vw_products_to_order AS
SELECT ProductID, ProductName, SupplierID, UnitsInStock
FROM Products
WHERE UnitsInStock < 20;
```

### Een View Bijwerken

Met `CREATE OR ALTER VIEW` kunnen we een bestaande view wijzigen:

```sql
CREATE OR ALTER VIEW vw_products_to_order AS
SELECT ProductID, ProductName, SupplierID, UnitsInStock
FROM Products
WHERE UnitsInStock < 15;
```

### Een View Gebruiken in Queries

Je kunt de view opvragen alsof het een gewone tabel is:

```sql
SELECT ProductID, ProductName
FROM vw_products_to_order
WHERE SupplierID = 5;
```

---

## 4. **Praktische Toepassingen**

### Lopende Totalen

Een gecorreleerde subquery kan cumulatieve totalen berekenen. Hier is een voorbeeld voor cumulatieve vrachtkosten per jaar:

```sql
SELECT OrderID, OrderDate, Freight,
       (SELECT SUM(Freight)
        FROM Orders AS o2
        WHERE YEAR(o2.OrderDate) = YEAR(o1.OrderDate)
          AND o2.OrderID <= o1.OrderID) AS CumulativeFreight
FROM Orders AS o1
ORDER BY OrderDate;
```

### Complexe Filters met Views

Met views kunnen complexe filterlogica worden gecentraliseerd. Bijvoorbeeld een view maken om producten met namen die "Bröd" of "Biscuit" bevatten te volgen:

```sql
CREATE VIEW vw_price_increasing_products AS
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE ProductName LIKE '%Bröd%' OR ProductName LIKE '%Biscuit%';
```

---

## 5. **Common Table Expressions (CTEs)**

### Basale CTEs

CTEs kunnen queries vereenvoudigen, bijvoorbeeld om de minimale prijs per categorie te vinden:

```sql
WITH MinPricePerCategory AS (
    SELECT CategoryID, MIN(UnitPrice) AS MinPrice
    FROM Products
    GROUP BY CategoryID
)
SELECT p.ProductID, p.ProductName, p.UnitPrice, c.MinPrice
FROM Products AS p
JOIN MinPricePerCategory AS c
ON p.CategoryID = c.CategoryID
WHERE p.UnitPrice = c.MinPrice;
```

### Recursieve CTEs

Recursieve CTEs helpen om hiërarchische data door te lopen. Bijvoorbeeld om een lijst van getallen van 1 tot 10 te genereren:

```sql
WITH Numbers AS (
    SELECT 1 AS Num
    UNION ALL
    SELECT Num + 1
    FROM Numbers
    WHERE Num < 10
)
SELECT Num FROM Numbers;
```

### Hiërarchische Data (Medewerkershiërarchie)

Om alle medewerkers te vinden die rapporteren aan een specifieke manager:

```sql
WITH EmployeeHierarchy AS (
    SELECT EmployeeID, ReportsTo
    FROM Employees
    WHERE EmployeeID = 1  -- Startpunt, bijvoorbeeld manager Andrew Fuller
    UNION ALL
    SELECT e.EmployeeID, e.ReportsTo
    FROM Employees AS e
    JOIN EmployeeHierarchy AS eh
    ON e.ReportsTo = eh.EmployeeID
)
SELECT * FROM EmployeeHierarchy;
```

---

## 6. **Vergelijking van CTEs, Views en Subqueries**

### Een View vs. CTE

Views zijn persistent en kunnen opnieuw gebruikt worden, terwijl CTEs tijdelijk zijn binnen één query:

```sql
CREATE VIEW vw_avg_price_per_category AS
SELECT CategoryID, AVG(UnitPrice) AS AvgPrice
FROM Products
GROUP BY CategoryID;
```

Gebruik van een CTE voor tijdelijke resultaten binnen één query:

```sql
WITH AvgPricePerCategory AS (
    SELECT CategoryID, AVG(UnitPrice) AS AvgPrice
    FROM Products
    GROUP BY CategoryID
)
SELECT p.ProductID, p.ProductName, p.UnitPrice
FROM Products AS p
JOIN AvgPricePerCategory AS apc
ON p.CategoryID = apc.CategoryID
WHERE p.UnitPrice > apc.AvgPrice;
```

---

## 7. **Aanvullende Voorbeelden en Oefeningen**

### Filteren van Producten op Specifieke Criteria

Om producten met de laagste of gemiddelde prijzen per categorie te tonen:

```sql
WITH ProductStats AS (
    SELECT CategoryID, MIN(UnitPrice) AS MinPrice, AVG(UnitPrice) AS AvgPrice
    FROM Products
    GROUP BY CategoryID
)
SELECT p.ProductID, p.ProductName, p.UnitPrice, ps.MinPrice, ps.AvgPrice
FROM Products AS p
JOIN ProductStats AS ps
ON p.CategoryID = ps.CategoryID
WHERE p.UnitPrice = ps.MinPrice OR p.UnitPrice = ps.AvgPrice;
```

### Statistieken van Verwerkte Orders per Werknemer

Bereken het gemiddelde aantal orders per werknemer:

```sql
WITH OrderCounts AS (
    SELECT EmployeeID, COUNT(OrderID) AS OrderCount
    FROM Orders
    GROUP BY EmployeeID
)
SELECT e.EmployeeID, e.LastName, oc.OrderCount,
       (SELECT AVG(OrderCount) FROM OrderCounts) AS AvgOrderCount
FROM Employees AS e
LEFT JOIN OrderCounts AS oc
ON e.EmployeeID = oc.EmployeeID;
```

---

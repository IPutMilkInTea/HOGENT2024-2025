# H4 DB Programming SP + Cursors + Triggers + Tables and User Defined Types

Stored procedures en gebruikersgedefinieerde functies zijn programmeerconstructies in SQL Server waarmee je herbruikbare stukjes SQL-code kunt maken. In dit document leg ik uit hoe je deze objecten kunt gebruiken en beheren, inclusief controle-structuren en foutafhandeling.

## 1. Wat zijn Stored Procedures?

Een stored procedure (SP) is een verzameling SQL-opdrachten die als een enkel database-object wordt opgeslagen. Het biedt voordelen zoals herbruikbaarheid, betere prestaties en beveiliging. Een SP kan parameters accepteren, waarden retourneren en controle-logica bevatten (zoals `IF`, `WHILE`).

**Voorbeeld van een Stored Procedure:**

```sql
CREATE OR ALTER PROCEDURE ShowFirstXEmployees @x INT, @missed INT OUTPUT
AS
DECLARE @empid INT = 1, @fullname NVARCHAR(100), @city NVARCHAR(30), @total INT

SELECT @total = COUNT(*) FROM Employees
SET @missed = CASE WHEN @x > @total THEN 0 ELSE @total - @x END

WHILE @empid <= @x
BEGIN
    SELECT @fullname = firstname + ' ' + lastname, @city = city 
    FROM Employees 
    WHERE employeeid = @empid
    PRINT 'Full Name : ' + @fullname
    PRINT 'City : ' + @city
    SET @empid += 1
END
```

### Test de SP

```sql
DECLARE @numberOfMissedEmployees INT
EXEC ShowFirstXEmployees 5, @numberOfMissedEmployees OUT
PRINT 'Number of missed employees: ' + STR(@numberOfMissedEmployees)
```

## 2. Foutafhandeling met `@@error` en `RAISERROR`

Fouten kunnen worden afgehandeld met `@@error` of de meer geavanceerde `TRY ... CATCH`-blokken.

**Eenvoudige foutafhandeling met `@@error`:**

```sql
CREATE OR ALTER PROCEDURE ProductInsert @productName NVARCHAR(50) = NULL, @categoryID INT = NULL AS
DECLARE @errormsg INT
INSERT INTO Products(ProductName, CategoryID, Discontinued) 
VALUES (@productName, @categoryID, 0)

SET @errormsg = @@error
IF @errormsg <> 0 
    PRINT 'ERROR: Could not insert product. Error: ' + STR(@errormsg)
ELSE
    PRINT 'SUCCESS: Product inserted'
RETURN @errormsg
```

## 3. `TRY ... CATCH` voor Uitgebreide Foutafhandeling

Gebruik `TRY ... CATCH` voor gedetailleerde foutinformatie.

```sql
CREATE OR ALTER PROCEDURE DeleteShipper @ShipperID INT, @NumberOfDeletedShippers INT OUT
AS
BEGIN
    BEGIN TRY
        DELETE FROM Shippers WHERE ShipperID = @ShipperID
        SET @NumberOfDeletedShippers = @@ROWCOUNT
    END TRY
    BEGIN CATCH
        PRINT 'Error Number = ' + STR(ERROR_NUMBER())
        PRINT 'Error Procedure = ' + ERROR_PROCEDURE()
        PRINT 'Error Message = ' + ERROR_MESSAGE()
    END CATCH
END
```

## 4. Gebruikersgedefinieerde Functies

Functies in SQL Server geven een enkele waarde of een tabel terug. Bijvoorbeeld, een functie die het netto maandsalaris van een werknemer berekent:

**Functie voor Netto Salaris Berekening:**

```sql
CREATE OR ALTER FUNCTION CalculateNettoPerMonth (@salary MONEY)
RETURNS MONEY
AS
BEGIN
    RETURN
        CASE 
            WHEN @salary <= 40000 THEN @salary * 0.7 / 12
            WHEN @salary <= 55000 THEN @salary * 0.65 / 12
            ELSE @salary * 0.6 / 12
        END
END
```

### Functie gebruiken in een `SELECT`-query

```sql
SELECT firstname + ' ' + lastname, dbo.CalculateNettoPerMonth(salary)
FROM Employees
WHERE dbo.CalculateNettoPerMonth(salary) > 2800
```

## 5. Inline Table-Valued Functies

Inline table-valued functies retourneren een tabel en zijn handig voor parametrische views.

**Voorbeeld van een Table-Valued Functie:**

```sql
CREATE FUNCTION CheapestProductsAboveLimit (@limit MONEY) RETURNS TABLE
AS
RETURN 
    SELECT CategoryID AS cat, MIN(UnitPrice) AS minprice
    FROM Products 
    WHERE UnitPrice > @limit
    GROUP BY CategoryID
```

### Gebruik de Table-Valued Functie

```sql
SELECT p.CategoryID, p.ProductID, p.UnitPrice, m.minprice
FROM Products p 
JOIN dbo.CheapestProductsAboveLimit(5) m ON p.CategoryID = m.cat
WHERE p.UnitPrice = m.minprice
```

## 6. Voorbeelden van Oefeningen

**Oefening 1:** Een stored procedure `ContactCustomers` om klanten op te halen die een product hebben besteld van een opgegeven leverancier.

```sql
CREATE OR ALTER PROCEDURE ContactCustomers (@companyName NVARCHAR(40), @numberOfInvolvedCustomers INT OUT) 
AS
BEGIN
    IF @companyName IS NULL
    BEGIN
        PRINT 'Please provide a CompanyName'
        RETURN
    END
    
    IF NOT EXISTS (SELECT * FROM Suppliers WHERE CompanyName = @companyName)
    BEGIN
        PRINT 'The supplier doesn''t exist.'
        RETURN
    END

    SELECT * FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    JOIN Suppliers s ON p.SupplierID = s.SupplierID
    WHERE DATEDIFF(MONTH, o.OrderDate, '2018-10-21') <= 6 
      AND s.CompanyName = @companyName

    SET @numberOfInvolvedCustomers = @@ROWCOUNT
END
```

**Oefening 2:** Een SP `InsertProduct` die nieuwe `OrderDetails` invoegt, maar valideert op het bestaan van `OrderID` en `ProductID`, en zorgt dat het prijsverschil niet meer dan 15% afwijkt van de standaardprijs.

```sql
CREATE OR ALTER PROCEDURE InsertProduct (@orderID INT, @productID INT, @unitPrice MONEY = NULL, @quantity SMALLINT, @discount REAL = NULL)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Orders WHERE OrderID = @orderID)
    BEGIN
        PRINT 'Invalid OrderID'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Products WHERE ProductID = @productID)
    BEGIN
        PRINT 'Invalid ProductID'
        RETURN
    END
    
    DECLARE @standardPrice MONEY = (SELECT UnitPrice FROM Products WHERE ProductID = @productID)
    
    IF @unitPrice IS NULL SET @unitPrice = @standardPrice
    IF @unitPrice < @standardPrice * 0.85 OR @unitPrice > @standardPrice * 1.15
    BEGIN
        PRINT 'Unit price deviation exceeds 15%'
        RETURN
    END
    
    INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount)
    VALUES (@orderID, @productID, @unitPrice, @quantity, COALESCE(@discount, 0))
    
    PRINT 'Product inserted successfully'
END
```

---

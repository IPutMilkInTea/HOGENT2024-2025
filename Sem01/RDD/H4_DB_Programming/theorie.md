# H4 DB_PROGRAMMING

## **1. Stored Procedures (SP):**  

**Purpose:**
Stored Procedures (SP) are precompiled SQL statements stored as database objects. They encapsulate logic for reuse, modularization, and security.  

---

**Example 1: Basic Stored Procedure**  

```sql
CREATE PROCEDURE OrdersSelectAll
AS
SELECT * FROM Orders;
```

**Explanation:**  

- A simple stored procedure that selects all records from the `Orders` table.  
- Can be executed using:  

```sql
EXEC OrdersSelectAll;
```

---

**Example 2: Stored Procedure with Input/Output Parameters**  

```sql
CREATE PROCEDURE OrdersSelectAllForCustomer 
  @customerID INT, 
  @numberOfOrders INT OUTPUT
AS
SELECT @numberOfOrders = COUNT(*)
FROM Orders
WHERE customerID = @customerID;
```

**Explanation:**

- This procedure accepts a customer ID and returns the number of orders.
- Call it with:

```sql
DECLARE @orderCount INT;
EXEC OrdersSelectAllForCustomer 5, @orderCount OUTPUT;
PRINT @orderCount;
```

---

## **2. Error Handling in Stored Procedures:**  

**Purpose:**
Handle errors gracefully using `TRY...CATCH` blocks or error codes.  

**Example: Handling Errors with @@ERROR**  

```sql
CREATE PROCEDURE ProductInsert 
  @productName NVARCHAR(50) = NULL, 
  @categoryID INT = NULL
AS
DECLARE @errormsg INT;
INSERT INTO Products(ProductName, CategoryID, Discontinued) 
VALUES (@productName, @categoryID, 0);

SET @errormsg = @@ERROR;

IF @errormsg = 0
    PRINT 'SUCCESS!';
ELSE
    PRINT 'ERROR! Unable to add product.';
RETURN @errormsg;
```

---

**Example: Using RAISERROR to Create Custom Error Messages**  

```sql
IF @errormsg != 0
    RAISERROR ('CategoryID is invalid.', 18, 1);
```

---

## **3. Exception Handling (TRY...CATCH):**  

```sql
ALTER PROCEDURE DeleteShipper 
  @ShipperID INT, 
  @NumberOfDeletedShippers INT OUT
AS
BEGIN
BEGIN TRY
    DELETE FROM Shippers WHERE ShipperID = @ShipperID;
    SET @NumberOfDeletedShippers = @@ROWCOUNT;
END TRY
BEGIN CATCH
    PRINT 'Error: ' + ERROR_MESSAGE();
END CATCH;
END;
```

**Explanation:**  

- The transaction rolls back if an error occurs, ensuring database integrity.  

---

## **4. User Defined Functions (UDF):**  

**Purpose:**
Custom functions can encapsulate business logic and return values or tables.  

**Example: Calculate Net Salary**  

```sql
CREATE FUNCTION CalculateNettoPerMonth (@salary MONEY)
RETURNS MONEY
AS
BEGIN
RETURN
    CASE 
        WHEN @salary <= 40000 THEN @salary * 0.7 / 12
        WHEN @salary <= 55000 THEN @salary * 0.65 / 12
        ELSE @salary * 0.6 / 12
    END;
END;
```

**Use:**  

```sql
SELECT LastName, dbo.CalculateNettoPerMonth(Salary) AS NetSalary 
FROM Employees;
```

---

## **5. Cursors:**  

**Purpose:**
Process row-by-row results from a query, allowing iterative operations.  

**Example: Basic Cursor**  

```sql
DECLARE suppliers_cursor CURSOR
FOR SELECT SupplierID, CompanyName FROM Suppliers WHERE Country = 'USA';

OPEN suppliers_cursor;
FETCH NEXT FROM suppliers_cursor INTO @supplierID, @companyName;

WHILE @@FETCH_STATUS = 0 
BEGIN
    PRINT @companyName;
    FETCH NEXT FROM suppliers_cursor INTO @supplierID, @companyName;
END;

CLOSE suppliers_cursor;
DEALLOCATE suppliers_cursor;
```

**Explanation:**

- Iterates over suppliers from the USA and prints each name.  

---

**Example: Nested Cursor (Supplier and Products)**  

```sql
DECLARE suppliers_cursor CURSOR FOR
SELECT SupplierID, CompanyName FROM Suppliers WHERE Country = 'USA';

OPEN suppliers_cursor;
FETCH NEXT FROM suppliers_cursor INTO @supplierID, @companyName;

WHILE @@FETCH_STATUS = 0 
BEGIN
    PRINT 'Supplier: ' + @companyName;

    DECLARE products_cursor CURSOR FOR
    SELECT ProductID, ProductName FROM Products WHERE SupplierID = @supplierID;

    OPEN products_cursor;
    FETCH NEXT FROM products_cursor INTO @productID, @productName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT '- ' + @productName;
        FETCH NEXT FROM products_cursor INTO @productID, @productName;
    END;

    CLOSE products_cursor;
    DEALLOCATE products_cursor;

    FETCH NEXT FROM suppliers_cursor INTO @supplierID, @companyName;
END;

CLOSE suppliers_cursor;
DEALLOCATE suppliers_cursor;
```

---

## **6. Triggers:**

**Purpose:**

Triggers execute automatically when specific changes occur in a table (INSERT, UPDATE, DELETE).  

---

**Example: Insert Trigger (Price Validation)** 

```sql
CREATE OR ALTER TRIGGER insertOrderDetails 
ON OrderDetails 
FOR INSERT
AS
BEGIN
    DECLARE @insertedProductID INT = (SELECT ProductID FROM inserted);
    DECLARE @insertedUnitPrice MONEY = (SELECT UnitPrice FROM inserted);
    DECLARE @unitPriceFromProducts MONEY = 
        (SELECT UnitPrice FROM Products WHERE ProductID = @insertedProductID);
    
    IF @insertedUnitPrice NOT BETWEEN @unitPriceFromProducts * 0.85 
        AND @unitPriceFromProducts * 1.15
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR ('Invalid Unit Price', 16, 1);
    END;
END;
```

---

**Example: Delete Trigger (Update Stock Levels)**  

```sql
CREATE OR ALTER TRIGGER deleteOrderDetails 
ON OrderDetails 
FOR DELETE
AS
BEGIN
    DECLARE @deletedProductID INT, @deletedQuantity INT;
    DECLARE deleted_cursor CURSOR FOR 
    SELECT ProductID, Quantity FROM deleted;
    
    OPEN deleted_cursor;
    FETCH NEXT FROM deleted_cursor INTO @deletedProductID, @deletedQuantity;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE Products
        SET UnitsInStock = UnitsInStock + @deletedQuantity
        WHERE ProductID = @deletedProductID;
        FETCH NEXT FROM deleted_cursor INTO @deletedProductID, @deletedQuantity;
    END;

    CLOSE deleted_cursor;
    DEALLOCATE deleted_cursor;
END;
```

---

## **7. Temporary Tables and Table Variables:**  

- **Local Temporary Table** – Visible in session.  
- **Global Temporary Table** – Visible to all sessions.  
- **Table Variable** – Limited to the batch in which it is declared.  

**Example: Local Temporary Table**  

```sql
CREATE TABLE #OrderTotalsByYear (
    OrderYear INT PRIMARY KEY, 
    TotalQuantity INT
);
```

---

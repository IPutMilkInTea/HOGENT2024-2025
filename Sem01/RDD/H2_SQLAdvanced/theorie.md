# H2 SQL ADVANCED

## **1. Subqueries:**

**Purpose:** Use a query inside another query to filter, calculate, or return values dynamically.  
**Types of Subqueries:**

- **Single Value Subquery:** Returns one value.  
- **Multiple Value Subquery:** Returns a list of values.  
- **Correlated Subquery:** References outer query values and runs for each row.  

---

**Example 1: Subquery Returning a Single Value**  
**Goal:** Find products that cost more than the average price.  

```sql
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products);
```

**Explanation:**  

- The subquery calculates the average product price.  
- The outer query filters products costing more than that average.  

---

**Example 2: Subquery with MAX Value**  
**Goal:** Find the most expensive product.

```sql
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice = (SELECT MAX(UnitPrice) FROM Products);
```

**Explanation:**

- The subquery fetches the highest price.  
- The outer query displays products matching this price.  

---

## **2. Subquery Returning a List (IN/NOT IN):**  

**Goal:** List employees who processed orders.  

```sql
SELECT FirstName, LastName
FROM Employees
WHERE EmployeeID IN (SELECT EmployeeID FROM Orders);
```

**Explanation:**  

- The subquery retrieves all employees with orders.  
- The outer query lists matching employee records.  

**Goal:** Find customers who have not placed any orders.  

```sql
SELECT * FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders);
```

**Explanation:**  

- `NOT IN` excludes customers present in the orders list.  

---

## **3. Correlated Subquery (Row-by-Row Execution):**

**Goal:** Find employees earning more than the average salary of their department.  

```sql
SELECT FirstName, LastName, Salary
FROM Employees e
WHERE Salary > (SELECT AVG(Salary) FROM Employees WHERE ReportsTo = e.ReportsTo);
```

**Explanation:**  

- The subquery dynamically recalculates average salaries per department.  
- The outer query filters based on this value.  

---

## **4. EXISTS Operator (Check Existence):**  

**Goal:** List customers with orders.  

```sql
SELECT * FROM Customers c
WHERE EXISTS (SELECT * FROM Orders o WHERE o.CustomerID = c.CustomerID);
```

**Explanation:**  

- The subquery checks if an order exists for each customer.  
- `EXISTS` returns rows where the subquery finds matching records.  

**Goal:** List customers without orders.  

```sql
SELECT * FROM Customers c
WHERE NOT EXISTS (SELECT * FROM Orders o WHERE o.CustomerID = c.CustomerID);
```

---

## **5. Data Manipulation (DML):**  

**Goal:** Modify data using INSERT, UPDATE, DELETE, and MERGE commands.  

---

**Example 1: INSERT Statement (Add Records):**  
**Add a New Product:**  

```sql
INSERT INTO Products (ProductName, CategoryID, Discontinued)
VALUES ('Chocolate Bar', 2, 0);
```

**Explanation:**  

- Inserts a new row into the `Products` table.  
- Specify values for mandatory columns.  

**Copy Data from Another Table:**  

```sql
INSERT INTO Customers (CustomerID, CompanyName)
SELECT EmployeeID, FirstName + ' ' + LastName FROM Employees;
```

---

**Example 2: UPDATE Statement (Modify Records):**  
**Goal:** Increase product prices by 10%.  

```sql
UPDATE Products
SET UnitPrice = UnitPrice * 1.1;
```

**Goal:** Update prices only for products with 'Bröd' in their name.  

```sql
UPDATE Products
SET UnitPrice = UnitPrice * 1.1
WHERE ProductName LIKE '%Bröd%';
```

---

**Example 3: DELETE Statement (Remove Records):**  
**Goal:** Delete products named 'Bröd'.  

```sql
DELETE FROM Products
WHERE ProductName LIKE '%Bröd%';
```

**Goal:** Delete orders from the most recent date.  

```sql
DELETE FROM OrderDetails
WHERE OrderID IN (SELECT OrderID FROM Orders WHERE OrderDate = (SELECT MAX(OrderDate) FROM Orders));
```

---

## **6. MERGE (Combine INSERT, UPDATE, DELETE):**  

**Goal:** Synchronize `Shippers` table with an updated version.  

```sql
MERGE Shippers AS target
USING ShippersUpdate AS source
ON target.ShipperID = source.ShipperID

WHEN MATCHED AND target.CompanyName <> source.CompanyName
THEN UPDATE SET target.CompanyName = source.CompanyName

WHEN NOT MATCHED BY target
THEN INSERT (CompanyName, Phone) VALUES (source.CompanyName, source.Phone)

WHEN NOT MATCHED BY source
THEN DELETE;
```

**Explanation:**  

- **Updates** records if they exist.  
- **Inserts** new records if missing.  
- **Deletes** rows not present in the source table.  

---

## **7. Views (Virtual Tables):**  

**Goal:** Simplify complex queries and reuse SQL logic.  

```sql
CREATE VIEW V_ProductOrders AS
SELECT p.ProductName, o.OrderDate
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID;
```

**Query the View:**  

```sql
SELECT * FROM V_ProductOrders;
```

---

## **8. Common Table Expressions (CTE):**  

**Goal:** Organize complex queries using temporary results.  

**Example:**  
**Goal:** Find products with minimum price per category.  

```sql
WITH CategoryMinPrice AS
(SELECT CategoryID, MIN(UnitPrice) AS MinPrice
FROM Products
GROUP BY CategoryID)

SELECT p.ProductID, p.ProductName
FROM Products p
JOIN CategoryMinPrice c ON p.CategoryID = c.CategoryID AND p.UnitPrice = c.MinPrice;
```

---

## **9. Recursive CTE (Hierarchical Data):**  

**Goal:** Generate numbers from 1 to 5.

```sql
WITH Numbers AS
(SELECT 1 AS number
UNION ALL
SELECT number + 1 FROM Numbers WHERE number < 5)
SELECT * FROM Numbers;
```

---

## **10. Exercises (Try It Yourself):**

1. Find employees who processed the most orders.  
2. List customers from the same country as "Maison Dewey".  
3. Display orders where the shipping address differs from the customer address.  
4. Calculate the difference between product price and average price per category.  

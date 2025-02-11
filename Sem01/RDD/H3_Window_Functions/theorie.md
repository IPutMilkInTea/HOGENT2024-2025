# H3 WINDOW FUNCTIONS

## **1. What Are Window Functions?**  

**Purpose:**  

- Window functions allow you to perform calculations across a set of rows related to the current row.  
- Common use cases include running totals, moving averages, and ranking.  
- Introduced in SQL:2003, they provide a simple and efficient way to perform aggregate-like operations without collapsing rows.  

---

## **2. Key Concept – OVER Clause:**

**Syntax:**

```sql
SELECT column, window_function() OVER (PARTITION BY column ORDER BY column) 
FROM table;
```

- **`PARTITION BY`** – Divides the result set into partitions to apply calculations separately within each partition.  
- **`ORDER BY`** – Determines the order of rows within each partition.  

---

## **3. Example – Running Total (Inefficient Approach):**  

**Goal:** Calculate the running total of `UnitsInStock` by `CategoryID`.  
**Inefficient (Correlated Subquery):**

```sql
SELECT CategoryID, ProductID, UnitsInStock,
(SELECT SUM(UnitsInStock) 
 FROM Products 
 WHERE CategoryID = p.CategoryID  
   AND ProductID <= p.ProductID) AS TotalUnitsInStockPerCategory
FROM Products p
ORDER BY CategoryID, ProductID;
```

**Explanation:**  

- For each row, the subquery recalculates the sum. This leads to poor performance: **O(n²)** complexity.  

---

## **4. Efficient Approach – OVER Clause:**  

```sql
SELECT CategoryID, ProductID, UnitsInStock,
SUM(UnitsInStock) OVER (PARTITION BY CategoryID ORDER BY ProductID) AS TotalUnitsInStockPerCategory
FROM Products;
```

**Explanation:**  

- The sum is computed in one pass, significantly improving performance.  

---

## **5. ROWS vs RANGE in Window Functions:**  

- **`RANGE`** – Logical comparison of values based on the `ORDER BY` column.  
- **`ROWS`** – Physical row-based offsets.  

**Example:**

```sql
SELECT CategoryID, ProductID, UnitsInStock,
SUM(UnitsInStock) OVER (PARTITION BY CategoryID ORDER BY ProductID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) 
AS RollingSum
FROM Products;
```

**Explanation:**  

- This calculates a rolling sum for the current row and the two preceding rows.  

---

## **6. ROW_NUMBER, RANK, DENSE_RANK:**

**Goal:** Assign sequential numbers or ranks to rows.  

```sql
SELECT EmployeeID, FirstName + ' ' + LastName AS FullName, Salary,
ROW_NUMBER() OVER (ORDER BY Salary DESC) AS 'ROW_NUMBER',
RANK() OVER (ORDER BY Salary DESC) AS 'RANK',
DENSE_RANK() OVER (ORDER BY Salary DESC) AS 'DENSE_RANK'
FROM Employees;
```

**Explanation:**  

- **`ROW_NUMBER()`** – Assigns unique sequential numbers (no ties).  
- **`RANK()`** – Assigns the same rank to ties, skipping numbers.  
- **`DENSE_RANK()`** – Assigns the same rank to ties without skipping numbers.  

---

## **7. Partitioned Ranking (Per Group):**  

```sql
SELECT EmployeeID, FirstName + ' ' + LastName AS FullName, Title, Salary,
ROW_NUMBER() OVER (PARTITION BY Title ORDER BY Salary DESC) AS 'ROW_NUMBER'
FROM Employees;
```

**Explanation:**  

- Ranks are calculated separately for each employee `Title` group.  

---

## **8. LAG and LEAD (Row Comparison):**  

- **`LAG()`** – Retrieves data from the previous row.  
- **`LEAD()`** – Retrieves data from the next row.  

**Example (LAG – Previous Row Comparison):**  

```sql
WITH cte AS (
  SELECT EmployeeID, FirstName + ' ' + LastName AS FullName, Salary,
  LAG(Salary) OVER (ORDER BY Salary DESC) AS PrecedingSalary
  FROM Employees
)
SELECT *, Salary - PrecedingSalary AS Difference
FROM cte;
```

**Explanation:**  

- This calculates the salary difference between the current employee and the one above them in descending order.  

---

**Example (LEAD – Next Row Comparison):**  

```sql
WITH cte AS (
  SELECT EmployeeID, FirstName + ' ' + LastName AS FullName, Salary,
  LEAD(Salary) OVER (ORDER BY Salary DESC) AS FollowingSalary
  FROM Employees
)
SELECT *, Salary - FollowingSalary AS Difference
FROM cte;
```

---

## **9. Exercises (Try It Yourself):**  

**1. Sequential Numbering by Country (ROW_NUMBER):**

```sql
SELECT Country, CompanyName,
ROW_NUMBER() OVER (PARTITION BY Country ORDER BY CompanyName) AS rownum
FROM Customers;
```

---

**2. Sales by Year and Previous Year (LAG):**  

```sql
WITH sales AS (
  SELECT ProductID, YEAR(OrderDate) AS Year, SUM(Quantity) AS TotalSold
  FROM OrderDetails
  GROUP BY ProductID, YEAR(OrderDate)
),
sales_lag AS (
  SELECT ProductID, Year, TotalSold,
  LAG(TotalSold) OVER (PARTITION BY ProductID ORDER BY Year) AS PreviousYear
  FROM sales
)
SELECT *, (TotalSold - PreviousYear) AS YearOverYearGrowth
FROM sales_lag;
```

---

**3. Ranking Top Shippers (DENSE_RANK):**  

```sql
WITH cte AS (
  SELECT ShipVia, COUNT(OrderID) AS NumberOfOrders,
  DENSE_RANK() OVER (ORDER BY COUNT(OrderID) DESC) AS Rank
  FROM Orders
  GROUP BY ShipVia
)
SELECT s.CompanyName, cte.*
FROM Shippers s
JOIN cte ON s.ShipperID = cte.ShipVia
WHERE Rank = 1;
```

---

**4. Top 3 Countries by Customer Count:**  

```sql
WITH cte AS (
  SELECT Country, COUNT(CustomerID) AS CustomerCount,
  DENSE_RANK() OVER (ORDER BY COUNT(CustomerID) DESC) AS Rank
  FROM Customers
  GROUP BY Country
)
SELECT * FROM cte WHERE Rank <= 3;
```

---

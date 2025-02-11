# H1 SQL_REVIEW

## **1. Basic SELECT Statement:**

**Purpose:** Retrieve data from a table.  
**Syntax:**

```sql
SELECT column1, column2 FROM table_name;
```

**Example:**

```sql
SELECT productname, unitprice FROM Products;
```

**Explanation:**  
This query selects and displays the `productname` and `unitprice` columns from the `Products` table. If you want all columns, use:

```sql
SELECT * FROM Products;
```

This returns the entire table.

---

## **2. Filtering Data (WHERE Clause):**  

**Purpose:** Extract only rows that meet certain conditions.  
**Syntax:**

```sql
SELECT column1, column2 FROM table_name WHERE condition;
```

**Example:**

```sql
SELECT productname, unitprice FROM Products WHERE unitprice > 50;
```

**Explanation:**  
Only products with a unit price greater than 50 will be shown. You can filter by multiple conditions using `AND` or `OR`:

```sql
SELECT productname FROM Products WHERE unitprice > 50 AND categoryID = 2;
```

---

## **3. Sorting Data (ORDER BY):**  

**Purpose:** Sort query results in ascending (default) or descending order.  
**Syntax:**

```sql
SELECT column1 FROM table_name ORDER BY column1 [ASC|DESC];
```

**Example:**

```sql
SELECT productname, unitprice FROM Products ORDER BY unitprice DESC;
```

**Explanation:**  
The products are sorted by price from highest to lowest.

---

## **4. Eliminate Duplicates (DISTINCT):**  

**Purpose:** Show unique values only.  
**Syntax:**

```sql
SELECT DISTINCT column1 FROM table_name;
```

**Example:**

```sql
SELECT DISTINCT supplierID FROM Products;
```

**Explanation:**  
This displays each supplier only once, even if they supply multiple products.

---

## **5. Calculated Columns:**  

**Purpose:** Perform calculations within the query.  
**Syntax:**

```sql
SELECT column1, column2 * column3 AS new_column FROM table_name;
```

**Example:**

```sql
SELECT productname, unitprice * unitsinstock AS totalvalue FROM Products;
```

**Explanation:**  
Calculates total inventory value for each product by multiplying the price by the number of units in stock.

---

## **6. Aliases (AS Keyword):**  

**Purpose:** Rename columns or tables in output.  
**Syntax:**

```sql
SELECT column1 AS new_name FROM table_name;
```

**Example:**

```sql
SELECT productname AS Product, unitprice AS Price FROM Products;
```

**Explanation:**  
The output columns will appear as "Product" and "Price" instead of their original names.

---

## **7. Aggregation and Grouping (GROUP BY):**  

**Purpose:** Group rows and apply aggregate functions.  
**Functions:**  

- **SUM()** – Total of column values.  
- **AVG()** – Average value.  
- **COUNT()** – Number of rows.  
- **MIN() / MAX()** – Minimum or maximum value.  

**Syntax:**

```sql
SELECT column1, COUNT(column2) FROM table_name GROUP BY column1;
```

**Example:**

```sql
SELECT categoryID, COUNT(productID) AS numberofproducts FROM Products GROUP BY categoryID;
```

**Explanation:**  
Counts how many products exist in each category. The result groups rows by `categoryID`.

---

## **8. Filtering Groups (HAVING):**  

**Purpose:** Filter grouped results (like WHERE but for groups).  
**Syntax:**

```sql
SELECT column1, COUNT(column2) FROM table_name GROUP BY column1 HAVING COUNT(column2) > 5;
```

**Example:**

```sql
SELECT categoryID, COUNT(productID) AS numberofproducts FROM Products GROUP BY categoryID HAVING COUNT(productID) > 10;
```

**Explanation:**  
Only categories with more than 10 products are displayed.

---

## **9. Joining Tables (JOIN):**  

**Purpose:** Combine rows from multiple tables based on a related column.  
**Types of Joins:**  

- **INNER JOIN** – Matches rows in both tables.
- **LEFT JOIN** – All rows from the left table, and matching rows from the right.  
- **RIGHT JOIN** – All rows from the right table, and matching rows from the left.  

**Example (INNER JOIN):**

```sql
SELECT Products.productname, Categories.categoryname 
FROM Products
INNER JOIN Categories
ON Products.categoryID = Categories.categoryID;
```

**Explanation:**  
This lists products along with their category names by matching `categoryID` in both tables.

**LEFT JOIN Example:**

```sql
SELECT Employees.firstname, Orders.orderID
FROM Employees
LEFT JOIN Orders
ON Employees.employeeID = Orders.employeeID;
```

**Explanation:**  
Shows all employees, even those who haven’t placed orders.

---

## **10. Subqueries:**  

**Purpose:** Use one query inside another.  
**Example:**

```sql
SELECT productname FROM Products WHERE unitprice > (SELECT AVG(unitprice) FROM Products);
```

**Explanation:**  
Selects products priced above the average price.

---

## **11. UNION (Combining Results):**  

**Purpose:** Combine results of two queries.  
**Syntax:**

```sql
SELECT column1 FROM table1
UNION
SELECT column1 FROM table2;
```

**Example:**

```sql
SELECT firstname FROM Employees
UNION
SELECT contactname FROM Customers;
```

**Explanation:**  
Combines employee and customer names into a single list.

---

## **12. INTERSECT (Common Records):**  

**Purpose:** Return rows common to both queries.  
**Example:**

```sql
SELECT City FROM Customers
INTERSECT
SELECT City FROM Suppliers;
```

**Explanation:**  
Lists cities where both customers and suppliers are located.

---

## **13. EXCEPT (Differences Between Results):**  

**Purpose:** Return rows from the first query that are not in the second.  
**Example:**

```sql
SELECT CustomerID FROM Customers
EXCEPT
SELECT CustomerID FROM Orders;
```

**Explanation:**  
Shows customers who haven’t placed orders.

---

## **14. Handling NULL Values:**  

**Purpose:** Deal with unknown or missing data.  
**Example:**

```sql
SELECT companyname, region FROM Suppliers WHERE region IS NULL;
```

**Explanation:**  
Lists suppliers with unknown regions.

To replace NULL with a default value:

```sql
SELECT companyname, ISNULL(region, 'Unknown') FROM Suppliers;
```

---

## **15. Exercises:**  

Try these to practice:

1. **Find all products with 'chocolate' in their name.**  

```sql
SELECT productname FROM Products WHERE productname LIKE '%chocolate%';
```

1. **Show the top 5 most expensive products.**  

```sql
SELECT productname, unitprice FROM Products ORDER BY unitprice DESC LIMIT 5;
```

1. **List suppliers who provide more than 3 products.**  

```sql
SELECT supplierID, COUNT(productID) AS totalproducts FROM Products GROUP BY supplierID HAVING COUNT(productID) > 3;
```

Would you like more complex queries or further examples on joins and subqueries?
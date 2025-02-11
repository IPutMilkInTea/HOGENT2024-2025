# H5 Indexen

## **1. What Are Indexes in SQL?**

**Purpose:**  
Indexes improve the speed of data retrieval by creating an ordered structure on one or more columns in a table, much like a book index.  

**Why Use Indexes?**  

- **Faster Data Retrieval:** Queries run faster because the database can directly access rows instead of scanning the entire table.  
- **Enforce Uniqueness:** Unique indexes ensure no duplicate values in indexed columns.  
- **Optimized Joins and Sorting:** Indexes improve join and sort operations.  

**Downsides:**  

- **Storage Overhead:** Indexes consume disk space.  
- **Slower DML Operations:** Inserts, updates, and deletes may slow down as indexes need updating.  

---

## **2. Types of Indexes:**  

---

### **1. Clustered Index:**  

- **Data is physically ordered** based on the index.
- **Only one** clustered index per table.  
- **Faster for retrieving ranges** of data.  

**Example:**  

```sql
CREATE CLUSTERED INDEX idx_Employee_LastName 
ON Employees (LastName);
```

**Explanation:**  

- The `Employees` table is physically ordered by `LastName`.  
- Retrieving records for `WHERE LastName BETWEEN 'A' AND 'D'` is faster.  

---

### **2. Non-Clustered Index:**

- A **separate structure** from the table that contains pointers to the table data.  
- **Multiple** non-clustered indexes can exist on one table.  
- Slower than clustered indexes but allows indexing on different columns.  

**Example:**  

```sql
CREATE NONCLUSTERED INDEX idx_Employee_FirstName 
ON Employees (FirstName);
```

**Explanation:**

- The `FirstName` column is indexed without physically rearranging the table.  
- A pointer refers to the data row.  

---

### **3. Unique Index:**  

- Ensures all values in a column (or combination) are unique.  
- Automatically created on primary key columns.  

**Example:**

```sql
CREATE UNIQUE INDEX idx_Employee_Email 
ON Employees (Email);
```

**Explanation:**  

- Prevents duplicate email entries.  

---

### **4. Filtered Index:**  

- Index only rows that meet certain criteria.  
- **Efficient for tables with sparse data.**  

**Example:**

```sql
CREATE NONCLUSTERED INDEX idx_Active_Employees 
ON Employees (LastName) 
WHERE Status = 'Active';
```

**Explanation:**  

- Only `Active` employees are indexed, reducing index size and improving performance for filtered queries.  

---

### **5. Covering Index (INCLUDE):**  

- A non-clustered index that **includes extra columns** to avoid returning to the base table.  
- Speeds up **SELECT queries** involving columns not part of the index key.  

**Example:**  

```sql
CREATE NONCLUSTERED INDEX idx_Employee_LastName_Incl_Title 
ON Employees (LastName) 
INCLUDE (Title);
```

**Explanation:**  

- Queries selecting `LastName` and `Title` don’t need to fetch from the table.  

---

### **3. Table Scans and Index Seeks:**  

---

### **Table Scan (Heap Scan):**  

- Occurs when no indexes exist.  
- SQL Server reads **all rows** to find matches, leading to slow performance.  

**Example (Inefficient):**

```sql
SELECT * FROM Employees WHERE LastName = 'Smith';
```

**Explanation:**  

- Without an index, SQL Server scans the entire table.  

---

### **Index Seek (Efficient):**  

- Occurs when an index exists on the searched column.  
- SQL Server **navigates directly** to the matching records using the index.  

**Example (Efficient):**

```sql
SELECT * FROM Employees WHERE LastName = 'Smith';
```

**Explanation:**  

- With an index on `LastName`, SQL Server efficiently seeks the desired row.  

---

## **4. Practical Examples of Indexes:**  

---

### **1. Create a Clustered Index on Orders:**  

```sql
CREATE CLUSTERED INDEX idx_Orders_Date 
ON Orders (OrderDate);
```

- Orders are physically arranged by `OrderDate`.  

---

### **2. Create a Non-Clustered Index on Product Names:**  

```sql
CREATE NONCLUSTERED INDEX idx_Product_Name 
ON Products (ProductName);
```

- Speeds up `ProductName` search while maintaining heap structure.  

---

### **3. Create a Filtered Index for Active Customers:**  

```sql
CREATE NONCLUSTERED INDEX idx_Active_Customers 
ON Customers (City) 
WHERE IsActive = 1;
```

- Only `Active` customers are indexed.  

---

## **5. Index Best Practices (Tips & Tricks):**  

---

**1. Avoid Using Functions on Indexed Columns:**  
**Bad:**  

```sql
SELECT * FROM Employees WHERE YEAR(BirthDate) = 1980;
```  

**Good:**

```sql
SELECT * FROM Employees 
WHERE BirthDate >= '1980-01-01' AND BirthDate < '1981-01-01';
```  

**Explanation:**  

- Functions prevent index use. Use **range conditions** instead.  

---

**2. Use Wildcards Correctly:**  
**Bad:**

```sql
SELECT * FROM Employees WHERE LastName LIKE '%son';
```

**Good:**

```sql
SELECT * FROM Employees WHERE LastName LIKE 'A%';
```  

**Explanation:**  

- Leading wildcards (`%`) prevent index use. Avoid them if possible.  

---

**3. Avoid Calculations in WHERE Clause:**  
**Bad:**

```sql
SELECT * FROM Employees WHERE Salary * 1.10 > 100000;
```  

**Good:**

```sql
SELECT * FROM Employees WHERE Salary > 100000 / 1.10;
```  

---

**4. Prefer OUTER JOIN over UNION:**  
**Bad:**  

```sql
SELECT LastName FROM Employees 
UNION 
SELECT LastName FROM RetiredEmployees;
```  

**Good:**  

```sql
SELECT LastName FROM Employees 
LEFT JOIN RetiredEmployees 
ON Employees.EmployeeID = RetiredEmployees.EmployeeID;
```  

---

**5. Avoid ANY and ALL (Rewrite as MAX/MIN):**  
**Bad:**  

```sql
SELECT LastName FROM Employees 
WHERE BirthDate >= ALL(SELECT BirthDate FROM Employees);
```

**Good:**  

```sql
SELECT LastName FROM Employees 
WHERE BirthDate = (SELECT MAX(BirthDate) FROM Employees);
```  

---

## **6. Quiz – Index Fit for Query:**  

**1.**  

```sql
CREATE INDEX tbl_idx ON tbl (date_column);
SELECT * FROM tbl WHERE YEAR(date_column) = 2017;
```  

- **Bad Fit** – Year function prevents index use.  

**2.**  

```sql
CREATE INDEX tbl_idx ON tbl (a, date_column);
SELECT TOP 1 * FROM tbl WHERE a = 12 ORDER BY date_column DESC;
```

- **Good Fit** – Composite index efficiently handles this query.

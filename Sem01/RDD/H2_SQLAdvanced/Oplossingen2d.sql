/* Common Table Expression */

/* Common Table Expression: The WITH component */

-- Give per category the minimum price and all products with that minimum price 

-- Solution 1
SELECT CategoryID, ProductID, UnitPrice
FROM Products p
WHERE UnitPrice = (SELECT MIN(UnitPrice) FROM Products WHERE CategoryID = p.CategoryID)


-- Not performant! Loops through all products and calculates the MIN(unitprice) for the category of that specific product: O(n²)
-- The MIN(unitprice) is calculated multiple times for each category!


-- Solution 2
WITH CategoryMinPrice(CategoryID, MinPrice)
AS (SELECT CategoryID, MIN(UnitPrice)
    FROM Products AS p
    GROUP BY CategoryID)

SELECT c.CategoryID, p.ProductID, MinPrice
FROM Products AS p
JOIN CategoryMinPrice AS c ON p.CategoryID = c.CategoryID AND p.UnitPrice = c.MinPrice;

-- Using the WITH-component you can give the subquery its own name (with column names) and reuse it in the rest of the query (possibly several times!)


-- Give per category all products that cost less than the average price of that category
With CategoryAvgPrice
AS (SELECT CategoryID, AVG(UnitPrice) As AvgPrice
FROM Products p
GROUP BY CategoryID)

SELECT *
FROM Products p JOIN CategoryAvgPrice cap ON p.CategoryID = cap.CategoryID
WHERE p.unitprice < cap.AvgPrice
ORDER BY p.CategoryID




-- Give all products from the same category As Tofu, that are not Tofu
WITH CategoryTofu
AS (SELECT CategoryID FROM products WHERE ProductName = 'Tofu')

SELECT *
FROM Products p JOIN CategoryTofu ct ON p.categoryID = ct.CategoryID
WHERE p.ProductName NOT LIKE '%Tofu%'




--The columns in the CTE should have a name, so
--you can refer to these columns.
--(1) If not given a name, it will use the 'default' name(e.g. customerid, COUNT(orderid))
--(2) Or you can specify the columnname in the 'header' of the CTE
WITH CategoryMinPrice(CategoryID, MinPrice)
AS (SELECT CategoryID, MIN(UnitPrice)
    FROM Products AS p     
    GROUP BY CategoryID)

SELECT c.CategoryID, p.ProductID, MinPrice
FROM Products AS p
JOIN CategoryMinPrice AS c ON p.CategoryID = c.CategoryID AND p.UnitPrice = c.MinPrice;


--(3) Or you can give each column a name in the CTE. 
WITH CategoryMinPrice
AS (SELECT CategoryID As CategoryID, MIN(UnitPrice) AS MinPrice
    FROM Products AS p
    GROUP BY CategoryID)

SELECT c.CategoryID, p.ProductID, MinPrice
FROM Products AS p
JOIN CategoryMinPrice AS c ON p.CategoryID = c.CategoryID AND p.UnitPrice = c.MinPrice;

-- the WITH-component has two application areas:
--		Simplify SQL-instructions, e.g. simplified alternative for simple subqueries or avoid repetition of SQL constructs 
--		Traverse recursively hierarchical and network structures


/* CTE's versus Views 

Similarities 
- WITH ~ CREATE VIEW
- Both are virtual tables: the content is derived from other tables

Differences 
- A CTE only exists during the SELECT-statement
- A CTE is not visible for other users and applications
*/


/* CTE's versus Subqueries 
Similarities 
- Both are virtual tables:  the content is derived from other tables

Differences 
- A CTE can be reused in the same query
- A subquery is defined in the clause where it is used (SELECT/FROM/WHERE/…)
- A CTE is defined on top of the query
- A simple subquery can always be replaced by a CTE
*/

-- CTE's with > 1 WITH-component

-- Give per year per customer the relative contribution of this customer to the total revenue

-- Step 1 -> Total revenue per year
SELECT YEAR(OrderDate), SUM(od.UnitPrice * od.Quantity)
FROM Orders o INNER JOIN OrderDetails od
ON o.OrderID = od.OrderID
GROUP BY YEAR(OrderDate)

-- Step 2 -> Total revenue per year per customer
SELECT YEAR(OrderDate), o.CustomerID, SUM(od.UnitPrice * od.Quantity)
FROM Orders o INNER JOIN OrderDetails od
ON o.OrderID = od.OrderID
GROUP BY YEAR(OrderDate), o.CustomerID

-- Step 3 -> Combine both
WITH TotalRevenuePerYear(RevenueYear, TotalRevenue)
AS
(SELECT YEAR(OrderDate), SUM(od.UnitPrice * od.Quantity)
FROM Orders o INNER JOIN OrderDetails od
ON o.OrderID = od.OrderID
GROUP BY YEAR(OrderDate)),

TotalRevenuePerYearPerCustomer(RevenueYear, CustomerID, Revenue) 
AS
(SELECT YEAR(OrderDate), o.CustomerID, SUM(od.UnitPrice * od.Quantity)
FROM Orders o INNER JOIN OrderDetails od
ON o.OrderID = od.OrderID
GROUP BY YEAR(OrderDate), o.CustomerID)

SELECT CustomerID, pc.RevenueYear, FORMAT(Revenue / TotalRevenue, 'P') As RelativePart
FROM TotalRevenuePerYearPerCustomer pc INNER JOIN TotalRevenuePerYear t 
ON pc.RevenueYear = t.RevenueYear
ORDER BY 2 ASC, 3 DESC


-- Give the employees that process more orders than average
-- cte1 --> the number of processed orders per employee
-- cte2 --> the average
-- employees with number of processed orders > average

WITH cte1 (EmployeeID, NumberOfOrders)
AS
(SELECT EmployeeID, COUNT(DISTINCT OrderID)
FROM Orders
GROUP BY EmployeeID),

cte2 (AverageNumberOfOrders)
AS
(SELECT AVG(NumberOfOrders)
FROM cte1)

SELECT *
FROM cte1 c1 JOIN cte2 c2
ON c1.NumberOfOrders >= c2.AverageNumberOfOrders





/* Recursive SELECT's */

/*
'Recursive' means: we continue to execute a table expression until a condition is reached.

This allows you to solve problems like:
- Who are the friends of my friends etc. (in a social network)?
- What is the hierarchy of an organisation ? 
- Find the parts and subparts of a product (bill of materials). 

*/

-- Give the integers from 1 to 5
WITH numbers(number) AS
	(SELECT 1 
	 UNION all 
 	 SELECT number + 1 
	 FROM numbers
 	 WHERE number < 5)

SELECT * FROM numbers;

/* Characteristics of recursive use of WITH:
- The with component consists of (at least) 2 expressions, combined with UNION ALL
- A temporary table is consulted in the second expression
- At least one of the expressions may not refer to the temporary table.
*/

-- Give the numbers from 1 to 999

WITH numbers(number) AS
	(SELECT 1 
	 UNION all 
 	 SELECT number + 1 
	 FROM numbers
 	 WHERE number < 999)

SELECT * FROM numbers;

--> The maximum recursion 100 has been exhausted before statement completion.

-- Give the numbers from 1 to 999

WITH numbers(number) AS
	(SELECT 1 
	 UNION all 
 	 SELECT number + 1 
	 FROM numbers
 	 WHERE number < 999)

SELECT * FROM numbers
option (maxrecursion 1000);

--> Maxrecursion is MS SQL Server specific. 

-- Give the total revenue per month in 2016.Not all months occur

SELECT YEAR(OrderDate)*100 + Month(OrderDate) AS RevenueMonth, SUM(od.UnitPrice * od.Quantity) AS Revenue
FROM Orders o INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE YEAR(OrderDate) = 2016
GROUP BY YEAR(OrderDate)*100 + Month(OrderDate)

-- Solution: Generate all months with CTE ...
WITH Months AS
(SELECT 201601 as RevenueMonth
UNION ALL
SELECT RevenueMonth + 1
FROM Months
WHERE RevenueMonth < 201612)
SELECT * FROM Months;

-- And combine with outer join
WITH Months(RevenueMonth) AS
(SELECT 201601 as RevenueMonth
UNION ALL
SELECT RevenueMonth + 1
FROM Months
WHERE RevenueMonth < 201612),

Revenues(RevenueMonth, Revenue)
AS
(SELECT YEAR(OrderDate)*100 + Month(OrderDate) AS RevenueMonth, SUM(od.UnitPrice * od.Quantity) AS Revenue
FROM Orders o INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE YEAR(OrderDate) = 2016
GROUP BY YEAR(OrderDate)*100 + Month(OrderDate))

SELECT m.RevenueMonth, ISNULL(r.Revenue, 0) As Revenue
FROM Months m LEFT JOIN Revenues r ON m.RevenueMonth = r.RevenueMonth



/* Recursively traversing a hierarchical structure */

-- Give all employees who report directly or indirectly to Andrew Fuller (employeeid=2)
-- Step 1 returns all employees that report directly to Andrew Fuller
-- Step 2 adds the 2nd 'layer': who reports to someone who reports to A. Fuller
-- ....

WITH Bosses (boss, emp)
AS
(SELECT ReportsTo, EmployeeID
FROM Employees
WHERE ReportsTo IS NULL
UNION ALL
SELECT e.ReportsTo, e.EmployeeID
FROM Employees e INNER JOIN Bosses b ON e.ReportsTo = b.emp)

SELECT * FROM Bosses
ORDER BY boss, emp;

-- Change the previous solution to the following solution
/*
boss	emp		title					level	path
NULL	2		Vice President, Sales	1		Vice President, Sales
2		5		Sales Manager			2		Vice President, Sales<--Sales Manager
2		10		Business Manager		2		Vice President, Sales<--Business Manager
2		13		Marketing Director		2		Vice President, Sales<--Marketing Director
5		1		Sales Representative	3		Vice President, Sales<--Sales Manager<--Sales Representative
5		3		Sales Representative	3		Vice President, Sales<--Sales Manager<--Sales Representative
5		4		Sales Representative	3		Vice President, Sales<--Sales Manager<--Sales Representative
5		6		Sales Representative	3		Vice President, Sales<--Sales Manager<--Sales Representative
5		7		Sales Representative	3		Vice President, Sales<--Sales Manager<--Sales Representative
5		8		Inside Sales Coordinator	3	Vice President, Sales<--Sales Manager<--Inside Sales Coordinator
5		9		Sales Representative	3		Vice President, Sales<--Sales Manager<--Sales Representative
...
*/

WITH Bosses (boss, emp, title, level, path)
AS
(SELECT ReportsTo, EmployeeID, Title, 1, convert(varchar(max), Title)
FROM Employees
WHERE ReportsTo IS NULL
UNION ALL
SELECT e.ReportsTo, e.EmployeeID, e.Title, b.level + 1, convert(varchar(max), b.path + '<--' + e.title)
FROM Employees e INNER JOIN Bosses b ON e.ReportsTo = b.emp)

SELECT * FROM Bosses
ORDER BY boss, emp;


/* Exercises */


-- 1. Give all employees that started working as an employee in the same year as Robert King

-- cte --> HireYear of Robert King

WITH cte AS (SELECT YEAR(HireDate) As HireYear FROM Employees WHERE FirstName = 'Robert' AND LastName = 'King')

SELECT * 
FROM Employees e JOIN cte ON  YEAR(HireDate) = cte.HireYear
WHERE NOT(FirstName = 'Robert' AND LastName = 'King')


-- 2 Make a histogram of the number of orders per customer, so show how many times each number occurs. 
-- E.g.: 1 customer placed 1 order, 2 customers placed 2 orders, 7 customers placed 3 orders, etc. 

-- cte --> number of orders per customer

/*
nr	NumberOfCustomers
1	1
2	2
3	7
4	6
5	10

...

*/

with NumberOfOrders(nr) as 
(select count(*)
 from orders
 group by customerid)

   select nr, count(*) as NumberOfCustomers
   from NumberOfOrders
   group by nr
   order by nr;



-- 3. Give the customers of the Country in which most customers live
--> cte1: number of customers per country
--> cte2: maximum */

--CustomerID	CompanyName	Country
--GREAL	Great Lakes Food Market	USA
--HUNGC	Hungry Coyote Import Store	USA
--LAZYK	Lazy K Kountry Store	USA
--LETSS	Let's Stop N Shop	USA
--LONEP	Lonesome Pine Restaurant	USA
--OLDWO	Old World Delicatessen	USA
--RATTC	Rattlesnake Canyon Grocery	USA
--SAVEA	Save-a-lot Markets	USA
--SPLIR	Split Rail Beer & Ale	USA
--THEBI	The Big Cheese	USA
--THECR	The Cracker Box	USA
--TRAIH	Trail's Head Gourmet Provisioners	USA
--WHITC	White Clover Markets	USA

WITH cte1(Country, NumberOfCustomers)
AS
(SELECT Country, COUNT(CustomerID)
FROM Customers
GROUP BY Country),

cte2(MaximumNumberOfCustomers)
AS
(SELECT MAX(NumberOfCustomers)
FROM cte1)

SELECT CustomerID, CompanyName, c.Country
FROM Customers c JOIN cte1 ON c.country = cte1.country JOIN cte2 ON cte1.NumberOfCustomers = cte2.MaximumNumberOfCustomers



-- 4. Give all employees except for the eldest
--> birthdate of the eldest in subquery or cte

--employeeid	employeeName	birthdate
--1	Nancy Davolio	1978-12-08 00:00:00.000
--2	Andrew Fuller	1982-02-19 00:00:00.000
--3	Janet Leverling	1993-08-30 00:00:00.000
--4	Margaret Peacock	1967-09-19 00:00:00.000
--5	Steven Buchanan	1975-03-04 00:00:00.000
--6	Michael Suyama	1983-07-02 00:00:00.000
--7	Robert King	1980-05-29 00:00:00.000
--8	Laura Callahan	1978-01-09 00:00:00.000
--9	Anne Dodsworth	1986-01-27 00:00:00.000

-- Solution 1 (using Subqueries)
SELECT employeeid, firstname + ' ' + lastname As employeeName, birthdate
FROM employees
WHERE birthdate > (SELECT MIN(birthdate) FROM employees)

-- Solution 2 (using CTE's)
WITH eldest(min_birthdate) AS
(SELECT min(birthdate)
FROM employees)

SELECT employeeid, firstname + ' ' + lastname As employeeName, birthdate
FROM employees CROSS JOIN eldest 
WHERE birthdate > eldest.min_birthdate


-- 5.  What is the total number of customers and suppliers?

WITH numberOfCustomers(nrOfCust) as (SELECT COUNT(CustomerID) FROM Customers),
numberOfSuppliers(nrOfSup) as (SELECT COUNT(SupplierID) FROM Suppliers)

SELECT((SELECT nrOfCust from numberOfCustomers) + (SELECT nrOfSup FROM numberOfSuppliers))


WITH numberOfCustomers(nrOfCust) as (SELECT COUNT(CustomerID) FROM Customers),
numberOfSuppliers(nrOfSup) as (SELECT COUNT(SupplierID) FROM Suppliers)

SELECT nrOfCust + nrOfSup As 'Total number of customers and suppliers'
FROM numberOfCustomers CROSS JOIN numberOfSuppliers


-- 6. Give per title the eldest employee

--employeeid	title	min_birthdate
--8	Inside Sales Coordinator	1978-01-09 00:00:00.000
--5	Sales Manager	1975-03-04 00:00:00.000
--4	Sales Representative	1967-09-19 00:00:00.000
--2	Vice President, Sales	1982-02-19 00:00:00.000

WITH eldestPerTitle(title, min_birthdate) AS
(SELECT title, min(birthdate)
FROM employees
GROUP BY title)

SELECT employeeid, ept.title, ept.min_birthdate
FROM Employees e JOIN eldestPerTitle ept
ON e.title = ept.title AND e.BirthDate = ept.min_birthdate


-- 7. Give per title the employee that earns most
--employeeid	fullName	title	max_salary
--2	Andrew Fuller	Vice President, Sales	90000.00
--1	Nancy Davolio	Sales Representative	48000.00
--5	Steven Buchanan	Sales Manager	55000.00
--8	Laura Callahan	Inside Sales Coordinator	51000.00

WITH mostEarningPerTitle(title, max_salary) AS
(SELECT title, max(salary)
FROM employees
GROUP BY title)

SELECT employeeid, firstname + ' ' + lastname As fullName, mept.title, mept.max_salary
FROM Employees e JOIN mostEarningPerTitle mept
ON e.title = mept.title AND e.salary = mept.max_salary


-- 8. Give the titles for which the eldest employee is also the employee who earns most
--employeeid	title	min_birthdate	max_salary
--2	Vice President, Sales	1982-02-19 00:00:00.000	90000.00
--5	Sales Manager	1975-03-04 00:00:00.000	55000.00
--8	Inside Sales Coordinator	1978-01-09 00:00:00.000	51000.00

WITH eldestPerTitle(title, min_birthdate) AS
(SELECT title, min(birthdate)
FROM employees
GROUP BY title),

mostEarningPerTitle(title, max_salary) AS
(SELECT title, max(salary)
FROM employees
GROUP BY title)

SELECT employeeid, ept.title, ept.min_birthdate, mept.max_salary
FROM Employees e JOIN eldestPerTitle ept
ON e.title = ept.title AND e.BirthDate = ept.min_birthdate
JOIN mostEarningPerTitle mept ON e.title = mept.title AND e.salary = mept.max_salary


-- 9. Execute the following script:
CREATE TABLE Parts 
(
    [Super]   CHAR(3) NOT NULL,
    [Sub]     CHAR(3) NOT NULL,
    [Amount]  INT NOT NULL,
    PRIMARY KEY(Super, Sub)
);

INSERT INTO Parts VALUES ('O1','O2',10);
INSERT INTO Parts VALUES ('O1','O3',5);
INSERT INTO Parts VALUES ('O1','O4',10);
INSERT INTO Parts VALUES ('O2','O5',25);
INSERT INTO Parts VALUES ('O2','O6',5);
INSERT INTO Parts VALUES ('O3','O7',10);
INSERT INTO Parts VALUES ('O6','O8',15);
INSERT INTO Parts VALUES ('O8','O11',5);
INSERT INTO Parts VALUES ('O9','O10',20);
INSERT INTO Parts VALUES ('O10','O11',25);

-- Show all parts that are directly or indirectly part of O2, so all parts of which O2 is composed.
-- Add an extra column with the path as below: 

/*
SUPER	SUB		PAD
O2		O5		O2 <-O5
O2		O6		O2 <-O6
O6		O8		O2 <-O6 <-O8
O8		O11		O2 <-O6 <-O8 <-O11

*/

WITH Relation(Super, Sub, [Path]) AS 
    (
        -- Default
        SELECT 
         Super
        ,Sub
        ,[Path] =  CAST(CONCAT(Super, ' <- ',Sub) AS NVARCHAR(MAX)) -- Don't forget to CAST
        FROM Parts  
        WHERE Super = 'O2' 

        UNION ALL
        -- Recursion
        SELECT 
         Parts.Super
        ,Parts.Sub  
        ,[Path] = CONCAT(Relation.[Path], ' <- ',Parts.Sub)
        FROM Parts 
            JOIN Relation ON Parts.Super = Relation.Sub
    ) 
    SELECT * FROM Relation;

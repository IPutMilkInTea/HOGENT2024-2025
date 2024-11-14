/* SUBQUERYS */

/********************************************/
/* Subqueries in the WHERE OR HAVING clause */
/********************************************/

/* SUBQUERY that returns a single value */

-- What is the UnitPrice of the most expensive product?
SELECT MAX(UnitPrice) As MaxPrice FROM Products

-- Alternative?
SELECT TOP 1 productName, UnitPrice FROM products
ORDER BY unitPrice DESC

-- What is the most expensive product?
SELECT ProductID, ProductName, UnitPrice As MaxPrice 
FROM Products
WHERE UnitPrice = (SELECT MAX(UnitPrice) FROM Products)

-- Alternative?
SELECT TOP 1 ProductID, ProductName, UnitPrice As MaxPrice 
FROM Products 
ORDER BY UnitPrice DESC


-- Give the products that cost more than average
SELECT ProductID, ProductName, UnitPrice As MaxPrice 
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)

-- Give the full name of the employee who earns most
SELECT LastName, FirstName
FROM Employees e
WHERE e.Salary = (SELECT MAX(Salary) FROM Employees)


-- Who is the youngest employee from the USA?
SELECT LastName, FirstName
FROM Employees
WHERE Country = 'USA'
AND BirthDate = (SELECT MAX(BirthDate) FROM Employees WHERE Country = 'USA')


-- Give the name of the most frequently sold product
SELECT productid, COUNT(productID)
FROM orderdetails
GROUP BY productid
HAVING COUNT(productID) = (
Select TOP 1 COUNT(ProductID) from OrderDetails 
group by ProductID
ORDER BY 1 DESC)


/* SUBQUERY that returns a single column */

-- Give the CustomerID and CompanyName of all customers that already placed an order
SELECT c.CustomerID, c.CompanyName 
FROM Customers c
WHERE c.CustomerID IN (SELECT DISTINCT CustomerID FROM Orders)

-- Alternative?
SELECT DISTINCT c.CustomerID, c.CompanyName 
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID

-- Give the CustomerID and CompanyName of all customers that not yet placed an order
SELECT c.CustomerID, c.CompanyName 
FROM Customers c
WHERE c.CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders)

-- Alternative?
SELECT c.CustomerID, c.CompanyName 
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.CustomerID is NULL

-- Give the CompanyName of the shippers that haven't shipped anything yet
SELECT CompanyName
FROM shippers
WHERE shipperID NOT IN (SELECT DISTINCT ShipVia FROM Orders)

-- Give the productID's for which some customers got a discount and other customers did not
SELECT DISTINCT od.ProductID
FROM OrderDetails od
WHERE od.Discount > 0 AND od.ProductID 
IN (SELECT ProductID FROM OrderDetails WHERE ProductID = od.ProductID AND discount = 0)

-- Give the CompanyName of the shippers that haven't shipped anything yet
SELECT DISTINCT CompanyName 
FROM Shippers
WHERE ShipperID NOT IN (Select ShipperID FROM Orders)


-- Give the productID's for which some customers got a discount and other customers did not
SELECT DISTINCT ProductID 
FROM OrderDetails
WHERE ProductID IN (SELECT ProductID FROM OrderDetails WHERE Discount = 0) AND
ProductID IN (SELECT ProductID FROM OrderDetails WHERE Discount > 0) 
ORDER BY ProductID


/* Correlated subquerys */
/*
In a correlated subquery the inner query depends on information from the outer query.
The subquery contains a search condition that refers to the main query, 
which makes the subquery depends on the main query
*/

-- Give employees with a salary larger than the average salary
SELECT FirstName + ' ' + LastName As FullName, Salary
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees)

-- Give the employees whose salary is larger 
-- than the average salary of the employees who report to the same boss.
SELECT FirstName + ' ' + LastName As FullName, ReportsTo, Salary
FROM Employees As e
WHERE Salary > 
(SELECT AVG(Salary) FROM Employees WHERE ReportsTo = e.ReportsTo)

-- Give all products that cost more 
-- than the average unitprice of products of the same category
SELECT *
FROM Products p
WHERE p.UnitPrice > (SELECT AVG(UnitPrice) FROM Products WHERE CategoryID = p.CategoryID)


-- Give the customers that ordered more often in 2016 than in 2017
SELECT CustomerID
FROM Orders o
WHERE YEAR(OrderDate) = 2016
GROUP BY CustomerID
HAVING COUNT(OrderID) > (SELECT COUNT(OrderID) FROM Orders WHERE customerID = o.CustomerID AND YEAR(OrderDate) = 2017)

/* Subqueries and the EXISTS operator */
-- Give the CustomerID and CompanyName of all customers that already placed an order
SELECT c.CustomerID, c.CompanyName 
FROM Customers c
WHERE EXISTS 
(SELECT * FROM Orders WHERE CustomerID = c.customerID)

-- Give the CustomerID and CompanyName of all customers that have not placed any orders yet
SELECT c.CustomerID, c.CompanyName 
FROM Customers c
WHERE NOT EXISTS 
(SELECT * FROM Orders WHERE CustomerID = c.customerID)

-- Alternative?
SELECT c.CustomerID, c.CompanyName 
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.CustomerID is NULL


-- Alternative?
SELECT CustomerID, CompanyName 
FROM Customers
WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders)



/***************************************************/
/* Subqueries in the SELECT and in the FROM clause */
/***************************************************/

-- The previous examples showed how subqueries can be used in the WHERE-clause
-- Since the result of a query is a table it can be used in the FROM-clause.
-- But we will be using CTE's (see further) instead

-- In a SELECT clause scalar (simple or correlated) subqueries can be used
-- Example: Give for each employee how much they earn more (or less) than the average salary of all employees with the same supervisor 


SELECT Lastname, Firstname, Salary, 
Salary -
(
    SELECT AVG(Salary)
    FROM Employees
    WHERE ReportsTo = e.ReportsTo
)
FROM Employees e




/* Application: running totals */

-- Give the cumulative sum of freight per year
SELECT OrderID, OrderDate, Freight,
(
	SELECT SUM(Freight) 
	FROM Orders
	WHERE YEAR(OrderDate) = YEAR(o.OrderDate) and OrderID <= o.OrderID
) As TotalFreight
FROM Orders o
ORDER BY Orderid;


/* Exercises */

-- 1. Give the id and name of the products that have not been purchased yet. 
-- Empty dataset
select productid, productname
from products
where productid not in (select productid from Orders);


-- 2. Select the names of the suppliers who supply products that have not been ordered yet.
-- Empty dataset

-- Extension of the previous exercise, but now you need the suppliers of the products that have not been ordered yet.

select s.CompanyName 
from suppliers s join products p on s.supplierID = p.supplierID
where productID not in (select productID from OrderDetails);

-- 3. Give a list of all customers from the same country as the customer Maison Dewey
--CompanyName	country
--Maison Dewey	Belgium
--Suprêmes délices	Belgium

SELECT CompanyName, country
FROM customers
WHERE country = (SELECT country from customers WHERE companyName = 'Maison Dewey')

-- 4. Give for each product how much the price differs from the average price of all products of the same category
--ProductID	ProductName	UnitPrice	differenceToCategory
--1	Chai	18,00	-19,9791
--2	Chang	19,00	-18,9791
--3	Aniseed Syrup	10,00	-13,0625
--4	Chef Anton's Cajun Seasoning	22,00	-1,0625

-- Analogous to the example 'Give for each employee how much they earn more (or less) than the average salary of all employees with the same supervisor'


SELECT ProductID, ProductName, UnitPrice, 
UnitPrice -
(
    SELECT AVG(UnitPrice)
    FROM Products
    WHERE CategoryID = p.CategoryID
) As differenceToCategory
FROM Products p



-- 5. Give per title the employee that was last hired
--title	FullName	HireDate
--Vice President, Sales	Andrew Fuller	2012-08-14 00:00:00.000
--Sales Representative	Anne Dodsworth	2014-11-15 00:00:00.000
--Sales Manager	Steven Buchanan	2013-10-17 00:00:00.000
--Inside Sales Coordinator	Laura Callahan	2014-03-05 00:00:00.000

-- Use a correlated subquery

SELECT title, firstname + ' ' + lastname As FullName, HireDate
FROM employees e
WHERE HireDate = (SELECT MAX(HireDate) FROM employees WHERE title = e.title)


-- 6. Which employee has processed most orders? 
-- Margaret Peacock		156

-- Analogous to 'Give the name of the most frequently sold product'


select e.firstname + ' '+ e.lastname, count(*)
from employees e join orders o on e.employeeid = o.EmployeeID
group by e.EmployeeID,e.LastName,e.FirstName
having count(*) = 
(select top 1 count(*)
 from employees e join orders o on e.employeeid = o.EmployeeID
 group by e.firstname + ' ' + e.lastname
 order by count(*) desc);

-- 7. What's the most common ContactTitle in Customers?
-- Owner 17
-- Sales Representative 17

SELECT contactTitle, COUNT(DISTINCT CustomerID)
FROM Customers
GROUP BY contactTitle
HAVING COUNT(DISTINCT CustomerID) = 
(SELECT TOP 1 COUNT(DISTINCT customerID) FROM Customers GROUP BY ContactTitle 
ORDER BY 1 DESC)

-- 8. Is there a supplier that has the same name as a customer?
-- Empty dataset
SELECT CompanyName FROM Suppliers WHERE CompanyName IN (SELECT CompanyName FROM Customers)

-- 9. Give all the orders for which the ShipAddress is different from the CustomerAddress
-- 48 records
SELECT * FROM Orders o WHERE ShipAddress != (SELECT Address FROM Customers c WHERE o.customerid = c.customerID)
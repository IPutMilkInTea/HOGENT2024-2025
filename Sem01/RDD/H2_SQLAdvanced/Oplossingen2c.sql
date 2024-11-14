/*** VIEWS ***/

/*
Definition
- A view is a saved SELECT statement
- A view can be seen as a virtual table composed of other tables & views
- No data is stored in the view itself, at each referral the underlying SELECT is re-executed;

Advantages
- Hide complexity of the database
	- Hide complex database design
	- Make large and complex queries accessible and reusable
	- Can be used as a partial solution for complex problems
- Used for securing data access: revoke access to tables and grant access to customised views. 
- Organise data for export to other applications
*/

-- Creating a view
CREATE OR ALTER VIEW V_ProductsCustomer(productcode, company, quantity)
AS SELECT od.ProductID, c.CompanyName, sum(od.Quantity)
FROM Customers c
JOIN Orders o ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY od.ProductID, c.CompanyName;

-- Use of a view
SELECT * FROM V_ProductsCustomer;

-- Changing a view
CREATE OR ALTER VIEW V_ProductsCustomer(productcode, company)
AS SELECT od.ProductID, c.CompanyName
FROM Customers c
JOIN Orders o ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY od.ProductID, c.CompanyName;

-- Dropping a view
DROP VIEW V_ProductsCustomer;

/* views as partial solution for complex problems */

-- Create a view with the number of orders per employee per year
CREATE OR ALTER VIEW vw_number_of_orders_per_employee_per_year
AS 
SELECT EmployeeID, YEAR(OrderDate) As OrderYear, COUNT(OrderID) As NumberOfOrders
FROM Orders
GROUP BY EmployeeID, YEAR(OrderDate)

-- Check the result
SELECT * FROM vw_number_of_orders_per_employee_per_year

-- Add the running total. Use the view.
SELECT EmployeeID, OrderYear, NumberOfOrders,
(SELECT SUM(NumberOfOrders) 
FROM vw_number_of_orders_per_employee_per_year
WHERE OrderYear <= vw.OrderYear AND EmployeeID = vw.EmployeeID
) As TotalNumberOfOrders
FROM vw_number_of_orders_per_employee_per_year vw
ORDER BY EmployeeID, OrderYear

/
/* Exercises */

-- Exercise 1
-- The company wants to weekly check the stock of their products.
-- If the stock is below 15, they'd like to order more to fulfill the need.

-- (1.1) Create a QUERY that shows the ProductId, ProductName and the name of the supplier, do not forget the WHERE clause.
select productid, productname, CompanyName from Products p join Suppliers s on p.SupplierID = s.SupplierID
where UnitsInStock < 15

-- (1.2) Turn this SELECT statement into a VIEW called: vw_products_to_order.
create view vw_products_to_order
AS select productid, productname, CompanyName from Products p join Suppliers s on p.SupplierID = s.SupplierID
where UnitsInStock < 15

-- (1.3) Query the VIEW to see the results.
SELECT * FROM vw_products_to_order

-- Exercise 2
-- The company has to increase prices of certain products. 
-- To make it seem the prices are not increasing dramatically they're planning to spread the price increase over multiple years. 
-- In total they'd like a 10% price for certain products. The list of impacted products can grow over the coming years. 
-- We'd like to keep all the logic of selecting the correct products in 1 SQL View, in programming terms 'keeping it DRY'. 
-- The updating of the items is not part of the view itself.
-- The products in scope are all the products with the term 'Bröd' or 'Biscuit'.

-- (2.1) Create a simple SQL Query to get the correct resultset
select ProductID, ProductName, UnitPrice
from Products
where ProductName LIKE '%bröd%' OR ProductName LIKE '%biscuit%'

-- (2.2) Turn this SELECT statement into a VIEW called: vw_price_increasing_products.
create view vw_price_increasing_products
AS select ProductID, ProductName, UnitPrice
from Products
where ProductName LIKE '%bröd%' OR ProductName LIKE '%biscuit%'

-- (2.3) Query the VIEW to see the results.
SELECT * FROM vw_price_increasing_products
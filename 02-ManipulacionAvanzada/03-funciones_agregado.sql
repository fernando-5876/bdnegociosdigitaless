/*
	Las funciones de Agregado son:
	1. Sum()
	2. Max()
	3. Min()
	4. Avg()
	5. Count(*)
	6. Count(campo)

	Nota: Estas funciones solamente regresan un solo registro
*/

-- Seleccionar los países de donde son los clientes

SELECT DISTINCT Country
FROM Customers;

-- Agregación Count(*) cuenta el número de registros que tiene una tabla

SELECT COUNT(*) AS [Total de Ordenes]
FROM Orders;

-- Seleccionar el total de ordenes que fueron enviadas a Alemania

SELECT COUNT(*) AS [Total de Ordenes]
FROM Orders
WHERE ShipCountry = 'Germany'

SELECT ShipCountry, COUNT(*) AS [Total de Ordenes]
FROM Orders
GROUP BY shipcountry

SELECT COUNT (CustomerID)
FROM Customers;

SELECT COUNT (Region)
FROM Customers;

-- Selecciona de cuantas ciudades son las ciudades de los clientes

SELECT COUNT (City)
FROM Customers;

SELECT DISTINCT city
FROM Customers
ORDER BY city ASC;

SELECT COUNT (DISTINCT city) AS [Ciudades clientes]
FROM Customers

-- Selecciona el precio máximo de los productos

SELECT *
FROM Products
ORDER BY UnitPrice DESC;

SELECT MAX(UnitPrice) AS [Precio más Alto]
FROM Products

--Seleccionar la fecha de compra más actual

SELECT MAX(OrderDate) AS [Ultima fecha de compra]
FROM Orders

-- Seleccioanr el año de la fecha de compra más reciente

SELECT YEAR(MAX(OrderDate)) AS [Año de compra más reciente]
FROM Orders;

SELECT MAX(DATEPART(YEAR, OrderDate)) AS [Año de compra más reciente]
FROM Orders;

SELECT DATEPART(YEAR, MAX(OrderDate)) AS [Año]
FROM Orders;

-- Cual es la minima cantidad de los pedidos

SELECT MIN(UnitPrice) AS [Precio minimo de venta]
FROM [Order Details];

-- Cual es el importe más bajo de las compras

SELECT (UnitPrice * Quantity * (1-Discount)) AS [Importe]
FROM [Order Details]
ORDER BY (UnitPrice * Quantity * (1-Discount)) ASC

SELECT (UnitPrice * Quantity * (1-Discount)) AS [Importe]
FROM [Order Details]
ORDER BY 1 ASC

SELECT MIN (UnitPrice * Quantity * (1-Discount)) AS [Importe más bajo]
FROM [Order Details]

-- Total de precio de los productos

SELECT SUM(UnitPrice) AS [Precio total de los productos]
FROM [Products]

-- Obtener el total de dinero percibido por las ventas

SELECT SUM((UnitPrice * Quantity * (1-Discount))) AS [Total de las ventas]
FROM [Order Details]

-- Seleccionar las ventas totales de los productoS 4, 10 y 20

SELECT SUM((UnitPrice * Quantity * (1-Discount))) AS [Venta]
FROM [Order Details]
WHERE ProductID IN (4, 10, 20)

-- Seleccionar el numero de ordenes hechas por los siguientes clientes: Around the Horn, Bolido Comidas Preparadas y Chop-Suey Chinese

SELECT COUNT(*) AS [Total de Ordenes]
FROM Orders
WHERE CustomerID IN ('AROUT', 'BOLID', 'CHOPS')

-- Seleccionar el total de ordenes del segundo trimestre de 1996

SELECT COUNT(*) AS [Total de Ordenes]
FROM Orders
WHERE MONTH(OrderDate) IN (04, 05, 06) AND YEAR(OrderDate) IN (1996)

-- Seleccionar el numero de ordenes entre 1996 a 1997

SELECT COUNT(*) AS [Número de Ordenes]
FROM Orders
WHERE YEAR(OrderDate) BETWEEN 1996 AND 1997

-- Seleccionar el numero de clientes que comienzan con a o que comienzan con b

SELECT COUNT(*) AS [Número de Clientes]
FROM Customers
WHERE CompanyName LIKE 'b%' OR CompanyName LIKE 'a%';

-- Seleccionar el numero de ordenes realizadas por el cliente Chop-suey Chinese en 1996

SELECT COUNT(*) AS [Numero de ordenes]
FROM Orders
WHERE CustomerID = 'CHOPS' AND YEAR(OrderDate) = 1996;

SELECT COUNT(*) AS [Numero de ordenes], SUM(OrderID) AS [Suma de las Ordenes]
FROM Orders
WHERE CustomerID = 'CHOPS' AND YEAR(OrderDate) = 1996;

-- Seleccionar el número de clientes que comienzan con b y que terminan con s

SELECT COUNT(*) AS [Número de Clientes]
FROM Customers
WHERE CompanyName LIKE 'b%s';

/*
	GROUP BY y HAVING
*/

SELECT CustomerID, COUNT(*) AS [Número de Ordenes]
FROM Orders
GROUP BY CustomerID
ORDER BY 2 DESC;

SELECT Customers.CompanyName, COUNT(*) AS [Número de Ordenes]
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.CompanyName
ORDER BY 2 DESC;

SELECT C.CompanyName, COUNT(*) AS [Número de Ordenes]
FROM Orders AS O
INNER JOIN Customers AS C ON O.CustomerID = C.CustomerID
GROUP BY C.CompanyName
ORDER BY 2 DESC;

-- Seleccionar el numero de productos (conteo) por categoria, 
--mostrar categoriaID, el total de los productos y ordenarlos de mayor a menor por el total de productos

SELECT CategoryID, COUNT(ProductID) AS [Total de productos]
FROM Products
GROUP BY CategoryID
ORDER BY [Total de productos] DESC;

-- Seleccionar el precio promedio por proveedor de los productos.
-- Redondear a 2 decimales el resultado y ordenar de forma descendente por el precio promedio

SELECT SupplierID, CAST(SUM(UnitPrice) / COUNT(ProductID) AS DECIMAL(10,2)) AS [Precio Promedio]
FROM Products
GROUP BY SupplierID
ORDER BY [Precio Promedio] DESC;

SELECT SupplierID, ROUND(AVG(UnitPrice), 2) AS [Precio Promedio]
FROM Products
GROUP BY SupplierID
ORDER BY [Precio Promedio] DESC;

-- Seleccionar el numero de clientes por pais y ordenarlos por pais alfabéticamente

SELECT Country, COUNT(CustomerID) AS [Número de clientes]
FROM Customers
GROUP BY Country

-- Obtener la cantidad total vendida agrupada por producto y por pedido

SELECT ProductID, SUM(UnitPrice * Quantity) AS [Total]
FROM [Order Details]
GROUP BY ProductID
ORDER BY ProductID

SELECT ProductID, OrderID, SUM(UnitPrice * Quantity) AS [Total]
FROM [Order Details]
GROUP BY ProductID, OrderID
ORDER BY ProductID

SELECT ProductID, OrderID, SUM(UnitPrice * Quantity) AS [Total]
FROM [Order Details]
GROUP BY ProductID, OrderID
ORDER BY ProductID, [Total] DESC

SELECT *, (UnitPrice * Quantity) AS [Total]
FROM [Order Details]
WHERE OrderID = 10847 AND ProductID = 1

-- Seleccionar la cantidad máxima vendida por producto en cada pedido

SELECT ProductID, OrderID,MAX(Quantity) AS [Cantidad máxima]
FROM [Order Details]
GROUP BY ProductID, OrderID
ORDER BY ProductID, OrderID

/**
	Flujo lógico de ejecución en SQL

	1. FROM
	2. JOIN
	3. WHERE
	4. GROUP BY
	5. HAVING
	6. SELECT
	7. DISTINT
	8. ORDER BY
**/

-- Having (Filtro de grupos)

-- Seleccionar los clientes que hayan realizado más de 10 pedidos

SELECT CustomerID, COUNT(*) AS [Número de Ordenes]
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) > 10
ORDER BY 2 DESC

SELECT CustomerID, COUNT(*) AS [Número de Ordenes]
FROM Orders
WHERE ShipCountry IN ('Germany', 'France', 'Brazil')
GROUP BY CustomerID
HAVING COUNT(*) > 10
ORDER BY 2 DESC

SELECT CustomerID, ShipCountry, COUNT(*) AS [Número de Ordenes]
FROM Orders
WHERE ShipCountry IN ('Germany', 'France', 'Brazil')
GROUP BY CustomerID, ShipCountry
HAVING COUNT(*) > 10
ORDER BY 2 DESC

SELECT C.CompanyName, COUNT(*) AS [Número de Ordenes]
FROM Orders AS O
INNER JOIN Customers AS C
ON O.CustomerID = C.CustomerID
GROUP BY C.CompanyName
HAVING COUNT(*) > 10
ORDER BY 2 DESC

-- Seleccionar los empleados que hayan gestionado pedidos por un total superior 100,000 en ventas 
-- (Mostrar el id, del empleado, su nombre y el total)

SELECT *
FROM Employees AS E
INNER JOIN Orders AS O
ON E.EmployeeID = O.EmployeeID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID

SELECT 
	CONCAT(E.FirstName, ' ', E.LastName) AS [Nombre Completo], (OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) AS [Importe]
FROM Employees AS E
INNER JOIN Orders AS O
ON E.EmployeeID = O.EmployeeID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
ORDER BY E.FirstName

SELECT 
	CONCAT(E.FirstName, ' ', E.LastName) AS [Nombre Completo], 
	ROUND(SUM(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)), 2) AS [Importe]
FROM Employees AS E
INNER JOIN Orders AS O
ON E.EmployeeID = O.EmployeeID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
GROUP BY E.FirstName, E.LastName
HAVING SUM(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) > 100000
ORDER BY [Importe] DESC

-- Seleccionar el número de productos vendidos en más de 20 pedidos distintos
-- Mostrar el Id del producto, el nombre del producto y el número de ordenes

SELECT 
	P.ProductID, 
	P.ProductName, 
	COUNT(DISTINCT O.OrderID) AS [Pedidos]
FROM Products AS P
INNER JOIN [Order Details] AS OD
ON P.ProductID = OD.ProductID
INNER JOIN Orders AS O
ON OD.OrderID = O.OrderID
GROUP BY P.ProductID, P.ProductName
HAVING COUNT(DISTINCT O.OrderID) > 20

-- Seleccionar los productos no descontinuados, calcular el precio promedio vendido
-- Mostrar solo aquellos que se hayan vendido en menos de 15 pedidos

SELECT P.ProductName, AVG(OD.UnitPrice) AS [Precio Promedio]
FROM Products AS P
INNER JOIN [Order Details] AS OD
ON P.ProductID = OD.ProductID
WHERE P.Discontinued <> 1
GROUP BY P.ProductName
HAVING COUNT(OrderID) < 15

-- Seleccionar el precio maximo de productos por categoria, pero solo si la suma de unidades es menor a 200 y además
-- que no estén descontinuados

SELECT 
	C.CategoryID, 
	C.CategoryName,
	P.ProductName,
	MAX(P.UnitPrice) AS [Precio Máximo]
FROM Categories AS C
INNER JOIN Products AS P
ON C.CategoryID = P.CategoryID
WHERE P.Discontinued = 0
GROUP BY C.CategoryID, 
		 C.CategoryName, 
		 P.ProductName
HAVING SUM(P.UnitsInStock) < 200
ORDER BY C.CategoryName, P.ProductName DESC

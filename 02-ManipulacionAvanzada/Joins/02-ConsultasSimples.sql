-- Consultas Simples con SQL-LMD

SELECT *
FROM Categories;

SELECT *
FROM Products;

SELECT *
FROM Orders;

SELECT *
FROM [Order Details];

-- Proyección (Seleccionar algunos campos)

SELECT 
ProductID, 
ProductName, 
UnitPrice, 
UnitsInStock
FROM Products;

-- Alias de Columnas

SELECT 
	ProductID AS [NUMERO DE PRODUCTO],
	ProductName 'NOMBRE DE PRODUCTO', 
	UnitPrice AS [PRECIO UNITARIO], 
	UnitsInStock AS STOCK
FROM Products;

SELECT 
	CompanyName AS CLIENTE,
	City AS CIUDAD,
	Country AS PAÍS
FROM Customers;

-- Campos calculados (Campo que no forma parte de la tabla, sacar a partir de una operación)

-- Seleccionar los productos y calcular el valor del inventario

SELECT *,(UnitPrice * UnitsInStock) AS [COSTO INVENTARIO]
FROM Products;

SELECT  
	ProductID, 
	ProductName, 
	UnitPrice, 
	UnitsInStock,
	(UnitPrice * UnitsInStock) AS [COSTO INVENTARIO]
FROM Products;

-- Calcular el importe de venta

SELECT 
	OrderID,
	ProductID,
	UnitPrice,
	Quantity,
	(UnitPrice * Quantity) AS IMPORTE
FROM [Order Details];

-- Seleccionar la venta con el calculo del importe con descuento
-- Agregar importe con descuento

SELECT 
	OrderID, 
	UnitPrice,
	Quantity, 
	Discount,
	(UnitPrice * Quantity) AS Importe,
	(UnitPrice * Quantity) - ((UnitPrice * Quantity) * Discount) AS [Importe con Descuento 1],
	(UnitPrice * Quantity) * (1 - Discount) AS [Importe con Descuento 2]
FROM [Order Details]

-- Operadores Relacionales (<, >, <=, >=, =, != o <>)

/*
	Seleccionar los productos con precio mayor a 30
	Seleccionar los productos con stock menor o igual a 20
	Seleccionar los pedidos posteriores a 1997
*/

SELECT ProductID AS [Número de Producto],
	ProductName AS [Nombre producto],
	UnitPrice AS [Precio Unitario],
	UnitsInStock AS Stock
FROM Products
WHERE UnitPrice>30
ORDER BY UnitPrice DESC;

SELECT ProductID AS [Número de Producto],
	ProductName AS [Nombre producto],
	UnitPrice AS [Precio Unitario],
	UnitsInStock AS Stock
FROM Products
WHERE UnitsInStock <= 20

SELECT 
	OrderID, 
	CustomerID, 
	EmployeeID, 
	OrderDate,
	YEAR(OrderDate) AS Año,
	MONTH(OrderDate) AS Mes,
	DAY(OrderDate) AS Día,
	DATEPART(YEAR, OrderDate) AS Año2,
	DATEPART(QUARTER, OrderDate) AS Trimestre,
	DATEPART(WEEKDAY, OrderDate) AS [Día Semana],
	DATENAME(WEEKDAY, OrderDate) AS [Día Semana Mombre]
FROM Orders
WHERE OrderDate > '1997-12-31'; -- WHERE YEAR(OrderDate) > 1997; / WHERE DATEPART(YEAR, OrderDate) > 1997;

SET LANGUAGE SPANISH;
SELECT 
	OrderID, 
	CustomerID, 
	EmployeeID, 
	OrderDate,
	YEAR(OrderDate) AS Año,
	MONTH(OrderDate) AS Mes,
	DAY(OrderDate) AS Día,
	DATEPART(YEAR, OrderDate) AS Año2,
	DATEPART(QUARTER, OrderDate) AS Trimestre,
	DATEPART(WEEKDAY, OrderDate) AS [Día Semana],
	DATENAME(WEEKDAY, OrderDate) AS [Día Semana Mombre]
FROM Orders
WHERE YEAR(OrderDate) > 1997;

-- Operadores Lógicos (Not, And, Or)

/*
	Seleccionar los productos que tengan un precio mayor a 20 y menos de 100 unidades en stock
	Mostrar los clientes que sean de EU o de Canada
	Obtener los pedidos que no tengan región
*/

SELECT ProductID, ProductName, UnitPrice, UnitsInStock
FROM Products
WHERE UnitPrice > 20 AND UnitsInStock < 100

SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE Country = 'USA' OR Country = 'Canada'

SELECT CustomerID, OrderDate, ShipRegion
FROM Orders
WHERE ShipRegion IS NULL

SELECT CustomerID, OrderDate, ShipRegion
FROM Orders
WHERE ShipRegion IS NOT NULL

-- Operador IN

/*
	Mostrar los clientes de Alemania, Francia y UK

	Obtener los productos donde la categoria sea 1, 3 o 5
*/

SELECT *
FROM Customers
WHERE Country IN ('Germany', 'France', 'UK')
ORDER BY Country DESC;

SELECT *
FROM Products
WHERE CategoryID IN (1, 3, 5)
ORDER BY CategoryID

-- Operador Between
/*
	Mostrar los productos cuyo precio está entre 20 y 40
*/

SELECT *
FROM Products
WHERE UnitPrice BETWEEN 20 AND 40
ORDER BY UnitPrice;

SELECT *
FROM Products
WHERE UnitPrice >= 20 AND UnitPrice <= 40
ORDER BY UnitPrice;

-- Operador LIKE

-- Seleccionar todos los clientes o customers que comiencen con la letra A

SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE CompanyName LIKE 'a';

SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE CompanyName LIKE 'an%';

SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE city LIKE 'L_nd__';

SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE CompanyName LIKE '%as';

-- Seleccionar los clientes donde la ciudad contenga la letra L

SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE city LIKE '%mé%';

-- Seleccionar todos los clientes que en su nombre comiencen con a o con b

SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE CompanyName LIKE 'a%' OR CompanyName LIKE 'b%';

SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE NOT CompanyName LIKE 'a%' OR CompanyName LIKE 'b%';

SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE NOT (CompanyName LIKE 'a%' OR CompanyName LIKE 'b%');

-- Seleccionar todos los clientes que comiencen con b y terminen s

SELECT CustomerID, CompanyName, City, Region, Country
FROM Customers
WHERE CompanyName LIKE 'b%s';

SELECT 
	CustomerID, 
	CompanyName, 
	City, 
	Region, 
	Country 
FROM Customers
WHERE CompanyName LIKE 'a__%';

-- Seleccionar todos los clientes (Nombre) que comiencen con "b", "s" o "p"

SELECT 
	CustomerID, 
	CompanyName, 
	City, 
	Region, 
	Country 
FROM Customers
WHERE CompanyName LIKE '[bsp]%';

-- Seleccionar todos los customers que comiencen con "a", "b", "c", "d", "e", "f"

SELECT 
	CustomerID, 
	CompanyName, 
	City, 
	Region, 
	Country 
FROM Customers
WHERE CompanyName LIKE '[abcdef]%';

SELECT 
	CustomerID, 
	CompanyName, 
	City, 
	Region, 
	Country 
FROM Customers
WHERE CompanyName LIKE '[a-f]%'
ORDER BY 2 ASC;

SELECT 
	CustomerID, 
	CompanyName, 
	City, 
	Region, 
	Country 
FROM Customers
WHERE CompanyName LIKE '[^bsp]%';

SELECT 
	CustomerID, 
	CompanyName, 
	City, 
	Region, 
	Country 
FROM Customers
WHERE CompanyName LIKE '[^a-f]%'
ORDER BY 2 ASC;

-- Seleccionar todos los clientes de EU o Canada que inicien con B

SELECT 
	CustomerID, 
	CompanyName, 
	City, 
	Region, 
	Country 
FROM Customers
WHERE Country IN ('USA', 'Canada') AND CompanyName LIKE 'b%'
ORDER BY Country 

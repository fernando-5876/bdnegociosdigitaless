/**
	JOINS
	1. INNER JOIN
	2. LEFT JOIN
	3. RIGHT JOIN
	4. FULL JOIN
**/

-- SELECCIONAR LAS CATEGORIAS Y SUS PRODUCTOS

SELECT 
	C.CategoryID, 
	C.CategoryName,
	P.ProductID,
	P.ProductName,
	P.UnitPrice,
	P.UnitsInStock,
	(P.UnitPrice * P.UnitsInStock) AS [Precio Inventario]
FROM Categories AS C
INNER JOIN Products AS P
ON C.CategoryID = P.CategoryID
WHERE C.CategoryID = 9

-- Crear una tabla a partir de una consulta

SELECT TOP 0 CategoryID, CategoryName
INTO Categoria
FROM Categories;

ALTER TABLE Categoria
ADD CONSTRAINT pk_Categoria
PRIMARY KEY (CategoryId);

INSERT INTO Categoria
VALUES ('C1'), ('C2'),('C3'),('C4'),('C5');

SELECT TOP 0
	ProductID AS [Numero_producto],
	ProductName AS [Nombre_producto],
	CategoryID AS [Catego_id]
INTO Producto
FROM Products

ALTER TABLE Producto
ADD CONSTRAINT pk_Producto
PRIMARY KEY (Numero_producto)

ALTER TABLE Producto
ADD CONSTRAINT fk_Producto_Categoria
FOREIGN KEY (Catego_id)
REFERENCES Categoria (CategoryID)
ON DELETE CASCADE;

INSERT INTO Producto
VALUES ('P1', 1), 
	   ('P2', 1), 
	   ('P3', 2), 
	   ('P4', 2), 
	   ('P5', 3), 
	   ('P6', NULL);

-- INNER JOIN

SELECT *
FROM Categoria AS C
INNER JOIN Producto AS P
ON C.CategoryID = P.Catego_id;

-- LEFT JOIN

SELECT *
FROM Categoria AS C
LEFT JOIN Producto AS P
ON C.CategoryID = P.Catego_id;

-- RIGHT JOIN

SELECT *
FROM Categoria AS C
RIGHT JOIN Producto AS P
ON C.CategoryID = P.Catego_id;

-- FULL JOIN

SELECT *
FROM Categoria AS C
FULL JOIN Producto AS P
ON C.CategoryID = P.Catego_id;

-- Simular el RIGHT JOIN  del query anterior con un LEFT JOIN

SELECT 
	C.CategoryID, 
	C.CategoryName, 
	P.Numero_producto, 
	P.Nombre_producto, 
	P.Catego_id
FROM Categoria AS C
RIGHT JOIN Producto AS P
ON C.CategoryID = P.Catego_id;

SELECT 
	C.CategoryID, 
	C.CategoryName, 
	P.Numero_producto, 
	P.Nombre_producto, 
	P.Catego_id
FROM Producto AS P
LEFT JOIN Categoria AS C
ON C.CategoryID = P.Catego_id;

SELECT *
FROM Categoria

SELECT *
FROM Producto

-- Visualizar todas las categorias que no tienen productos

SELECT *
FROM Categoria AS C
LEFT JOIN Producto AS P
ON C.CategoryID = P.Catego_id
WHERE Numero_producto IS NULL

-- Seleccionar todos los productos que no tienen categoria

SELECT *
FROM Categoria AS C
RIGHT JOIN Producto AS P
ON C.CategoryID = P.Catego_id
WHERE C.CategoryID IS NULL

-- Guardar en una tabla de productos nuevos todos aquellos productos que 
-- fueron agregados recientemente y no están en esta tabla de apoyo

-- Crear la tabla products_new a partir de Products mediante una consulta

SELECT TOP 0
	ProductID AS [Product_Number], 
	ProductName AS [Product_Name],
	UnitPrice AS [Unit_Price],
	UnitsInStock AS [Stock],
	(UnitPrice * UnitsInStock) AS [Total]
INTO Products_new
FROM Products

ALTER TABLE Products_new
ADD CONSTRAINT pk_Products_new
PRIMARY KEY ([Product_Number]);

SELECT 
	P.ProductID, 
	P.ProductName, 
	P.UnitPrice, 
	P.UnitsInStock,
	(P.UnitPrice * P.UnitsInStock) AS TOTAL,
	PW.*
FROM Products AS P
LEFT JOIN Products_new AS PW
ON P.ProductID = PW.Product_Number

INSERT INTO Products_new
SELECT 
	P.ProductName, 
	P.UnitPrice, 
	P.UnitsInStock,
	(P.UnitPrice * P.UnitsInStock) AS TOTAL
FROM Products AS P
LEFT JOIN Products_new AS PW
ON P.ProductID = PW.Product_Number
WHERE PW.Product_Number IS NULL;

INSERT INTO Products_new
SELECT 
	P.ProductName, 
	P.UnitPrice, 
	P.UnitsInStock,
	(P.UnitPrice * P.UnitsInStock) AS TOTAL
FROM Products AS P
LEFT JOIN Products_new AS PW
ON P.ProductID = PW.Product_Number
WHERE PW.Product_Number IS NULL;

SELECT *
FROM Products_new
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
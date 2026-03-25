SELECT *
FROM Clientes;

SELECT *
FROM Representantes

SELECT *
FROM Oficinas

SELECT *
FROM Productos

SELECT *
FROM Pedidos

-- Crear una vista que visualice el total de los importes agrupados por producto
-- En una vista los nombres de las columnas no deben estar vacios

CREATE OR ALTER VIEW vw_importes_productos AS 
SELECT 
	PR.Descripcion AS [Nombre del producto], 
	SUM(P.Importe) AS [Total],
	SUM(P.Importe * 1.15) AS [ImporteDescuento]
FROM Pedidos AS P
INNER JOIN Productos AS PR
ON P.Fab = PR.Id_fab
AND P.Producto = PR.Id_producto
GROUP BY PR.Descripcion

SELECT *
FROM vw_importes_productos
WHERE [Nombre del producto] LIKE '%brazo%'
AND ImporteDescuento > 34000

-- Seleccionar los nombres de los representantes y las oficinas donde trabajan

CREATE OR ALTER VIEW vw_oficinas_representantes AS
SELECT 
	R.Nombre, 
	R.Ventas AS [VentasRepresentantes], 
	O.Oficina,
	O.Ciudad, 
	O.Region, 
	O.Ventas AS [VentasOficinas]
FROM Representantes AS R
INNER JOIN Oficinas AS O
ON O.Oficina = R.Oficina_Rep


SELECT *
FROM Representantes
WHERE Nombre = 'Daniel Ruidrobo'

SELECT Nombre, Ciudad
FROM vw_oficinas_representantes
ORDER BY Nombre DESC

-- Seleccionar los pedidos con fecha e importe, el nombre del representante que lo realizó y al cliente que lo solicitó

SELECT 
	P.Num_Pedido, 
	P.Fecha_Pedido, 
	P.Importe, 
	C.Empresa,
	R.Nombre
FROM Pedidos AS P
INNER JOIN Clientes AS C
ON C.Num_Cli = P.Cliente
INNER JOIN Representantes AS R
ON R.Num_Empl = P.Rep

SELECT 
	P.Num_Pedido, 
	P.Fecha_Pedido, 
	P.Importe, 
	C.Empresa,
	R.Nombre
FROM Pedidos AS P
INNER JOIN Clientes AS C
ON C.Num_Cli = P.Cliente
INNER JOIN Representantes AS R
ON R.Num_Empl = C.Rep_Cli


-- Seleccionar los pedidos con fecha e importe, el nombre del representante que lo realizó y al cliente que lo solicitó
-- B1

SELECT 
	C.Num_Cli, 
	C.Empresa, 
	P.Nombre,
	C.Limite_Credito
FROM Clientes AS C
INNER JOIN Representantes AS P
ON C.Rep_Cli = P.Num_Empl
WHERE C.Limite_Credito >= 40000 AND C.Empresa LIKE '%S.A' OR C.Empresa LIKE '%S.A.'
ORDER BY C.Limite_Credito DESC

-- B2

SELECT
	Descripcion,
	Precio,
	Stock,
	(Precio * Stock) AS [ValorInventario]
FROM Productos
WHERE Stock BETWEEN 10 AND 40 AND Precio BETWEEN 100 AND 5000
ORDER BY [ValorInventario] DESC

-- B3

SELECT 
	P.Num_Pedido,
	P.Fecha_Pedido,
	C.Empresa,
	P.Importe
FROM Pedidos AS P
INNER JOIN Clientes AS C
ON C.Rep_Cli = P.Rep
WHERE C.Empresa LIKE '%Ltd'
ORDER BY P.Fecha_Pedido

-- B4

SELECT 
	Oficina,
	Ciudad,
	Region,
	AVG(Ventas) AS [PromedioVentasRep]
FROM Oficinas
GROUP BY Oficina, Ciudad, Region
ORDER BY PromedioVentasRep DESC

-- B5 

SELECT
	C.Num_Cli,
	C.Empresa,
	P.Num_Pedido
FROM Pedidos AS P
INNER JOIN Clientes AS C
ON C.Rep_Cli = P.Rep
GROUP BY C.Num_Cli, C.Empresa, P.Num_Pedido
HAVING COUNT(P.Num_Pedido) > 1
ORDER BY Num_Pedido DESC, Empresa 

-- B6

SELECT 
	COUNT(Ventas) AS [TotalVentasReps],
	COUNT(Jef) as [NumReps]
FROM Oficinas AS O
ORDER BY TotalVentasReps DESC

SELECT
	SUM(R.Ventas) AS [TotalVentasReps],
	COUNT(O.Jef) as [NumReps]
FROM Oficinas AS O
INNER JOIN Representantes AS R
ON O.Oficina = R.Oficina_Rep

SELECT *
FROM Oficinas AS O
INNER JOIN Representantes AS R
ON O.Oficina = R.Oficina_Rep

-- Vista 1

CREATE OR ALTER VIEW vw_ClientesRepOficina_B AS
SELECT 
	C.Num_Cli,
	C.Empresa,
	C.Limite_Credito,
	R.Nombre,
	R.Puesto,
	O.Ciudad,
	O.Region
FROM Clientes AS C
INNER JOIN Representantes AS R
ON C.Rep_Cli = R.Num_Empl
INNER JOIN Oficinas AS O
ON R.Oficina_Rep = O.Oficina

SELECT *
FROM vw_ClientesRepOficina_B

-- Vista 2

CREATE OR ALTER VIEW vw_VentasPorCliente_B AS
SELECT 
	C.Num_Cli,
	C.Empresa,
	SUM(P.Importe) AS [TotalImporte],
	COUNT(P.Num_Pedido) AS [NumPedidos]
FROM Clientes AS C
INNER JOIN PEDIDOS AS P
ON C.Rep_Cli = P.Rep
GROUP BY C.Num_Cli, C.Empresa
HAVING SUM(P.Importe) >= 30000

SELECT *
FROM vw_VentasPorCliente_B
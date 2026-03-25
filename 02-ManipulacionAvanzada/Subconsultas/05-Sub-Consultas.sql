-- Subconsulta escalar (un valor)

-- Escalar en SELECT

SELECT 
	O.OrderID, 
	(OD.Quantity * OD.UnitPrice) AS Total,
	(SELECT AVG((OD.Quantity * OD.UnitPrice)) FROM [Order Details] AS OD) AS [AVGTOTAL]
FROM Orders AS O
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID

-- Mostrar el nombre del producto y el precio promedio de todos los productos

SELECT 
    ProductName,
    (SELECT AVG(UnitPrice) FROM Products) AS PrecioPromedio
FROM Products;

SELECT *
FROM Products

-- Mostrar cada empleado y la cantidad total de pedidos que tiene

SELECT E.EmployeeID, FirstName, LastName, COUNT(O.OrderID) AS [Numero de ordenes]
FROM Employees AS E
INNER JOIN Orders AS O
ON E.EmployeeID = O.EmployeeID
GROUP BY E.EmployeeID, FirstName, LastName

SELECT 
    FirstName + ' ' + LastName AS NombreEmpleado,
    (SELECT COUNT(OrderID) 
     FROM Orders 
     WHERE EmployeeID = Employees.EmployeeID) AS TotalPedidos
FROM Employees;

-- Mostrar cada cliente y la fecha de su ultimo pedido

SELECT 
    CompanyName AS Cliente,
    (SELECT MAX(OrderDate) 
     FROM Orders 
     WHERE CustomerID = Customers.CustomerID) AS FechaUltimoPedido
FROM Customers;

-- Mostrar pedidos con nombre del cliente y total del pedido (SUM)

SELECT 
    OrderID,
    (SELECT CompanyName 
     FROM Customers 
     WHERE CustomerID = Orders.CustomerID) AS NombreCliente,
    (SELECT SUM(UnitPrice * Quantity) 
     FROM [Order Details] 
     WHERE OrderID = Orders.OrderID) AS TotalPedido
FROM Orders;

-- Datos de ejemplo

CREATE DATABASE bdsubconsultas
GO

USE bdsubconsultas
GO

CREATE TABLE CLIENTES(
 id_cliente INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
 nombre NVARCHAR(50) NOT NULL,
 ciudad NCHAR(20) NOT NULL
)

CREATE TABLE PEDIDOS(
 id_pedido INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
 id_cliente INT NOT NULL,
 total MONEY NOT NULL,
 fecha DATE NOT NULL,
 CONSTRAINT fk_pedidos_clientes
 FOREIGN KEY (id_cliente)
 REFERENCES clientes(id_cliente)
)

INSERT INTO clientes (nombre, ciudad) VALUES
('Ana', 'CDMX'),
('Luis', 'Guadalajara'),
('Marta', 'CDMX'),
('Pedro', 'Monterrey'),
('Sofia', 'Puebla'),
('Carlos', 'CDMX'), 
('Artemio', 'Pachuca'), 
('Roberto', 'Veracruz');

INSERT INTO pedidos (id_cliente, total, fecha) VALUES
(1, 1000.00, '2024-01-10'),
(1, 500.00,  '2024-02-10'),
(2, 300.00,  '2024-01-05'),
(3, 1500.00, '2024-03-01'),
(3, 700.00,  '2024-03-15'),
(1, 1200.00, '2024-04-01'),
(2, 800.00,  '2024-02-20'),
(3, 400.00,  '2024-04-10');

-- Consulta escalar

-- Seleccionar los pedidos en donde el total sea igual al total maximo de ellos

SELECT MAX(total)
FROM PEDIDOS;

SELECT *
FROM PEDIDOS
WHERE total = (
    SELECT MAX(total)
    FROM PEDIDOS
)

SELECT TOP 1 P.id_cliente, C.nombre, P.fecha, P.total
FROM PEDIDOS AS P
INNER JOIN CLIENTES AS C
ON P.id_cliente = C.id_cliente
ORDER BY P.total DESC;


SELECT P.id_cliente, C.nombre, P.fecha, P.total
FROM PEDIDOS AS P
INNER JOIN CLIENTES AS C
ON P.id_cliente = C.id_cliente
WHERE P.total = (
    SELECT MAX(total)
    FROM PEDIDOS
)

-- Seleccionar los pedidos mayores al promedio

SELECT AVG(total) 
FROM PEDIDOS;

SELECT * 
FROM PEDIDOS
WHERE total > (
    SELECT AVG(total) 
    FROM PEDIDOS
)

-- Seleccionar todos los pedidos del cliente que tenga el menor ID

SELECT MIN(id_cliente)
FROM PEDIDOS

SELECT *
FROM PEDIDOS
WHERE id_cliente = (
    SELECT MIN(id_cliente)
    FROM PEDIDOS
)

SELECT id_cliente, COUNT(*) AS [Numero de Pedidos]
FROM PEDIDOS
WHERE id_cliente = (
    SELECT MIN(id_cliente)
    FROM PEDIDOS
)
GROUP BY id_cliente

-- Mostrar los datos del pedido de la última orden

SELECT MAX(fecha)
FROM PEDIDOS

SELECT P.id_pedido, C.nombre, P.fecha, P.total
FROM PEDIDOS AS P
INNER JOIN CLIENTES AS C
ON P.id_cliente = C.id_cliente
WHERE fecha = (
    SELECT MAX(fecha)
    FROM PEDIDOS
)

-- Mostrar todos los pedidos con un total que sea el mas bajo

SELECT MIN(total)
FROM PEDIDOS

SELECT *
FROM PEDIDOS
WHERE total = (
    SELECT MIN(total)
    FROM PEDIDOS
)

-- Seleccionar los pedidos con el nombre del cliente cuyo total (Freight) sea
-- Mayor al promedio general de Freight

USE NORTHWND

SELECT AVG(Freight)
FROM Orders;

SELECT O.OrderID, C.CompanyName, CONCAT(E.FirstName, ' ', E.LastName) AS [FULLNAME], O.Freight
FROM Orders AS O
INNER JOIN Customers AS C
ON O.CustomerID = C.CustomerID
INNER JOIN Employees AS E
ON E.EmployeeID = O.EmployeeID
WHERE O.Freight > (
    SELECT AVG(Freight)
    FROM Orders
)
ORDER BY O.Freight DESC;

SELECT O.OrderID, C.CompanyName, O.Freight
FROM Orders AS O
INNER JOIN Customers AS C
ON O.CustomerID = C.CustomerID
WHERE O.Freight > 78.2442;

SELECT * FROM PEDIDOS;
SELECT * FROM CLIENTES

-- Subquerys con IN, ANY, ALL (llevan una sola columna)
-- La clausula IN

-- Clientes que han hecho pedidos

SELECT id_cliente
FROM PEDIDOS;

SELECT *
FROM CLIENTES
WHERE id_cliente IN (
    SELECT id_cliente
    FROM PEDIDOS
)

SELECT DISTINCT C.id_cliente, C.nombre, C.ciudad
FROM CLIENTES AS C
INNER JOIN PEDIDOS AS P
ON C.id_cliente = P.id_cliente

--clientes que ean hecho pedidios mayores a 800--

select distinct c.id_cliente, p.nombre, c.id_pedido,p.total
from PEDIDOS as p
inner join PEDIDOS as c
on p.id_cliente = c.id_cliente  (

select id_pedido
from PEDIDOS
where total > 800;

);


select *
from PEDIDOS
where id_cliente in (
select id_cliente 
from PEDIDOS
where total > 800

);

---mostrar todos los clientes de la ciudad de mexico que han hecho pedidos

select *
from clientes as c 
where ciudad = 'CDMX'
and id_cliente in (
select id_cliente
from PEDIDOS

);






select *
from PEDIDOS
where id_cliente in (
select id_cliente 
from PEDIDOS
where total > 800

);
select *
from CLIENTES




select *
from clientes
where ciudad = 'CDMX'
and id_cliente in (
select id_cliente
from PEDIDOS
);


--seleccionar clientes que no an echo pedidos 

select *
from clientes
where ciudad = 'CDMX'
and id_cliente in (
select id_cliente
from PEDIDOS
);


select *
from PEDIDOS as p
inner join clientes as c
on p.id_cliente = c.id_cliente;

----- right join se ocupo ese por que el right join da como nulos los que no son iguales por ende los nulos son los
--que no realizaron pedidos
select *
from PEDIDOS as p
right join clientes as c
on p.id_cliente = c.id_cliente
where p.id_cliente is null;


select id_cliente 
from PEDIDOS
--- es el mismo pero realizado con subconsulta


select *
from CLIENTES
where id_cliente not in (
select id_cliente 
from PEDIDOS
);



--pedidos de clienetes de monterrey solo

select id_cliente
from PEDIDOS
where id_cliente in (
 select id_cliente
 from CLIENTES
 where ciudad = 'Monterrey'

);


select *
from CLIENTES



--clausula any

--compara un valor contra una lista 
--la condicion se cumple si se cumple con almenos 1uno 
--sintaxis

--seleccionar pedidios mayores que algun pedido de luis (id_cliente=2)
--primero la subconsulta

select total
from PEDIDOS
where id_cliente = 2;

--consulta principal 
select * 
from PEDIDOS
where total > any (

select total
from PEDIDOS
where id_cliente = 1  

);

select *
from CLIENTES
--seleccionar los pedidos mayores que algulk pedido superior a 500

select * 
from PEDIDOS
where total >  any  (

select total
from PEDIDOS
where total = 500

);







--- funcion all en subconsultas 

-- seleccionar los pedidos donde el total sea mayor a todos los totales de los pedidos de luis 

select *
from CLIENTES
select *
from PEDIDOS

select *
from PEDIDOS
where total > all(
select total
from PEDIDOS
where id_cliente = 2

);


select 
from PEDIDOS
where id_cliente = 2


-- seleccionar todos los clientes donde su id sea meno que todos los clientes de la cdmx


select id_cliente
from CLIENTES
where id_cliente < all (

select id_cliente
from CLIENTES
where ciudad = 'CDMX'
);


---1. Seleccionar los clienets coyo total de compras sea mayor a mil



select *
from CLIENTES as c 
where (

select sum(total) 
from PEDIDOS as p 
where p.id_cliente = c.id_cliente 
) > 1000;


----seleccionar todos los clientes que an hecho mas de un pedido 


select * 
from CLIENTES as c 
where (
select count(*)
from PEDIDOS as p 
where id_cliente = c.id_cliente
) > 1;


---seleccionar el total de pedidos que son mayores al promedio de su cliente 


select * 
from PEDIDOS as p
where total > (
 select avg(total)
 from PEDIDOS as pe
 where pe.id_cliente =p.id_cliente
); 


--seleccionar todos los clienetes culloo pedido maximo sea mayor a 1200

select *
from CLIENTES as c 
where (

select max(total) 
from PEDIDOS as p 
where p.id_cliente = c.id_cliente 
) > 1200;

select max(total)
from PEDIDOS
where id_cliente = 1


select * 
from PEDIDOS
where
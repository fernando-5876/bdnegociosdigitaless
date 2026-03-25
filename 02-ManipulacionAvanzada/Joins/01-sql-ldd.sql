
-- Crea una Base de Datos
CREATE DATABASE Tienda;
GO

use Tienda;

-- Crear Tabla cliente
CREATE TABLE cliente (
	id INT NOT NULL,
	nombre NVARCHAR(30) NOT NULL,
	apaterno NVARCHAR(10) NOT NULL,
	amaterno NVARCHAR (10) NULL,
	sexo NCHAR(1) NOT NULL,
	edad INT NOT NULL,
	direccion NVARCHAR(80) NOT NULL,
	RFC NVARCHAR(13) NOT NULL,
	limitecredito MONEY NOT NULL DEFAULT 500.0
);
GO

-- Restricciones

CREATE TABLE Clientes(
	cliente_id INT NOT NULL PRIMARY KEY,
	nombre NVARCHAR(30) NOT NULL,
	apellido_paterno NVARCHAR(20) NOT NULL,
	apellido_materno NVARCHAR(20),
	edad INT NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	limite_credito MONEY NOT NULL
);
GO

INSERT INTO Clientes
VALUES (1, 'GOKU', 'LINTERNA', 'SUPERMAN', 450, '1578-01-17', 150);

INSERT INTO Clientes
VALUES (2, 'PANCRACIO', 'RIVERO', 'PATROCLO', 20, '2005-01-17', 10000);

INSERT INTO Clientes 
(nombre, cliente_id, limite_credito, fecha_nacimiento, apellido_paterno, edad)
VALUES ('ARCADIA', 3, 45800, '2000-01-22', 'RAMIREZ', 26);

INSERT INTO Clientes 
VALUES (4, 'VANESSA', 'BUENAVISTA', NULL, 26, '2000-04-25', 3000);
GO

INSERT INTO Clientes 
VALUES (5, 'SOYLA', 'VACA', 'DEL CORRAL', 42, '1983-04-06', 78955),
(6, 'BAD BUNNY', 'PEREZ', 'SIN SENTIDO', 22, '1989-05-06', 85858),
(7, 'JOSE LUIS', 'HERRERA', 'GALLARDO', 42, '1983-04-06', 14000);

SELECT *
FROM clientes;

SELECT cliente_id, nombre, edad, limite_credito
FROM clientes;

SELECT GETDATE(); -- Obtiene la fecha del sistema

CREATE TABLE Clientes_2(
	cliente_id INT NOT NULL IDENTITY(1,1),
	nombre NVARCHAR(50) NOT NULL,
	edad INT NOT NULL,
	fecha_registro DATE DEFAULT GETDATE(),
	limite_credito MONEY NOT NULL,
	CONSTRAINT pk_Clientes_2
	PRIMARY KEY (cliente_id), 
);

SELECT *
FROM Clientes_2;

INSERT INTO Clientes_2
VALUES ('chespirito', 78, DEFAULT, 45500);

INSERT INTO Clientes_2 (nombre, edad, limite_credito)
VALUES ('Batman', 45, 89000);

INSERT INTO Clientes_2
VALUES ('Robin', 35, '2026-01-19', 89.32);

INSERT INTO Clientes_2 (limite_credito, edad, nombre, fecha_registro)
VALUES (12.33, 24, 'Flash Reverso', '2026-01-21');

CREATE TABLE suppliers (
	supplier_id INT NOT NULL IDENTITY(1,1),
	[name] NVARCHAR(30) NOT NULL,
	date_register DATE NOT NULL DEFAULT GETDATE(),
	tipo CHAR(1) NOT NULL,
	credit_limit MONEY NOT NULL,
	CONSTRAINT pk_suppliers
	PRIMARY KEY ( supplier_id ),
	CONSTRAINT unique_name
	UNIQUE ([name]),
	CONSTRAINT chk_credit_limit
	CHECK (credit_limit > 0.0 AND credit_limit <= 50000),
	CONSTRAINT chk_tipo
	CHECK (tipo IN ('A','B','C')),
);

SELECT *
FROM suppliers;

INSERT INTO suppliers
VALUES (UPPER('bimbo'), DEFAULT, UPPER('c'), 45000);

INSERT INTO suppliers
VALUES (UPPER('tia rosa'), '2026-01-21', UPPER('a'), 49999.9999);

INSERT INTO suppliers ([name], tipo, credit_limit)
VALUES (UPPER('tia mensa'), UPPER('a'), 49999.9999);

-- Crear Base de Datos dborders

CREATE DATABASE dborders;
GO

USE dborders;
GO

-- Crear tabla customers

CREATE TABLE customers (
	customers_id INT NOT NULL IDENTITY(1, 1),
	first_name NVARCHAR(20) NOT NULL,
	last_name VARCHAR(20),
	[address] NVARCHAR(80) NOT NULL,
	number INT,
	CONSTRAINT pk_customers
	PRIMARY KEY (customers_id)
);
GO

CREATE TABLE products(
	product_id INT NOT NULL IDENTITY(1, 1),
	[name] NVARCHAR(40) NOT NULL,
	quantity INT NOT NULL,
	unit_price MONEY NOT NULL,
	supplier_id INT,
	CONSTRAINT pk_products
	PRIMARY KEY (product_id),
	CONSTRAINT unique_name_products
	UNIQUE ([name]),
	CONSTRAINT chk_quantity
	CHECK (quantity BETWEEN 1 AND 100),
	CONSTRAINT chk_unit_price
	CHECK ( unit_price > 0 AND unit_price <= 100000),
	CONSTRAINT fk_products_suppliers
	FOREIGN KEY (supplier_id)
	REFERENCES suppliers (supplier_id)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
);
GO

DROP TABLE products;
DROP TABLE suppliers;

ALTER TABLE products
DROP CONSTRAINT fk_products_suppliers;

DROP TABLE suppliers

CREATE TABLE suppliers (
	supplier_id INT NOT NULL,
	[name] NVARCHAR(30) NOT NULL,
	date_register DATE NOT NULL DEFAULT GETDATE(),
	tipo CHAR(1) NOT NULL,
	credit_limit MONEY NOT NULL,
	CONSTRAINT pk_suppliers
	PRIMARY KEY ( supplier_id ),
	CONSTRAINT unique_name
	UNIQUE ([name]),
	CONSTRAINT chk_credit_limit
	CHECK (credit_limit > 0.0 AND credit_limit <= 50000),
	CONSTRAINT chk_tipo
	CHECK (tipo IN ('A','B','C')),
);
GO



DROP TABLE products;

-- Permite cambiar la estructura de una columna a la tabla
ALTER TABLE products
ALTER COLUMN supplier_id INT NULL

INSERT INTO suppliers
VALUES (1, UPPER('Chino S.A.'), DEFAULT, UPPER('c'), 45000);

INSERT INTO suppliers
VALUES (2, UPPER('Chanclotas'), '2026-01-21', UPPER('a'), 49999.9999);

INSERT INTO suppliers (supplier_id, [name], tipo, credit_limit)
VALUES (3, UPPER('Rama-ma'), UPPER('a'), 49999.9999);

SELECT *
FROM suppliers;

INSERT INTO products
VALUES ('Papas', 10, 5.3, 1);

INSERT INTO products
VALUES ('Rollos Primavera', 20, 100, 1);

INSERT INTO products
VALUES ('Chanclas pata de gallo', 50, 20,10);

INSERT INTO products
VALUES ('Chanclas buenas', 30, 56.7,10),
	   ('Ramita chiquita', 56, 78.23, 3);

INSERT INTO products
VALUES ('Azulito', 100, 15.3, NULL);

-- Comprobación ON DELETE NO ACTION

-- Eliminar los hijos

DELETE FROM products
WHERE supplier_id = 1;

-- Eliminar al padre
DELETE FROM suppliers
WHERE supplier_id = 1;

-- Comprobar el UPDATE NO ACTION

UPDATE suppliers
SET supplier_id = 10
WHERE supplier_id = 2;

UPDATE products
SET supplier_id = NULL;

DELETE FROM products
WHERE supplier_id = 1;

-- chanclas patas de gallo y buenas el no.1 y a ramita chiquita 3
UPDATE products
SET supplier_id = 2
WHERE product_id IN (7, 8);

UPDATE products
SET supplier_id = 10
WHERE product_id IN (3, 4);

UPDATE suppliers
SET supplier_id = 10
WHERE supplier_id = 2;

UPDATE products
SET supplier_id = 20
WHERE supplier_id IS NULL;

UPDATE products
SET supplier_id = NULL
WHERE supplier_id = 2;

CREATE TABLE products(
	product_id INT NOT NULL IDENTITY(1, 1),
	[name] NVARCHAR(40) NOT NULL,
	quantity INT NOT NULL,
	unit_price MONEY NOT NULL,
	supplier_id INT,
	CONSTRAINT pk_products
	PRIMARY KEY (product_id),
	CONSTRAINT unique_name_products
	UNIQUE ([name]),
	CONSTRAINT chk_quantity
	CHECK (quantity BETWEEN 1 AND 100),
	CONSTRAINT chk_unit_price
	CHECK ( unit_price > 0 AND unit_price <= 100000),
	CONSTRAINT fk_products_suppliers
	FOREIGN KEY (supplier_id)
	REFERENCES suppliers (supplier_id)
	ON DELETE SET NULL
	ON UPDATE SET NULL
);

-------- COMPROBAR ON DELETE SET NULL

DELETE suppliers
WHERE supplier_id = 10

SELECT *
FROM suppliers;

SELECT *
FROM products;

------------ COMPROBAR ON UPDATE SET NULL
UPDATE suppliers
SET supplier_id = 20
WHERE supplier_id = 1;
CREATE DATABASE bdpracticas;
GO

USE bdpracticas;
GO

CREATE TABLE CatProducto(
	Id_Producto INT IDENTITY PRIMARY KEY,
	nombre_Producto NVARCHAR(40),
	Existencia INT,
	Precio MONEY
);
GO

SET IDENTITY_INSERT
bdpracticas.dbo.CatProducto ON;

SET IDENTITY_INSERT
bdpracticas.dbo.CatProducto OFF;

INSERT INTO bdpracticas.dbo.CatProducto 
(Id_Producto, nombre_Producto, Existencia, Precio)
SELECT ProductID, ProductName, UnitsInStock, UnitPrice
FROM NORTHWND.dbo.Products

SELECT *
FROM CatProducto

CREATE TABLE CatCliente (
	Id_Cliente NVARCHAR(5) PRIMARY KEY,
	nombre_Cliente NVARCHAR(40),
	País NVARCHAR(15),
	Ciudad NVARCHAR (15)
)
GO

INSERT INTO bdpracticas.dbo.CatCliente
(Id_Cliente, nombre_Cliente, País, Ciudad)
SELECT CustomerID, CompanyName, Country, City
FROM NORTHWND.dbo.Customers

SELECT *
FROM CatCliente

CREATE TABLE TblVenta (
	Id_Venta INT IDENTITY PRIMARY KEY,
	Fecha DATE DEFAULT GETDATE(),
	Id_Cliente NVARCHAR(5)
	CONSTRAINT fk_tblventa_catcliente
	FOREIGN KEY (Id_Cliente)
	REFERENCES CatCliente(Id_Cliente)
)
GO

CREATE TABLE TblDetalleVenta (
	Id_Venta INT,
	Id_Producto INT,
	Precio_venta MONEY,
	Cantidad_vendida INT
	PRIMARY KEY (Id_Venta, Id_Producto)
	CONSTRAINT fk_tbldetalleventa_tblventa
	FOREIGN KEY (Id_Venta)
	REFERENCES TblVenta (Id_Venta),
	CONSTRAINT fk_tbldetalleventa_catproducto
	FOREIGN KEY (Id_Producto)
	REFERENCES CatProducto (Id_Producto)
)
GO

CREATE OR ALTER PROC usp_agregar_venta
@id_cliente NVARCHAR(5),
@id_producto INT,
@cantidad_vendida INT
AS
BEGIN
	BEGIN TRY
	BEGIN TRANSACTION
		IF EXISTS 
			(SELECT 1 
			FROM CatCliente
			WHERE Id_Cliente = @id_cliente)
			BEGIN
				IF EXISTS
					(SELECT 1
					FROM CatProducto
					WHERE Id_Producto = @id_producto)
					BEGIN
						IF @cantidad_vendida <= (SELECT Existencia FROM CatProducto WHERE Id_Producto = @id_producto)
							BEGIN
									INSERT INTO TblVenta (Id_Cliente)
										VALUES (@id_cliente)
									INSERT INTO TblDetalleVenta
										VALUES 
											(SCOPE_IDENTITY(),
											@id_producto,
											(SELECT Precio FROM CatProducto WHERE Id_Producto = @id_producto),
											@cantidad_vendida
											)
									UPDATE CatProducto
										SET Existencia = Existencia - @cantidad_vendida
										WHERE Id_Producto = @id_producto
								COMMIT;
							END
						ELSE
						BEGIN
						;THROW 50001, 'LA CANTIDAD VENDIDA SUPERA AL STOCK. ', 1;
						END
					END
				ELSE
				BEGIN
					;THROW 50002, 'ERROR: EL PRODUCTO NO EXISTE. ', 1;
				END
			END
		ELSE
		BEGIN
			;THROW 50003, 'ERROR: EL CLIENTE NO EXISTE. ', 1;
		END
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK;
				PRINT 'TRANSACCIÓN NO LOGRADA. ' + ERROR_MESSAGE();
			END
	END CATCH
END;

EXEC usp_agregar_venta 'ALFKI', 1, 1

SELECT *
FROM CatCliente

SELECT *
FROM CatProducto

SELECT *
FROM TblDetalleVenta

SELECT *
FROM TblVenta
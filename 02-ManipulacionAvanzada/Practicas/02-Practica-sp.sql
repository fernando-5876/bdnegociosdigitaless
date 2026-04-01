CREATE TYPE dbo.ListaProductos AS TABLE
(
    ProductoID INT,
    Cantidad INT
);
GO

CREATE OR ALTER PROC usp_agregar_venta_masiva
@id_cliente NVARCHAR(5),
@Lista dbo.ListaProductos READONLY
AS
BEGIN
	BEGIN TRY
	BEGIN TRANSACTION
		IF EXISTS 
			(SELECT 1 
			FROM CatCliente
			WHERE Id_Cliente = @id_cliente)
			BEGIN
                -- Para verificar una LISTA entera, usamos NOT EXISTS (que no haya nulos al cruzar)
				IF NOT EXISTS
					(SELECT 1
					FROM @Lista L
                    LEFT JOIN CatProducto P ON L.Id_Producto = P.Id_Producto
					WHERE P.Id_Producto IS NULL)
					BEGIN
                        -- Verificamos que NINGÚN producto de la lista supere su stock
						IF NOT EXISTS 
                            (SELECT 1 
                            FROM @Lista L 
                            INNER JOIN CatProducto P ON L.Id_Producto = P.Id_Producto 
                            WHERE L.Cantidad > P.Existencia)
							BEGIN
									INSERT INTO TblVenta (Id_Cliente)
										VALUES (@id_cliente)
                                    
                                    -- Insertamos todos los detalles masivamente obteniendo el precio del catálogo
									INSERT INTO TblDetalleVenta
										SELECT 
											SCOPE_IDENTITY(),
											L.Id_Producto,
											P.Precio,
											L.Cantidad
                                        FROM @Lista L
                                        INNER JOIN CatProducto P ON L.Id_Producto = P.Id_Producto
                                    
                                    -- Actualizamos el inventario de golpe
									UPDATE P
										SET P.Existencia = P.Existencia - L.Cantidad
                                        FROM CatProducto P
										INNER JOIN @Lista L ON P.Id_Producto = L.Id_Producto

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

DECLARE @MiListaVenta dbo.ListaProductos;

INSERT INTO @MiListaVenta (Id_Producto, Cantidad)
VALUES 
    (1, 1), 
    (2, 1), 
    (3, 1);

EXEC usp_agregar_venta_masiva 
    @id_cliente = 'ALFKI', 
    @Lista = @MiListaVenta;

SELECT *
FROM CatProducto

SELECT *
FROM TblVenta

SELECT *
FROM TblDetalleVenta
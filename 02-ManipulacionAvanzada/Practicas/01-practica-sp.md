# **Documentación de Solución: Base de Datos bdpracticas**
Este documento explica el proceso de como se llevo a cabo la solución al problema dado (creación de la base de datos, creación de tablas y la creación del store con sus respectivas validaciones).

**1. Configuración del Entorno**
Se inició con la creación de la base de datos y su ocupación.

```sql
CREATE DATABASE bdpracticas;
GO
USE bdpracticas;
GO
```

**2. Definición de Estructura y Migración**
Se diseñaron las tablas importando datos existentes de NORTHWND.

*Tablas de Catálogo (Migración)*

**- CatProducto:** Almacena la información de productos. Se utilizó IDENTITY_INSERT para mantener la integridad de los IDs originales de la fuente.

**- CatCliente:** Almacena la información de los clientes provenientes de Northwind.

*Tablas de Transacciones (Operativas)*

**TblVenta:** Registra la cabecera de la venta con la fecha automática (GETDATE()).

**TblDetalleVenta:** Tabla intermedia que gestiona la relación de productos por venta, utilizando una Llave Primaria Compuesta (Id_Venta, Id_Producto).

Una vez terminadas las tablas, así es como quedaría el diagrama con sus respectivas relaciones y cardinalidades:

![Imagen.](/Img/Captura%20de%20pantalla%202026-03-26%20154231.png "Imagen del Diagrama de Flujo de la BD.")

**3. Lógica de Negocio: Store Procedure**
Se implementó el procedimiento almacenado **usp_agregar_venta**, el cual sigue la lógica de validación y registro de ventas.

*Características del Procedimiento:*

**- Manejo de Excepciones:** Uso de bloques TRY...CATCH para capturar errores en tiempo de ejecución.

**- Control de Transacciones:** Implementación de BEGIN TRANSACTION, COMMIT y ROLLBACK para asegurar que, si un paso falla, nada se guarda.

*Validaciones Integradas:*

**- Existencia del Cliente:** Verifica que el Id_Cliente sea válido.

```sql
IF EXISTS 
	(SELECT 1 
	FROM CatCliente
	WHERE Id_Cliente = @id_cliente)
	BEGIN
```

**- Existencia del Producto:** Verifica que el Id_Producto exista en el catálogo.

```sql
IF EXISTS
	(SELECT 1
	FROM CatProducto
	WHERE Id_Producto = @id_producto)
	BEGIN
```

**- Validación de Stock:** Compara la cantidad_vendida contra la Existencia actual.

```sql
IF @cantidad_vendida <= (SELECT Existencia FROM CatProducto WHERE Id_Producto = @id_producto)
	BEGIN
```

*Flujo de Actualización:*

Si todas las validaciones son exitosas, el procedimiento realiza:

- INSERT en TblVenta.

```sql
INSERT INTO TblVenta (Id_Cliente)
	VALUES (@id_cliente)
```

- INSERT en TblDetalleVenta recuperando el precio vigente de CatProducto.

```sql
INSERT INTO TblDetalleVenta
	VALUES 
		(SCOPE_IDENTITY(),
		@id_producto,
		(SELECT Precio FROM CatProducto WHERE Id_Producto = @id_producto),
		@cantidad_vendida
		)
		UPDATE TblDetalleVenta
		SET Precio_venta = Precio_venta * @cantidad_vendida
		WHERE Id_Producto = @id_producto
```

- UPDATE al stock de CatProducto (Existencia anterior - Cantidad vendida).

```sql
UPDATE CatProducto
	SET Existencia = Existencia - @cantidad_vendida
	WHERE Id_Producto = @id_producto
```

**4. Pruebas de Ejecución**
Para verificar el funcionamiento, se ejecutó un caso de prueba con un cliente y producto existente:

```sql
EXEC usp_agregar_venta 'ALFKI', 1, 10
```
*Verificación de Resultados:*
Se consultaron las tablas finales para asegurar la consistencia de los datos:

- SELECT * FROM TblVenta: Verifica la creación del folio.

- SELECT * FROM TblDetalleVenta: Verifica el registro del artículo y precio.

- SELECT * FROM CatProducto: Verifica que el stock disminuyó correctamente.

**4. GitHub:**
Una vez validado el funcionamiento del script, se procedió a realizar el respaldo del código en el repositorio.

**- Registro de Cambios.**
Se guardaron los cambios localmente con el mensaje "Practica venta con Store Procedure".

```bash
git add .
git commit -m "Practica venta con Store Procedure"
```

**- Integración.**
Se realizó la integración de la rama de desarrollo hacia la rama principal.

```bash
git checkout main
git merge practica-sp
```

**- Publicación.**
Finalmente, se subieron los cambios al repositorio remoto en GitHub.

```bash
git push origin main
```
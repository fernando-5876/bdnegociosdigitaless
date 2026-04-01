# **Documentación de Solución: Base de Datos bdpracticas (Venta Masiva)**
Este documento explica el proceso de cómo se llevó a cabo la solución para el procesamiento de múltiples productos en una sola transacción, incluyendo la creación de tipos de datos de usuario, y la creación del store procedure con sus respectivas validaciones en bloque.

**1. Configuración del Entorno y Tipos de Datos**

Para permitir que el procedimiento almacenado reciba múltiples productos a la vez, se creó un tipo de tabla personalizado (Table-Valued Parameter).

```sql
CREATE TYPE dbo.ListaProductos AS TABLE
(
    Id_Producto INT, 
    Cantidad INT
);
GO
```

**2. Lógica de Negocio: Store Procedure**

Se implementó el procedimiento almacenado usp_agregar_venta_masiva, el cual sigue la lógica de validación y registro de ventas evaluando conjuntos de datos (Listas) en lugar de valores individuales.

*Características del Procedimiento:*

- Manejo de Excepciones: Uso de bloques TRY...CATCH para capturar errores en tiempo de ejecución de SQL.
- Control de Transacciones: Implementación de BEGIN TRANSACTION, COMMIT y ROLLBACK absoluto para asegurar la atomicidad (se venden todos los productos de la lista, o no se vende ninguno).

*Validaciones Integradas:*

- Existencia del Cliente: Verifica que el Id_Cliente sea válido en el catálogo.

```sql
IF EXISTS 
    (SELECT 1 
    FROM CatCliente
    WHERE Id_Cliente = @id_cliente)
    BEGIN
```

- Existencia de todos los Productos: Cruza la lista entrante contra el catálogo usando un LEFT JOIN. Si algún producto no existe (es NULL en el catálogo), se bloquea la operación.

```sql
IF NOT EXISTS
    (SELECT 1
    FROM @Lista L
    LEFT JOIN CatProducto P ON L.Id_Producto = P.Id_Producto
    WHERE P.Id_Producto IS NULL)
    BEGIN
```

- Validación de Stock Masivo: Compara las cantidades solicitadas en la lista contra las existencias reales. Si al menos un registro supera el stock, se aborta la venta completa.

```sql
IF NOT EXISTS 
    (SELECT 1 
    FROM @Lista L 
    INNER JOIN CatProducto P ON L.Id_Producto = P.Id_Producto 
    WHERE L.Cantidad > P.Existencia)
    BEGIN
```

*Flujo de Actualización:*

Si todas las validaciones pasan limpiamente, el procedimiento realiza:

- INSERT en TblVenta (Creación de la cabecera).

```sql
INSERT INTO TblVenta (Id_Cliente)
    VALUES (@id_cliente)
```

- INSERT masivo en TblDetalleVenta, obteniendo el ID de la cabecera recién creada (SCOPE_IDENTITY()) y extrayendo los precios vigentes mediante un INNER JOIN con el catálogo.

```sql
INSERT INTO TblDetalleVenta
    SELECT 
        SCOPE_IDENTITY(),
        L.Id_Producto,
        P.Precio,
        L.Cantidad
    FROM @Lista L
    INNER JOIN CatProducto P ON L.Id_Producto = P.Id_Producto
```

- UPDATE al stock de CatProducto, descontando todas las cantidades de la lista en una sola operación cruzada.

```sql
UPDATE P
    SET P.Existencia = P.Existencia - L.Cantidad
    FROM CatProducto P
    INNER JOIN @Lista L ON P.Id_Producto = L.Id_Producto
```

**3. Pruebas de Ejecución**

Para verificar el funcionamiento masivo, se declara la variable tipo tabla, se llena con los productos deseados y se ejecuta el procedimiento:

```sql
DECLARE @MiListaVenta dbo.ListaProductos;

INSERT INTO @MiListaVenta (Id_Producto, Cantidad)
VALUES 
    (1, 1), 
    (2, 1), 
    (3, 1);

EXEC usp_agregar_venta_masiva 
    @id_cliente = 'ALFKI', 
    @Lista = @MiListaVenta;
```

*Verificación de Resultados:*
Se consultan las tablas finales para validar que la transacción en bloque se aplicó correctamente:

```sql
-- Verifica que el stock disminuyó correctamente para todos los productos de la lista
SELECT * FROM CatProducto;

-- Verifica la creación de un único folio para toda la operación
SELECT * FROM TblVenta;

-- Verifica el registro de los múltiples artículos ligados a ese mismo folio con sus precios exactos
SELECT * FROM TblDetalleVenta;
```

**4. GitHub:**
Una vez validado el funcionamiento del script, se procedió a realizar el respaldo del código en el repositorio.

**- Registro de Cambios.**
Se guardaron los cambios localmente con el mensaje "Practica venta con Store Procedure".

```bash
git add .
git commit -m "Practica venta masiva con Store Procedure"
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
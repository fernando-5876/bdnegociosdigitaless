#Stored Procedures (Procedimientos Almacenados) en Transact-SQL (SQL SERVER)

Fundamentos

- ¿Qué es un Stored Procedure?

Un **Stored Procedure (SP)** es un bloque de código SQL guardado dentro de la base de datos que puede ejecutarse cuando se necesite. Es decir, es un **OBJETO DE LA BASE DE DATOS**.

Es algo similar a una función o método en programación.

Ventajas

1. Reutilizar el código.
2. Mejor rendimiento.
3. Mayor seguridad.
4. Centralización de lógica de negocio.
5. Menos tráfico entre aplicación y servidor.

- Sintáxis

![SintaxisSQL](../../Img/sp_sintaxis.png)

- Nomenclatura Recomendada

```
spu_<Entidad>_<Acción>
```

| Parte   | Significado                     | Ejemplo |
|--------|---------------------------------|--------|
| spu    | Stored Procedure User           | spu_   |
| Entidad| Tabla o concepto del negocio    | Cliente|
| Acción | Lo que hace                     | Insert |

- Acciones Estándar

Estas son las **Acciones más usadas** en sistemas empresariales

| Acción     | Significado          | Ejemplo                |
| ---------- | -------------------- | ---------------------- |
| Insert     | Insertar registro    | spu_Cliente_Insert     |
| Update     | Actualizar           | spu_Cliente_Update     |
| Delete     | Eliminar             | spu_Cliente_Delete     |
| Get        | Obtener uno          | spu_Cliente_Get        |
| List       | Obtener varios       | spu_Cliente_List       |
| Search     | Búsqueda con filtros | spu_Cliente_Search     |
| Exists     | Validar si existe    | spu_Cliente_Exists     |
| Activate   | Activar registro     | spu_Cliente_Activate   |
| Deactivate | Desactivar           | spu_Cliente_Deactivate |

-- Ejemplo completo

Suponer que tenemos una tabla cliente

Insertar Cliente

```
spu_Cliente_Insert
```

Actualizar Cliente

```
spu_Cliente_Update
```

Obtener Cliente por Id

```
spu_Cliente_Get
```

Listar todos los clientes

```
spu_Cliente_List
```

Buscar Cliente

```
spu_Cliente_Search
```

```sql
/* ========================================== Stored Procedures ==========================================*/

CREATE DATABASE bdstored;
GO

USE bdstored;
GO

-- Ejemplo Simple

CREATE PROCEDURE usp_Mensaje_Saludar
-- No tendrá parámetros
AS
BEGIN
    PRINT 'Hola Mundo Transact SQL desde SQL SERVER';
END;
GO

-- Ejecutar

EXECUTE usp_Mensaje_Saludar
GO

CREATE PROCEDURE usp_Mensaje_Saludar2
-- No tendrá parámetros
AS
BEGIN
    PRINT 'Hola Mundo Ing en TI';
END;
GO

-- EJECUTAR
EXEC usp_Mensaje_Saludar2
GO

CREATE OR ALTER PROC usp_Mensaje_Saludar3
-- No tendrá parámetros
AS
BEGIN
    PRINT 'Hola Mundo ENTORNOS VIRTUALES Y NEGOCIOS DIGITALES';
END;
GO

EXEC spu_Mensaje_Saludar3
GO

-- Eliminar un SP
DROP PROC spu_Mensaje_Saludar3
GO

-- Crear un SP que muestre la fecha actual del sistema

CREATE OR ALTER PROC spu_Servidor_FechaActual
AS
BEGIN
    SELECT CAST(GETDATE () AS DATE) AS [ FECHA DEL SISTEMA ]
END;
GO

-- EJECUTAR

EXEC spu_Servidor_FechaActual
GO

-- CREAR UN SP QUE MUESTRE EL NOMBRE DE LA BASE DE DATOS (BD_NAME)

CREATE OR ALTER PROC spu_Dbname_Get
AS
BEGIN
    SELECT
        HOST_NAME() AS [MACHINE],
        SUSER_NAME() AS [SQLUSER],
        SYSTEM_USER AS [SYSTEMUSER],
        DB_NAME() AS [DATABASE NAME],
        APP_NAME() AS [APPLICATION];
END;
GO

EXEC spu_Dbname_Get
GO
```

Parámetros en Stored Procedures

Los parámetros permiten enviar datos

```sql
/* ========================================== Stored Procedures con Parámetros ==========================================*/

CREATE OR ALTER PROC usp_Persona_Saludar
    @nombre VARCHAR(50)  -- PARÁMETRO DE ENTRADA
AS
BEGIN
    PRINT 'Hola ' + @nombre;
END;
GO

EXEC usp_Persona_Saludar 'Israel';
EXEC usp_Persona_Saludar 'Artemio';
EXEC usp_Persona_Saludar 'Iraís';
EXEC usp_Persona_Saludar @nombre = 'Bryan';

DECLARE @name VARCHAR(50);
SET @name = 'Yael';

EXEC usp_Persona_Saludar @name
```

```sql
/*TO DO: EJEMPLOS CON CONSULTAS, VAMOS A CREAR UNA TABLA DE CLIENTES BASADA EN LA TABLA DE CUSTOMERS
DE NORTHWIND*/

select CustomerID,  CompanyName
    into Customers
    from NORTHWND.dbo.Customers;
    
    select *
    from Customers;
    
    ---crear un sp que busque un cliente en espesifico
    create or alter proc spu_Customer_buscar
    @id nchar(10)
    as 
    begin 
    set @id = trim(@id);
      
        if not len(@id)<=0 and len(@id)>5
    begin 
         print ('el rango debe de estar de 1 a 5 de tamaño')
           return;
           end

           if NOT EXISTS(select 1 from Customers where CustomerID = @id)
           begin
           print 'El cliente no existe en la bese de datos';
           return;
           end

    select CustomerID as [Numero], CompanyName as [Cliente]
    from Customers
    where CustomerID = @id;
    end;
    go
    
    select *
    from Customers
    where CustomerID = '';



    execute spu_Customer_buscar 'Antoni';
    

    select *
    from NORTHWND.dbo.Categories
    where not exists(
    select 1
    from Customers
    where CustomerID = 'Antoni');
    GO

   

   ------------todo: Parametros de salidad crear un sp 
   --que reciba un número y que verifique que no sea negativo. si es negativo 
   --imprimir valor no valido y si no multiplicarlo por 5 y mostrarlo , para mostrar usar un select

   ---crear un sp

   CREATE OR ALTER PROCEDURE usp_numero_multiplicar
   @number INT
   AS
   BEGIN
    IF @number<=0
    BEGIN
        PRINT 'El número no puede ser negativo ni 0'
        RETURN;
    END
    SELECT (@number * 5) AS [OPERACIÓN]
   END;

   EXEC usp_numero_multiplicar -34;
   EXEC usp_numero_multiplicar 0;
   EXEC usp_numero_multiplicar 5;
   GO

-- ejercicio 2: Crear un sp que reciba un nombre y lo imprima en mayúsculas

CREATE OR ALTER PROC usp_nombre_mayusculas
   @name VARCHAR(15)
   AS
   BEGIN
    SELECT UPPER(@name) AS [NAME]
END;

EXEC usp_nombre_mayusculas 'Monico'
```

Parámetros de Salida

Los parámetros OUTPUT devuelven valores al Usuario

```sql
/* ========================================== PARAMETROS DE SALIDA ==========================================*/

CREATE OR ALTER PROC spu_numeros_sumar
@a INT,
@b INT,
@resultado INT OUTPUT
AS
BEGIN
    SET @resultado = @a + @b
END;
GO

DECLARE @res INT
EXEC spu_numeros_sumar 5,7,@res OUTPUT;
SELECT @res AS [Resultado];
GO

CREATE OR ALTER PROC spu_numeros_sumar2
@a INT,
@b INT,
@resultado INT OUTPUT
AS
BEGIN
    SELECT @resultado = @a + @b
END;
GO

DECLARE @res INT
EXEC spu_numeros_sumar2 5,7,@res OUTPUT;
SELECT @res AS [Resultado];
GO

-- CREAR UN SP QUE DEVUELVA EL AREA DE UN CIRCULO

CREATE OR ALTER PROC usp_area_circulo
@radio DECIMAL(10,2),
@area DECIMAL(10,2) OUTPUT
AS
BEGIN
    -- SET @area = PI() * (@radio * @radio)
    SET @area = PI() * POWER(@radio,2);
END;
GO

DECLARE @r DECIMAL(10,2)
EXEC usp_area_circulo 2.4, @r OUTPUT;
SELECT @r AS [Area del Circulo];
GO

-- Crear un sp que reciba un idcliente y devuelva el nombre

CREATE OR ALTER PROC spu_cliente_obtener
 @id NCHAR(10),
 @name NVARCHAR(40) OUTPUT
AS
BEGIN
    IF LEN(@id) > 5
    BEGIN
     IF EXISTS (SELECT 1 FROM CUSTOMERS WHERE CustomerID = @id)
     BEGIN
        SELECT @name = CompanyName
        FROM Customers
        WHERE CustomerID = @id;
        RETURN;
     END
     PRINT 'El Customer no existe';
     RETURN;
    END
     PRINT 'El ID debe ser de tamaño 5';
END;
GO

DECLARE @name NVARCHAR(40)
EXEC spu_cliente_obtener 'ANTON', @name OUTPUT
SELECT @name AS [Nombre del cliente];
GO
```

CASE

Sirve para evaluzar condiciones como un switch o un if multiple

```sql
CREATE OR ALTER VIEW vw_buena
AS
SELECT 
    UPPER(C.CompanyName) AS [CompanyName],
    UPPER(C.Country) AS [Country],
    UPPER(C.City) AS [City],
    UPPER(ISNULL(C.Region, 'Sin Región')) AS [RegiónLimpia],
    UPPER(CONCAT(E.FirstName, ' ', E.LastName)) AS [FullName],
    ROUND(SUM(OD.Quantity * OD.UnitPrice), 2) AS [Total],
    CASE
        WHEN SUM(OD.Quantity * OD.UnitPrice) >= 30000 AND SUM(OD.Quantity * OD.UnitPrice) <= 60000 THEN 'GOLD'
        WHEN SUM(OD.Quantity * OD.UnitPrice) >= 10000 AND SUM(OD.Quantity * OD.UnitPrice) < 30000 THEN 'SILVER'
        ELSE 'BRONZE'
    END AS [Membresia]
FROM NORTHWND.dbo.Customers AS C
INNER JOIN NORTHWND.dbo.Orders AS O
ON C.CustomerID = O.CustomerID
INNER JOIN NORTHWND.dbo.[Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN NORTHWND.dbo.Employees AS E
ON E.EmployeeID = O.EmployeeID
GROUP BY C.CompanyName, C.Country, C.City, C.Region, CONCAT(E.FirstName, ' ', E.LastName)
GO

CREATE OR ALTER PROC spu_informe_clientes_empleados
@nombre VARCHAR(50),
@region VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM vw_buena
    WHERE FullName = @nombre
    AND RegiónLimpia = @region;
END;

EXEC spu_informe_clientes_empleados 'Andrew Fuller', 'Sin Región'

SELECT 
    UPPER(C.CompanyName) AS [CompanyName],
    UPPER(C.Country) AS [Country],
    UPPER(C.City) AS [City],
    UPPER(ISNULL(C.Region, 'Sin Región')) AS [RegiónLimpia],
    UPPER(CONCAT(E.FirstName, ' ', E.LastName)) AS [FullName],
    ROUND(SUM(OD.Quantity * OD.UnitPrice), 2) AS [Total],
    CASE
        WHEN SUM(OD.Quantity * OD.UnitPrice) >= 30000 AND SUM(OD.Quantity * OD.UnitPrice) <= 60000 THEN 'GOLD'
        WHEN SUM(OD.Quantity * OD.UnitPrice) >= 10000 AND SUM(OD.Quantity * OD.UnitPrice) < 30000 THEN 'SILVER'
        ELSE 'BRONZE'
    END AS [Membresia]
FROM NORTHWND.dbo.Customers AS C
INNER JOIN NORTHWND.dbo.Orders AS O
ON C.CustomerID = O.CustomerID
INNER JOIN NORTHWND.dbo.[Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN NORTHWND.dbo.Employees AS E
ON E.EmployeeID = O.EmployeeID
WHERE CONCAT(E.FirstName, ' ', E.LastName) = UPPER('Andrew Fuller') AND UPPER(ISNULL(C.Region, 'Sin Región')) = UPPER('Sin Region')
GROUP BY C.CompanyName, C.Country, C.City, C.Region, CONCAT(E.FirstName, ' ', E.LastName)
ORDER BY FullName ASC, [Total] DESC
```

Try ... Catch

Manejo de Errores o excepciones en tiempo de ejecución y manejar lo que sucede cuando ocurren.

SINTAXIS

```sql
    BEGIN TRY
    -- Código que puede generar un error
    END TRY
    BEGIN CATCH
    -- Código que se ejecuta si ocurre un error
    END CATCH
```

- ¿ Cómo funciona ?

1. SQL ejecuta todo lo que está dentro del TRY.
2. Si ocurre un error:
- Se detiene la ejecución del TRY
- Salta automáticamente al CATCH
3. En el CATCH se puede:
- Mostrar mensajes
- Registrar errores
- Revertir transacciones

**OBTENER INFORMACION DEL ERROR**

Dentro del CATCH, SQL SERVER tiene funciones especiales:
| Función | Descripción |
| :--- | :--- |
| ERROR_MESSAGE() | Manda el mensaje de Error |
| EEROR_NUMBER() | Número de Error |
| EEROR_LINE() | Línea donde ocurrió |
| EEROR_PROCEDURE() | Procedimiento |
| EEROR_SEVERITY() | Nivel de Gravedad |
| EEROR_STATE() | Estado del Error |

```sql
/* ========================================== MANEJO DE ERRORES CON TRY ... CATCH ==========================================*/

-- SIN TRY - CATCH
SELECT 10/0;

-- CON TRY - CATCH
BEGIN TRY
    SELECT 10/0;
END TRY
BEGIN CATCH
    PRINT 'OCURRIÓ UN ERROR';
END CATCH;
GO

-- EJEMPLO DE USO DE FUNCIONES PARA OBTENER INFORMACIÓN DEL ERROR

BEGIN TRY
 SELECT 10/0;
END TRY
BEGIN CATCH
 PRINT 'Mensaje: ' + ERROR_MESSAGE();
 PRINT 'No. de Error: ' + CAST(ERROR_NUMBER() AS VARCHAR);
 PRINT 'Línea del Error: ' + CAST(ERROR_LINE() AS VARCHAR);
 PRINT 'Estado del Error:'+ CAST(ERROR_STATE() AS VARCHAR);
END CATCH;

CREATE TABLE clientes(
    Id INT PRIMARY KEY,
    Nombre VARCHAR(35)
);
GO

INSERT INTO clientes
VALUES
(1, 'PANFILO');
GO

BEGIN TRY
    INSERT INTO clientes
    VALUES (1, 'EUSTACIO');
END TRY
BEGIN CATCH
    PRINT 'ERROR AL ISNERTAR: ' + ERROR_MESSAGE();
    PRINT ' ERROR EN LA LINEA:' + CAST(ERROR_LINE() AS VARCHAR);
END CATCH
GO

BEGIN TRANSACTION;

INSERT INTO clientes
VALUES (2, 'AMERICO ANGEL');

SELECT *
FROM clientes

COMMIT;
ROLLBACK;

-- Ejemplo de uso de transacciones junto con el TRY ... CATCH

BEGIN TRY
    BEGIN TRANSACTION
    INSERT INTO clientes 
    VALUES (3, 'VALDERABANO');
    INSERT INTO clientes
    VALUES (4, 'ROLES ALINA');
    COMMIT;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 1
    BEGIN
        ROLLBACK;
    END
   PRINT 'Se hizo Rollback por error.'
   PRINT 'ERROR: ' + ERROR_MESSAGE();
END CATCH
GO

-- CREAR UN STORE PROCEDURE QUE INSERTE UN CLIENTE, CON LAS VALIDACIONES
-- NECESARIAS.

CREATE OR ALTER PROC usp_insertar_cliente
    @id INT,
    @nombre VARCHAR(35)
AS 
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        INSERT INTO clientes 
        VALUES (@id, @nombre);
        COMMIT;
        PRINT 'CLIENTE INSERTADO'
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 1
            BEGIN
                ROLLBACK;
            END
            PRINT 'ERROR: ' + ERROR_MESSAGE();
    END CATCH
END;

SELECT *
FROM clientes

UPDATE clientes 
SET Nombre = 'AMERICO AZUL'
WHERE Id = 10;

IF @@ROWCOUNT < 1
BEGIN
    PRINT @@ROWCOUNT;
    PRINT 'NO EXISTE EL CLIENTE'
END
ELSE
    PRINT 'CLIENTE ACTUALIZADO'

CREATE TABLE teams
(
    id INT NOT NULL IDENTITY PRIMARY KEY,
    nombre NVARCHAR(15)
);

INSERT INTO teams (nombre)
VALUES ('CHAFA AZUL');

-- FORMA 1 DE OBTENER UN IDENTITY INSERTADO
DECLARE @id_insertado INT
SET @id_insertado = @@IDENTITY
PRINT 'ID INSERTADO: ' + CAST(@id_insertado AS VARCHAR);
SELECT @id_insertado = @@IDENTITY 
PRINT 'ID INSERTADO FORMA 2: ' + CAST(@id_insertado AS VARCHAR)

INSERT INTO teams (nombre)
VALUES ('ÁGUILAS');

-- FORMA 2 DE OBTENER UN IDENTITY INSERTADO
DECLARE @id_insertado2 INT
SET @id_insertado2 = SCOPE_IDENTITY();
PRINT 'ID INSERTADO: ' + CAST(@id_insertado2 AS VARCHAR);
SELECT @id_insertado2 = SCOPE_IDENTITY(); 
PRINT 'ID INSERTADO FORMA 2: ' + CAST(@id_insertado2 AS VARCHAR)

SELECT *
FROM teams
```
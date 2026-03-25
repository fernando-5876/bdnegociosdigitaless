# Lenguaje Transact-SQL (MSServer)

## 😊 Fundamentos Programables

1. ¿Qué es la parte programable de T-SQL?

Es todo lo que permite:

- Usar variables.
- Controlar el flujo (while, if/else).
- Crear Procedimientos Almacenados (Stored Procedures).
- Disparadores (Triggers).
- Manejar errores.
- Crear Funciones.
- Usar Transacciones.

Es convertir SQL en un lenguaje casi C/Java pero dentro del motor de base de datos.

2. Variables 🪄

📌 Una variable almacena un valor temporal

```sql
DECLARE @edad INT;
SET @edad = 21;

PRINT @edad;
SELECT @edad AS [EDAD];

DECLARE @nombre AS VARCHAR(30) = 'San Gallardo';
SELECT @nombre AS [Nombre];
SET @nombre = 'San Adonai';
SELECT @nombre AS [Nombre];

/* ========================================== Ejercicios ==========================================*/

/*
Ejercicio 1. 

- Declarar una variable que se llame @precio
- Asignen el valor 150
- Calcular el IVA al 16%
- Mostrar el total
*/

DECLARE @precio AS MONEY = 150;
DECLARE @IVA INT;
DECLARE @total INT
SET @IVA = @precio * .16;
SET @total = @precio + @IVA;
SELECT @total AS [TOTAL];

DECLARE @precioo MONEY = 150;
DECLARE @IVAA DECIMAL(10,2);
DECLARE @totall MONEY;
SET @IVAA = @precioo * 0.16;
SET @totall = @precioo + @IVAA
SELECT @precioo AS [PRECIO], CONCAT('$', @IVAA) AS [IVA(16%)], @totall AS [TOTAL]
```

IF/ELSE

📌 Definición

Permite ejecutar código según condición

```sql
DECLARE @calificacion DECIMAL(10, 2) = 9.5
IF @calificacion >= 0 AND @calificacion <= 10
BEGIN
	IF @calificacion >= 7.0
	BEGIN
		PRINT ('Aprobado');
	END
	ELSE
	BEGIN
		PRINT ('Reprobado');
	END
END
ELSE
BEGIN
	SELECT CONCAT(@calificacion, 'Esta fuera de Rango') AS [RESPUESTA];
END
```

WHILE (Ciclos)

```sql
DECLARE @limite INT = 5;
DECLARE @i INT = 1;
WHILE (@i<=@limite)
BEGIN
	PRINT CONCAT('Numero: ', @i)
	SET @i = @i + 1
END
```
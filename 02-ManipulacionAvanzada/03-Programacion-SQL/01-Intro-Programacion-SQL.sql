/* ========================================== Variables en Transact-SQL ==========================================*/

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

/* ========================================== IF/ELSE ==========================================*/

DECLARE @edadd INT = 18;

IF NOT @edadd >= 18
PRINT 'Eres mayor de edad.';
ELSE 
PRINT 'Eres menor de edad.';

-- Dar una calificacion y si es mayor a 7 aprobado, pero sino reprobado, no puede ser negativo ni mayor a 10

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

/* ========================================== WHILE ==========================================*/

DECLARE @limite INT = 5;
DECLARE @i INT = 1;
WHILE (@i<=@limite)
BEGIN
	PRINT CONCAT('Numero: ', @i)
	SET @i = @i + 1
END
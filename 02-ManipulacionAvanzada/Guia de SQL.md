# Guía de Referencia SQL - Análisis de Comandos

Este documento recopila y organiza los comandos SQL utilizados, abarcando desde la definición de datos (DDL) hasta consultas avanzadas con agrupación (DQL).

## 1. Lenguaje de Definición de Datos (DDL)
Comandos para definir y modificar la estructura de la base de datos.

### CREATE DATABASE
Crea una nueva base de datos vacía.
```sql
CREATE DATABASE Tienda;
```

### USE
Selecciona la base de datos sobre la cual se ejecutarán las consultas siguientes.

```
USE Tienda;
```
### CREATE TABLE
Define una nueva tabla, sus columnas y tipos de datos.

Nota: En los ejemplos se usaron tipos como INT, NVARCHAR, MONEY, DATE y la propiedad IDENTITY(1,1) para autoincremento.

```
CREATE TABLE cliente (
    id INT NOT NULL,
    nombre NVARCHAR(30) NOT NULL,
    limitecredito MONEY NOT NULL DEFAULT 500.0
);
```

### ALTER TABLE
Modifica la estructura de una tabla existente (ej. agregar/quitar restricciones o cambiar columnas).

```
ALTER TABLE products
ALTER COLUMN supplier_id INT NULL;
```

### DROP TABLE
Elimina una tabla completa y sus datos de la base de datos.

```
DROP TABLE products;
```

## 2. Restricciones (Constraints)
Reglas aplicadas a las columnas para garantizar la integridad de los datos.

### PRIMARY KEY
Identifica de forma única cada registro en una tabla.

```
CONSTRAINT pk_Clientes_2 PRIMARY KEY (cliente_id)
```

### FOREIGN KEY
Crea una relación con otra tabla. Define acciones de integridad referencial (ON DELETE/UPDATE).

```
CONSTRAINT fk_products_suppliers
FOREIGN KEY (supplier_id) REFERENCES suppliers (supplier_id)
ON DELETE SET NULL
ON UPDATE SET NULL
```

### UNIQUE
Asegura que todos los valores en una columna sean diferentes.

```
CONSTRAINT unique_name UNIQUE ([name])
```

### CHECK
Asegura que los valores en una columna cumplan una condición específica.

```
CONSTRAINT chk_credit_limit CHECK (credit_limit > 0.0 AND credit_limit <= 50000)
```

### DEFAULT
Establece un valor predeterminado si no se especifica uno al insertar.

```
date_register DATE NOT NULL DEFAULT GETDATE()
```

## 3. Lenguaje de Manipulación de Datos (DML)
Comandos para gestionar los datos dentro de las tablas.

### INSERT INTO
Agrega nuevos registros a una tabla. Puede ser explícito (listando columnas) o implícito.

```
INSERT INTO Clientes (nombre, edad, limite_credito)
VALUES ('Batman', 45, 89000);
```

### UPDATE
Modifica registros existentes que cumplan una condición.

```
UPDATE suppliers
SET supplier_id = 10
WHERE supplier_id = 2;
```

### DELETE
Elimina registros existentes que cumplan una condición.

```
DELETE FROM products
WHERE supplier_id = 1;
```

## 4. Consultas Básicas (DQL)
Comandos para recuperar información.

### SELECT ... FROM
La estructura base para obtener datos.

```
SELECT * FROM Categories;
```

### Alias (AS)
Renombra columnas o tablas temporalmente para mejorar la legibilidad.

```
SELECT ProductID AS [NUMERO DE PRODUCTO] FROM Products;
```

### DISTINCT
Devuelve solo valores únicos (elimina duplicados).

```
SELECT DISTINCT Country FROM Customers;
```

### Campos Calculados
Realiza operaciones aritméticas directamente en la proyección SELECT.

```
SELECT (UnitPrice * Quantity) AS IMPORTE FROM [Order Details];
```

## 5. Filtrado y Búsqueda (WHERE)
Operadores para restringir los resultados de una consulta.

### Operadores Relacionales
Comparaciones básicas: >, <, =, !=, <=, >=.

```
SELECT * FROM Products WHERE UnitPrice > 30;
```

### Operadores Lógicos
Combinan condiciones: AND, OR, NOT.

```
SELECT * FROM Products WHERE UnitPrice > 20 AND UnitsInStock < 100;
```

### IS NULL / IS NOT NULL
Verifica si un campo está vacío (nulo).

```
SELECT * FROM Orders WHERE ShipRegion IS NULL;
```

### IN
Verifica si un valor coincide con cualquiera de una lista.

```
SELECT * FROM Customers WHERE Country IN ('Germany', 'France', 'UK');
```

### BETWEEN
Selecciona valores dentro de un rango inclusivo.

```
SELECT * FROM Products WHERE UnitPrice BETWEEN 20 AND 40;
```

### LIKE (Patrones)
Busca patrones en texto usando comodines:

- %: Cualquier cadena de caracteres.

- _: Un solo carácter.

- [ ]: Rango o lista de caracteres.

- [^]: Exclusión de rango o caracteres.

```
-- Empieza con 'a' o 'b'
WHERE CompanyName LIKE '[ab]%';
-- No empieza con 'b', 's' o 'p'
WHERE CompanyName LIKE '[^bsp]%';
```

## 6. Funciones Escalares
Funciones que operan sobre un solo valor o registro.

### Funciones de Fecha
- GETDATE(): Fecha actual del sistema.

- YEAR(), MONTH(), DAY(): Extraen partes de la fecha.

- DATEPART(): Extrae una parte específica (retorna entero).

- DATENAME(): Extrae una parte específica (retorna nombre/texto).

```
SELECT YEAR(OrderDate) AS Año FROM Orders;
```

### Funciones de Texto
- UPPER(): Convierte texto a mayúsculas.

- CONCAT(): Une dos o más cadenas de texto.

```
INSERT INTO suppliers VALUES (UPPER('bimbo')...);
```

### Configuración
SET LANGUAGE: Cambia el idioma de la sesión (afecta nombres de días/meses).

```
SET LANGUAGE SPANISH;
```

## 7. Agregación y Agrupamiento
Análisis de conjuntos de datos.

### Funciones de Agregado
Realizan cálculos sobre un conjunto de valores y devuelven un solo resultado.

- COUNT(*) / COUNT(campo): Cuenta filas.

- SUM(): Suma valores numéricos.

- MAX(): Valor máximo.

- MIN(): Valor mínimo.

- AVG(): Promedio aritmético.

```
SELECT SUM(UnitPrice) FROM Products;
SELECT MAX(OrderDate) FROM Orders;
```

### GROUP BY
Agrupa filas que tienen los mismos valores en las columnas especificadas, usualmente para usar funciones de agregado.

```
SELECT Country, COUNT(CustomerID)
FROM Customers
GROUP BY Country;
```

### HAVING
Filtra grupos después de aplicar GROUP BY (a diferencia de WHERE que filtra filas antes de agrupar).

```
SELECT CustomerID, COUNT(*)
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) > 10;
```

## 8. Consultas Multitabla (Joins)
Combinación de filas de dos o más tablas.

### INNER JOIN
Selecciona registros que tienen valores coincidentes en ambas tablas.

```
SELECT C.CompanyName, COUNT(*)
FROM Orders AS O
INNER JOIN Customers AS C ON O.CustomerID = C.CustomerID
GROUP BY C.CompanyName;
```

### 9. Flujo Lógico de Ejecución
Orden en que el motor de base de datos procesa la consulta (teoría incluida en los scripts):

- FROM: Identifica tablas.

- JOIN: Combina tablas.

- WHERE: Filtra filas base.

- GROUP BY: Agrupa datos.

- HAVING: Filtra los grupos.

- SELECT: Proyecta las columnas.

- DISTINCT: Elimina duplicados.

- ORDER BY: Ordena el resultado final.
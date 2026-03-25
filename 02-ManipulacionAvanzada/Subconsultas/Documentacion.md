# ¿Qué es una subconsulta?

Una subconsulta (subquery) es un select dentro de otro SELECT. Puede devolver:
1. Un solo valor (escalar)
2. Una lista de valores (una columna, varias filas)
3. Una tabla (varias columnas y/o varias filas)
4. Según lo que devuelva se elije el operador correcto (=, IN, EXISTS, etc).

Una subconsulta es una consulta anidada dentro de otra consulta que permite
resolver problemas en varios niveles de información.

```
Dependiendo de donde se coloque y que retorne cambia su comportamiento
```

5 grandes formas de usarlas:

1. Subconsultas escalares.
2. Subconsultas con IN, ANY, ALL.
3. Subconsultas correlacionadas.
4. Subconsultas en SELECT.
5. Subconsultas en FROM (Tablas derivadas).

## Escalares:

Devuelven un único valor, por eso se pueden utilizar con operadores =, >, <.

Ejemplo:
```sql
SELECT *
FROM PEDIDOS
WHERE total = (
    SELECT MAX(total)
    FROM PEDIDOS
)
```

## Subconsultas con IN, ANY, ALL.

Devuelve varios valores con una sola columna (IN)
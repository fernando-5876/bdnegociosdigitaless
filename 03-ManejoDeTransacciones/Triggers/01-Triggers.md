
# Triggers en SQL Server

## 1. ¿Qué es un Trigger?

Un trigger (disparador) es un bloque de código SQL que se ejecuta automáticamente cuando ocurre un evento en una tabla.

Eventos principales:
- Insert
- Delete
- Update

Nota: No se ejecutan manualmente, se activan solos.

## ¿Para qué sirven?

- Validaciones
- Auditoria (Guardar historial)
- Reglas de negocios
- Automatización

## Tipos de Triggers en SQL Server

- AFTER TRIGGER

Se ejecuta después del evento.

- INSTEAD OF TRIGGER

Reemplaza la operación original.

## 4. Sintaxis básica

```sql
    CREATE OR ALTER TRIGGER nombre_trigger
    ON nombre_tabla
    AFTER INSERT
    AS
    BEGIN
    END;
```

## 5. Tablas especiales

| Tabla | Contenido |
| :--- | :--- |
| Inserted | Nuevos Datos |
| Deleted | Datos anteriores |
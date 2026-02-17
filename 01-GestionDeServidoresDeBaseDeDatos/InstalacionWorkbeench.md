# Manual de Instalación, Conexión y Uso: MySQL Workbench + Docker

Este manual te guía paso a paso para instalar la interfaz gráfica (Workbench), levantar tu base de datos en un contenedor Docker y conectarlos para empezar a trabajar con la base de datos **Northwind**.

---

## Fase 1: Instalación de MySQL Workbench
*(Pasos para instalar la herramienta visual)*

1.  **Descarga:**
    * Baja el archivo `mysql-installer-community` (archivo .msi) desde tu unidad.
    ![Descarga desde Drive](/Img/10.jpeg)

    * *Nota:* Si Google Drive advierte "No se ha podido comprobar si tiene virus", selecciona **Descargar de todos modos**.
    ![Advertencia de Virus](/Img/11.jpeg)

2.  **Tipo de Instalación:**
    * Ejecuta el instalador.
    * Elige la opción **Custom** (Personalizada) y da clic en *Next*.
    ![Tipo de instalación Custom](/Img/12.jpeg)

3.  **Selección de Producto:**
    * Navega en el menú: `Applications` > `MySQL Workbench` > `MySQL Workbench 8.0`.
    * Selecciona la versión (ej. 8.0.44) y usa la flecha verde (**Wait Arrow**) para moverlo a la lista derecha ("Products To Be Installed").
    ![Seleccionando Workbench](/Img/13.jpeg)
    ![Producto seleccionado](/Img/14.jpeg)

4.  **Instalar:**
    * Clic en *Next* y luego en **Execute**. Espera a que finalice la instalación.
    ![Progreso de instalación](/Img/15.jpeg)

---

## Fase 2: Desplegar el Servidor en Docker
*(Levantar el contenedor antes de conectar)*

1.  **Comando de Ejecución:**
    Abre tu terminal (Git Bash, PowerShell o CMD) y ejecuta el siguiente comando para crear el contenedor:

    ```bash
    docker run --name mysqlev -p 3341:3306 -v vol-mysqlev:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -d mysql
    ```

    * **Importante:** Se está mapeando el puerto **3341** de tu PC al 3306 del contenedor.
    * **Password:** `123456`.
    ![Comando Docker](/Img/16.jpeg)

2.  **Verificación:**
    * Abre **Docker Desktop**.
    * Ve a la pestaña **Containers**.
    * Verifica que `mysqlev` esté corriendo (círculo verde).
    * Confirma que en "Port(s)" diga: `3341:3306`.
    ![Docker Desktop Containers](/Img/1.jpeg)

---

## Fase 3: Conectar Workbench al Contenedor
*(Configuración de la conexión TCP/IP)*

1.  **Nueva Conexión:**
    * Abre MySQL Workbench.
    * Clic en el ícono **`+`** junto a "MySQL Connections".
    ![Pantalla inicial Workbench](/Img/2.jpeg)

2.  **Configuración de Parámetros:**
    * **Connection Name:** `MysqlEV`
    * **Hostname:** `127.0.0.1` (Localhost)
    * **Port:** `3341` (¡No uses el 3306, usa el que definimos en Docker!)
    * **Username:** `root`
    ![Configurando Puerto 3341](/Img/3.jpeg)

3.  **Autenticación:**
    * Clic en "Store in Vault...".
    * Contraseña: `123456`.
    ![Ingresando Password](/Img/4.jpeg)

4.  **Prueba y Acceso:**
    * Clic en **Test Connection**. Debes ver el mensaje "Successfully made the MySQL connection".
    ![Conexión Exitosa](/Img/5.jpeg)
    * Al abrir la conexión, verás el editor cargando.
    ![Abriendo Editor](/Img/6.jpeg)

---

## Fase 4: Consultas y Pruebas (Queries)
*(Interactuar con la base de datos Northwind)*

1.  **Insertar Datos (Script):**
    * Si tienes un script SQL de carga, pégalo en el editor y ejecútalo (ícono del rayo).
    * Revisa la consola "Action Output" en la parte inferior para confirmar que las filas se insertaron correctamente (palomitas verdes).
    ![Insertar Datos](/Img/7.jpeg)

2.  **Consultas Básicas (SELECT):**
    * Abre una nueva pestaña SQL y prueba lo siguiente:

    **Ver productos:**
    ```sql
    SELECT * FROM Products;
    ```
    ![Query Products](/Img/8.jpeg)

    **Ver órdenes:**
    ```sql
    SELECT * FROM Orders;
    ```
    ![Query Orders](/Img/9.jpeg)
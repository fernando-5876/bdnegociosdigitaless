# Guía de Instalación: SQL Server 2022 & SSMS

Este documento detalla el proceso paso a paso para la descarga, instalación y configuración de **Microsoft SQL Server 2022 (Developer Edition)** y **SQL Server Management Studio (SSMS)**.

## 1. Descarga del Instalador y Medios

**Paso 1:** Ejecutar el instalador inicial de SQL Server. Seleccionar la opción **"Descargar medios"** para bajar los archivos de instalación completos y realizar la instalación posteriormente.

![Selección de tipo de instalación](/Img/Captura%20de%20pantalla%202026-01-12%20213542.png)

**Paso 2:** Especificar el idioma (Inglés recomendado para compatibilidad) y seleccionar el paquete **ISO**. Elegir la ruta de descarga.

![Configuración de descarga ISO](/Img/Captura%20de%20pantalla%202026-01-12%20213651.png)

**Paso 3:** Una vez finalizada la descarga, ubicar el archivo `.iso` descargado. Hacer clic derecho sobre él y seleccionar **"Montar"**. Esto creará una unidad de disco virtual con los archivos de instalación.

![Montar imagen ISO](/Img/Captura%20de%20pantalla%202026-01-12%20213932.png)

**Paso 4:** Dentro de la unidad montada, ejecutar el archivo `setup.exe` como administrador (clic derecho > Ejecutar como administrador).

![Ejecutar Setup](/Img/Captura%20de%20pantalla%202026-01-12%20214018.png)

---

## 2. Instalación del Motor de Base de Datos

**Paso 5:** En el "SQL Server Installation Center", ir a la pestaña **Installation** y seleccionar la primera opción: **"New SQL Server standalone installation..."**.

![Installation Center](/Img/Captura%20de%20pantalla%202026-01-12%20214250.png)

**Paso 6:** **Edition:** Seleccionar **Developer** (es gratuita para entornos de desarrollo y pruebas) y hacer clic en Next.

![Selección de Edición](/Img/Captura%20de%20pantalla%202026-01-12%20214340.png)

**Paso 7:** **Feature Selection:** Tras aceptar los términos de licencia y revisar la extensión de Azure, llegarás a la selección de características. Marcar **"Database Engine Services"**. Opcionalmente marcar "SQL Server Replication" si se requiere.

![Selección de Características](/Img/Captura%20de%20pantalla%202026-01-12%20214557.png)

**Paso 8:** **Database Engine Configuration (Importante):**
* Seleccionar **Mixed Mode** (Autenticación de Windows y SQL Server).
* Establecer una contraseña segura para el usuario administrador `sa`.
* Hacer clic en el botón **"Add Current User"** para otorgar permisos de administrador a tu usuario de Windows.

![Configuración del Motor](/Img/Captura%20de%20pantalla%202026-01-12%20214748.png)

**Paso 9:** Revisar el resumen y hacer clic en **Install**. Esperar a que la barra de progreso finalice.

![Progreso de instalación](/img/Captura%20de%20pantalla%202026-01-12%20214845.png)

**Paso 10:** Verificar que todas las características tengan el estado **"Succeeded"** y cerrar el asistente.

![Instalación Completada](/Img/Captura%20de%20pantalla%202026-01-12%20214922.png)

---

## 3. Instalación de SSMS (SQL Server Management Studio)

**Paso 11:** Volver al "Installation Center" y seleccionar **"Install SQL Server Management Tools"**. Esto abrirá el navegador.

![Enlace a SSMS](/Img/Captura%20de%20pantalla%202026-01-12%20215025.png)

**Paso 12:** Descargar la última versión disponible (SSMS 20 o superior).

![Descarga Web SSMS](/Img/Captura%20de%20pantalla%202026-01-12%20215039.png)

**Paso 13:** Ejecutar el instalador de SSMS y completar el asistente.

![Setup SSMS](/Img/Captura%20de%20pantalla%202026-01-12%20215242.png)

---

## 4. Validación y Conexión

**Paso 14:** Abrir **SQL Server Management Studio 22** desde el menú de inicio.

![Inicio SSMS](/Img/Captura%20de%20pantalla%202026-01-12%20215208.png)

**Paso 15:** En la ventana "Connect to Server":
* **Server name:** Usar `localhost`, `.` o el nombre de tu equipo.
* **Authentication:** Windows Authentication (o SQL Server Authentication si deseas probar el usuario `sa`).
* Clic en **Connect**.

![Ventana de Conexión](/Img/Captura%20de%20pantalla%202026-01-12%20215347.png)

**Paso 16:** Si la conexión es exitosa, verás el **Explorador de objetos** a la izquierda con el servidor en verde (icono de 'play' pequeño sobre el cilindro).

![Conexión Exitosa](/Img/Captura%20de%20pantalla%202026-01-12%20215406.png)
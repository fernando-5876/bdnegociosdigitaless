# Manual de Instalación de Docker Desktop

Esta guía describe los pasos necesarios para instalar y configurar correctamente Docker Desktop en un entorno Windows, incluyendo la solución a dependencias comunes de WSL (Windows Subsystem for Linux).

## Requisitos Previos
* Windows 10 o Windows 11.
* Permisos de administrador en el equipo.

---

## 1. Instalación del Software

1.  **Descarga y Ejecución:**
    Descargue el instalador desde el sitio oficial de Docker y ejecútelo.

2.  **Acuerdo de Servicio:**
    Al iniciar el instalador, se mostrará el contrato de suscripción. Debe hacer clic en **Accept** para continuar.

    ![Pantalla de aceptación de términos](/Img/Captura%20de%20pantalla%202026-01-18%20192943.png)

3.  **Configuración de Cuenta:**
    Al finalizar la instalación, se abrirá la pantalla de bienvenida.
    * No es obligatorio crear una cuenta para uso personal.
    * Seleccione la opción **Skip** (Omitir) para acceder directamente al panel de control.

    ![Omitir creación de cuenta](/Img/Captura%20de%20pantalla%202026-01-18%20195157.png)

---

## 2. Actualización de Componentes (WSL 2)

Docker requiere que el kernel de Linux de Windows esté actualizado. Es posible que al iniciar la aplicación por primera vez aparezca el siguiente mensaje de error: *"WSL needs updating"*.

![Aviso de actualización requerida de WSL](/Img/Captura%20de%20pantalla%202026-01-18%20195435.png)

### Pasos para solucionar el error:

1.  Abra una terminal (PowerShell o CMD) con permisos de administrador.
2.  Ejecute el siguiente comando para descargar e instalar la última versión del kernel:

    ```bash
    wsl --update
    ```

    ![Ejecución del comando de actualización](/Img/Captura%20de%20pantalla%202026-01-18%20195526.png)

3.  Una vez finalizado el proceso, reinicie Docker Desktop. El motor de contenedores debería iniciar sin problemas.

    ![Inicio correcto de Docker Engine](/Img/Captura%20de%20pantalla%202026-01-18%20195939.png)

---

## 3. Verificación de la Instalación

Para asegurarse de que Docker se ha instalado correctamente y está listo para recibir comandos, realice una prueba de versión desde la terminal (se recomienda usar Git Bash o PowerShell).

Ejecute el comando:

```bash
docker --version
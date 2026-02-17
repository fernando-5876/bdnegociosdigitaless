# Manual de Configuración y Vinculación de Git con GitHub

Este documento técnico describe el proceso paso a paso para la creación de una cuenta en GitHub, la configuración de credenciales en Git Bash y la inicialización, gestión y despliegue de un repositorio local hacia un entorno remoto.

## 1. Gestión de Cuenta en GitHub

### 1.1 Acceso a la Plataforma
El procedimiento comienza ingresando al portal oficial de GitHub.

![Página de inicio de GitHub](/Img/WhatsApp%20Image%202026-01-21%20at%208.04.29%20PM.jpeg)

### 1.2 Registro de Usuario
Se completa el formulario de registro proporcionando un correo electrónico, una contraseña segura, un nombre de usuario y la región de residencia.

![Formulario de registro](/Img/WhatsApp%20Image%202026-01-21%20at%208.05.31%20PM.jpeg)

### 1.3 Panel de Control
Una vez creada la cuenta e iniciada la sesión, el usuario accede al Dashboard principal para la gestión de proyectos.

![Dashboard de GitHub](/Img/WhatsApp%20Image%202026-01-21%20at%208.05.42%20PM.jpeg)

---

## 2. Configuración del Entorno Local

Antes de comenzar a versionar código, es necesario configurar la identidad del usuario en la terminal Git Bash para asociar los cambios al correo electrónico registrado.

**Comando ejecutado:**

```bash
git config --global user.email "garciadonai2512@gmail.com"
```

![Configuración de email global](/Img/WhatsApp%20Image%202026-01-21%20at%208.05.43%20PM.jpeg)

## Inicialización del repositorio local
Se navega a la carpeta del proyecto y se inicializa el repositorio de Git. Posteriormente, se renombra la rama principal de master a main, siguiendo las convenciones actuales.

```bash
cd proyecto
git init
git branch -m main
```

## Verificación del estado de los archivos
El comando git status permite verificar el estado de los archivos del proyecto. En esta etapa, los archivos aparecen como Untracked files, indicando que Git los ha detectado pero aún no están bajo control de versiones.

```bash
git status
```

## Preparación de archivos (Staging Area)
Se agregan los archivos al área de preparación utilizando el comando git add .. Al volver a ejecutar git status, los archivos aparecen en verde, confirmando que están listos para ser confirmados.

```bash
git add .
git status
```

## Confirmación de cambios (Commit)
Se realiza el primer commit del proyecto con un mensaje descriptivo, creando un punto de guardado en el historial del repositorio. En este caso, se registran 6 archivos insertados.

```bash
git commit -m "Primer commit del proyecto"
```

## Sección 3: Conexión Remota y Despliegue
Vinculación con el repositorio remoto
Para enlazar el repositorio local con GitHub, se agrega un repositorio remoto utilizando un nombre personalizado en lugar del nombre por defecto origin.

```bash
git remote add Juanito https://github.com/usuario/repositorio.git
```

## Subida del proyecto al repositorio remoto
Finalmente, se ejecuta correctamente el comando para subir la rama local main al repositorio remoto configurado, estableciendo una relación de seguimiento entre ambas ramas.

```bash
git push -u Juanito main
Este comando permite que futuras actualizaciones se suban utilizando simplemente git push.
```
# WordPress Sage Starter

Starter de WordPress reutilizable para sitios de marketing, construido con Bedrock, Sage, Tailwind CSS, Gutenberg y ACF Free.

Este starter es una plantilla de origen. Los proyectos generados evolucionan de forma independiente.

## Requisitos

- PHP >= 8.3
- Composer >= 2.x
- Node.js
- WP-CLI disponible en el PATH
- Git

Los scripts resuelven estas herramientas desde el PATH. Si alguna no está en el PATH, o necesitas fijar una instalación concreta, define la variable de entorno correspondiente con su ruta ejecutable en vez de editar ningún script: `STARTER_PHP`, `STARTER_COMPOSER`, `STARTER_WP_CLI`, `STARTER_GIT`, `STARTER_NODE`, `STARTER_NPM`.

## Instalación

1. Crea tu propia copia de este repo bajo tu cuenta, y luego entra en ella con `cd`:

   - **Web**: en [la página de GitHub de este repo](https://github.com/Carlos-CMP/wp-sage-starter), pulsa **Use this template**, y luego clona *tu nuevo repo* (no este):

     ![Botón "Use this template" en la página de GitHub del repo](docs/images/paso1.png)

     ```powershell
     git clone https://github.com/<tu-cuenta>/<tu-nuevo-repo>.git
     cd <tu-nuevo-repo>
     ```
   - **GitHub CLI** (requiere [`gh`](https://cli.github.com/), aparte de Git): hace ambos pasos a la vez —

     ```powershell
     gh repo create <tu-cuenta>/<tu-nuevo-repo> --template Carlos-CMP/wp-sage-starter --clone
     cd <tu-nuevo-repo>
     ```
2. Comprueba los requisitos:

   ```powershell
   .\scripts\doctor.ps1
   ```
3. Apunta LocalWP a este repo (requiere tener ya un sitio de LocalWP creado con WordPress instalado — `<nombre-de-tu-sitio-local>` es como lo hayas llamado en Local):

   ```powershell
   .\scripts\link-localwp.ps1 -LocalSitePath "$env:USERPROFILE\Local Sites\<nombre-de-tu-sitio-local>"
   ```
4. Instala y configura el proyecto:

   ```powershell
   .\scripts\new-project.ps1 -ProjectName "My Project" -Domain "my-project.local" -DbHost "127.0.0.1:10023"
   ```
   Usa `-Domain "localhost:<puerto>"` si el sitio está en modo de enrutado "localhost" de LocalWP. Claves de `.env`: consulta `.env.example`.
5. Comprobación final:

   ```powershell
   .\scripts\validate.ps1
   ```

Otros comandos: `.\scripts\wp.ps1 --info` (WP-CLI), `.\scripts\seed-demo-content.ps1` (resembrar la home de demo).

## Arquitectura

https://carlos-cmp.github.io/wp-sage-starter/runtime-architecture/runtime-architecture.html

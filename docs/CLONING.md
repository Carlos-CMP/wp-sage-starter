# Cloning The Starter

This repository is meant to be cloned as the base for a new WordPress project. The generated project owns its future changes.

## Required Local Tools

Use the preferred paths expected by the starter:

- PHP: `C:\php83\php.exe`
- Composer: `C:\ProgramData\ComposerSetup\bin\composer.phar`
- WP-CLI: `C:\wp-cli\wp-cli.phar`
- Git: `C:\Program Files\Git\cmd\git.exe`
- Node: `C:\Program Files\nodejs\node.exe`
- npm: `C:\Program Files\nodejs\npm.cmd`
- LocalWP recommended

Check the machine before bootstrapping:

```powershell
.\scripts\doctor.ps1
```

## LocalWP Flow

1. Create a new site in LocalWP.
2. Use the project name as the LocalWP site domain when possible.
3. Clone this repository outside or inside `~/Local Sites`.
4. Link LocalWP's `app/public` directory to the starter `web` directory:

```powershell
.\scripts\link-localwp.ps1 -LocalSitePath "$env:USERPROFILE\Local Sites\starter-sage-wp"
```

The script moves the existing LocalWP `app/public` directory to a timestamped backup and creates a junction to this repository's `web` directory.

## Bootstrap

Use the DB host and frontend URL shown by LocalWP.

Site Domains mode:

```powershell
.\new-project.ps1 -ProjectName "My Project" -Domain "my-project.local" -DbHost "127.0.0.1:10023"
```

Localhost Routing Mode:

```powershell
.\new-project.ps1 -ProjectName "My Project" -Domain "localhost:10022" -DbHost "127.0.0.1:10023"
```

The script creates `.env` when missing, installs dependencies, builds the theme, activates the starter plugin/theme, configures permalinks, and seeds the starter pages.

## After Bootstrap

Validate the project:

```powershell
.\scripts\validate.ps1
```

Then open the frontend URL configured in `.env`.

param()

$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$theme = Join-Path $root 'web\app\themes\starter-theme'
$php = 'C:\php83\php.exe'
$composer = 'C:\ProgramData\ComposerSetup\bin\composer.phar'

if (-not (Test-Path -LiteralPath $php)) {
    throw "PHP 8.3 not found at $php"
}

if (-not (Test-Path -LiteralPath $composer)) {
    throw "Composer PHAR not found at $composer"
}

function Invoke-Checked {
    param(
        [scriptblock] $Command
    )

    & $Command

    if ($LASTEXITCODE -ne 0) {
        throw "Command failed with exit code $LASTEXITCODE"
    }
}

Invoke-Checked { & $php $composer validate --strict }
Invoke-Checked { & $php $composer lint }

Push-Location $theme
try {
    Invoke-Checked { & npm run lint }
    Invoke-Checked { & npm run format }
    Invoke-Checked { & npm run build }
} finally {
    Pop-Location
}

'Validation complete'

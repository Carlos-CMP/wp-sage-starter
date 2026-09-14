param()

$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$theme = Join-Path $root 'web\app\themes\starter-theme'

. (Join-Path $PSScriptRoot '_tools.ps1')

$php = Get-PhpPath
$composer = Get-ComposerPath
$npm = Get-NpmPath

Assert-Tool -Name 'PHP' -Path $php -EnvVar 'STARTER_PHP'
Assert-Tool -Name 'Composer' -Path $composer -EnvVar 'STARTER_COMPOSER'
Assert-Tool -Name 'npm' -Path $npm -EnvVar 'STARTER_NPM'

function Invoke-Checked {
    param(
        [scriptblock] $Command
    )

    & $Command

    if ($LASTEXITCODE -ne 0) {
        throw "Command failed with exit code $LASTEXITCODE"
    }
}

Invoke-Composer -ComposerPath $composer -PhpPath $php -Arguments @('validate', '--strict')
Invoke-Composer -ComposerPath $composer -PhpPath $php -Arguments @('lint')

Push-Location $theme
try {
    Invoke-Checked { & $npm run lint }
    Invoke-Checked { & $npm run format }
    Invoke-Checked { & $npm run build }
} finally {
    Pop-Location
}

'Validation complete'

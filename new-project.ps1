param(
    [string] $ProjectName = 'WordPress Sage Starter',
    [string] $Domain = 'starter-sage-wp.local',
    [string] $DbHost = '',
    [string] $DbName = 'local',
    [string] $DbUser = 'root',
    [string] $DbPassword = 'root',
    [switch] $ForceEnv,
    [switch] $SkipInstall
)

$ErrorActionPreference = 'Stop'

$root = $PSScriptRoot
$theme = Join-Path $root 'web\app\themes\starter-theme'
$envFile = Join-Path $root '.env'
$php = 'C:\php83\php.exe'
$composer = 'C:\ProgramData\ComposerSetup\bin\composer.phar'
$node = 'C:\Program Files\nodejs\node.exe'
$npm = 'C:\Program Files\nodejs\npm.cmd'
$wp = Join-Path $root 'scripts\wp.ps1'
$seed = Join-Path $root 'scripts\seed-demo-content.ps1'

function Assert-Path {
    param(
        [string] $Path,
        [string] $Message
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        throw $Message
    }
}

function New-Secret {
    $rng = [System.Security.Cryptography.RandomNumberGenerator]::Create()
    $bytes = New-Object byte[] 32
    $rng.GetBytes($bytes)
    $rng.Dispose()

    return ($bytes | ForEach-Object { $_.ToString('x2') }) -join ''
}

Assert-Path $php 'PHP 8.3 not found at C:\php83\php.exe'
Assert-Path $composer 'Composer PHAR not found at C:\ProgramData\ComposerSetup\bin\composer.phar'
Assert-Path $node 'Node not found at C:\Program Files\nodejs\node.exe'
Assert-Path $npm 'npm not found at C:\Program Files\nodejs\npm.cmd'
Assert-Path $wp 'WP-CLI wrapper not found at scripts\wp.ps1'
Assert-Path $seed 'Demo seed script not found at scripts\seed-demo-content.ps1'

& $node --version | Out-Null
& $npm --version | Out-Null
& $wp --info | Out-Null

if ((-not (Test-Path -LiteralPath $envFile)) -or $ForceEnv) {
    if (-not $DbHost) {
        throw 'DbHost is required when creating .env. Use the LocalWP MySQL port, for example: -DbHost 127.0.0.1:10023'
    }

    $envContent = @"
DB_NAME='$DbName'
DB_USER='$DbUser'
DB_PASSWORD='$DbPassword'
DB_HOST='$DbHost'

WP_ENV='development'
WP_HOME='http://$Domain'
WP_SITEURL="`${WP_HOME}/wp"

STARTER_VERSION='1.0.0'

AUTH_KEY='$(New-Secret)'
SECURE_AUTH_KEY='$(New-Secret)'
LOGGED_IN_KEY='$(New-Secret)'
NONCE_KEY='$(New-Secret)'
AUTH_SALT='$(New-Secret)'
SECURE_AUTH_SALT='$(New-Secret)'
LOGGED_IN_SALT='$(New-Secret)'
NONCE_SALT='$(New-Secret)'
"@

    [System.IO.File]::WriteAllText($envFile, $envContent, [System.Text.UTF8Encoding]::new($false))
}

if (-not $SkipInstall) {
    & $php $composer install
    Push-Location $theme
    try {
        & $npm install
        & $npm run build
    } finally {
        Pop-Location
    }
}

& $wp plugin activate site-content | Out-Null
& $wp theme activate starter-theme | Out-Null
& $wp option update blogname $ProjectName | Out-Null
& $wp option update permalink_structure '/%postname%/' | Out-Null
& $wp rewrite flush | Out-Null
& $seed | Out-Null

"Bootstrap complete"
"Site: http://$Domain"
"Admin: http://$Domain/wp-admin/"
"Checks:"
".\scripts\wp.ps1 plugin list"
".\scripts\wp.ps1 theme list"

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
$wp = Join-Path $root 'scripts\wp.ps1'
$seed = Join-Path $root 'scripts\seed-demo-content.ps1'

. (Join-Path $root 'scripts\_tools.ps1')

$php = Get-PhpPath
$composer = Get-ComposerPath
$node = Get-NodePath
$npm = Get-NpmPath

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

function Invoke-WpChecked {
    param([Parameter(ValueFromRemainingArguments = $true)] [string[]] $Arguments)

    & $wp @Arguments | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "wp $($Arguments -join ' ') failed with exit code $LASTEXITCODE"
    }
}

if (-not $SkipInstall) {
    Assert-Tool -Name 'PHP' -Path $php -EnvVar 'STARTER_PHP'
    Assert-Tool -Name 'Composer' -Path $composer -EnvVar 'STARTER_COMPOSER'
    Assert-Tool -Name 'Node' -Path $node -EnvVar 'STARTER_NODE'
    Assert-Tool -Name 'npm' -Path $npm -EnvVar 'STARTER_NPM'
}

Assert-Path $wp 'WP-CLI wrapper not found at scripts\wp.ps1'
Assert-Path $seed 'Demo seed script not found at scripts\seed-demo-content.ps1'

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
    Invoke-Composer -ComposerPath $composer -PhpPath $php -Arguments @('install')
    Push-Location $theme
    try {
        & $npm install
        if ($LASTEXITCODE -ne 0) { throw "npm install failed with exit code $LASTEXITCODE" }
        & $npm run build
        if ($LASTEXITCODE -ne 0) { throw "npm run build failed with exit code $LASTEXITCODE" }
    } finally {
        Pop-Location
    }
}

& $wp core is-installed | Out-Null
if ($LASTEXITCODE -ne 0) {
    throw "WordPress is not installed in the database at the DB_HOST configured in .env. Create the LocalWP site with WordPress already installed, then link it with scripts\link-localwp.ps1 before running this script."
}

Invoke-WpChecked plugin activate site-content
Invoke-WpChecked theme activate starter-theme
Invoke-WpChecked option update blogname $ProjectName
Invoke-WpChecked option update permalink_structure '/%postname%/'
Invoke-WpChecked rewrite flush

& $seed
if ($LASTEXITCODE -ne 0) { throw "seed-demo-content.ps1 failed with exit code $LASTEXITCODE" }

"Bootstrap complete"
"Site: http://$Domain"
"Admin: http://$Domain/wp-admin/"
"Checks:"
".\scripts\wp.ps1 plugin list"
".\scripts\wp.ps1 theme list"

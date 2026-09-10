param(
    [switch] $Json,
    [switch] $Strict
)

$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$theme = Join-Path $root 'web\app\themes\starter-theme'
$envFile = Join-Path $root '.env'

$paths = @{
    PHP = 'C:\php83\php.exe'
    Composer = 'C:\ProgramData\ComposerSetup\bin\composer.phar'
    WPCLI = 'C:\wp-cli\wp-cli.phar'
    WPWrapper = Join-Path $root 'scripts\wp.ps1'
    Git = 'C:\Program Files\Git\cmd\git.exe'
    Node = 'C:\Program Files\nodejs\node.exe'
    Npm = 'C:\Program Files\nodejs\npm.cmd'
    LocalWP = 'C:\Program Files (x86)\Local\Local.exe'
}

$results = New-Object System.Collections.Generic.List[object]

function Add-Result {
    param(
        [string] $Status,
        [string] $Name,
        [string] $Message,
        [object] $Details = $null
    )

    $results.Add([pscustomobject] @{
        status = $Status
        name = $Name
        message = $Message
        details = $Details
    })
}

function Invoke-Capture {
    param(
        [scriptblock] $Command
    )

    $previousErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'

    try {
        $output = & $Command 2>&1
    } finally {
        $ErrorActionPreference = $previousErrorActionPreference
    }

    return [pscustomobject] @{
        ExitCode = $LASTEXITCODE
        Output = ($output -join "`n").Trim()
    }
}

function Test-VersionAtLeast {
    param(
        [string] $Version,
        [int] $Major,
        [int] $Minor
    )

    if ($Version -notmatch '(\d+)\.(\d+)') {
        return $false
    }

    $actualMajor = [int] $Matches[1]
    $actualMinor = [int] $Matches[2]

    return ($actualMajor -gt $Major) -or (($actualMajor -eq $Major) -and ($actualMinor -ge $Minor))
}

function Test-NodeVersion {
    param(
        [string] $Version
    )

    if ($Version -notmatch 'v?(\d+)\.(\d+)\.(\d+)') {
        return $false
    }

    $major = [int] $Matches[1]
    $minor = [int] $Matches[2]

    return (($major -eq 20) -and ($minor -ge 19)) -or (($major -eq 22) -and ($minor -ge 12)) -or ($major -gt 22)
}

function Read-EnvKeys {
    param(
        [string] $Path
    )

    $keys = @{}

    foreach ($line in Get-Content -LiteralPath $Path) {
        if ($line -match '^\s*([A-Z0-9_]+)\s*=') {
            $keys[$Matches[1]] = $true
        }
    }

    return $keys
}

foreach ($tool in @('PHP', 'Composer', 'WPCLI', 'WPWrapper', 'Git', 'Node', 'Npm')) {
    if (Test-Path -LiteralPath $paths[$tool]) {
        Add-Result 'OK' $tool "$tool found at $($paths[$tool])"
    } else {
        Add-Result 'ERROR' $tool "$tool missing at $($paths[$tool])"
    }
}

if (Test-Path -LiteralPath $paths.PHP) {
    $phpVersion = Invoke-Capture { & $paths.PHP -r 'echo PHP_VERSION;' }
    if (($phpVersion.ExitCode -eq 0) -and (Test-VersionAtLeast $phpVersion.Output 8 3)) {
        Add-Result 'OK' 'PHP version' "PHP $($phpVersion.Output)"
    } else {
        Add-Result 'ERROR' 'PHP version' "PHP 8.3 or newer required" $phpVersion.Output
    }
}

if ((Test-Path -LiteralPath $paths.PHP) -and (Test-Path -LiteralPath $paths.Composer)) {
    $composerVersion = Invoke-Capture { & $paths.PHP $paths.Composer --version }
    if ($composerVersion.ExitCode -eq 0) {
        Add-Result 'OK' 'Composer runtime' $composerVersion.Output.Split("`n")[0]
    } else {
        Add-Result 'ERROR' 'Composer runtime' 'Composer cannot run with PHP 8.3' $composerVersion.Output
    }
}

if (Test-Path -LiteralPath $paths.Git) {
    $gitVersion = Invoke-Capture { & $paths.Git --version }
    if ($gitVersion.ExitCode -eq 0) {
        Add-Result 'OK' 'Git version' $gitVersion.Output
    } else {
        Add-Result 'ERROR' 'Git version' 'Git command failed' $gitVersion.Output
    }
}

if (Test-Path -LiteralPath $paths.Node) {
    $nodeVersion = Invoke-Capture { & $paths.Node --version }
    if (($nodeVersion.ExitCode -eq 0) -and (Test-NodeVersion $nodeVersion.Output)) {
        Add-Result 'OK' 'Node version' "$($nodeVersion.Output) satisfies $((Get-Content -Raw (Join-Path $theme 'package.json') | ConvertFrom-Json).engines.node)"
    } else {
        Add-Result 'ERROR' 'Node version' 'Node must satisfy ^20.19.0 || >=22.12.0' $nodeVersion.Output
    }
}

if (Test-Path -LiteralPath $paths.Npm) {
    $npmVersion = Invoke-Capture { & $paths.Npm --version }
    if ($npmVersion.ExitCode -eq 0) {
        Add-Result 'OK' 'npm version' $npmVersion.Output
    } else {
        Add-Result 'ERROR' 'npm version' 'npm command failed' $npmVersion.Output
    }
}

if ((Test-Path -LiteralPath $paths.PHP) -and (Test-Path -LiteralPath $paths.WPCLI)) {
    $wpInfo = Invoke-Capture { & $paths.PHP $paths.WPCLI --info }
    if ($wpInfo.ExitCode -eq 0) {
        Add-Result 'OK' 'WP-CLI runtime' 'WP-CLI runs with PHP 8.3'
    } else {
        Add-Result 'ERROR' 'WP-CLI runtime' 'WP-CLI cannot run with PHP 8.3' $wpInfo.Output
    }
}

if (Test-Path -LiteralPath $envFile) {
    Add-Result 'OK' '.env' ".env found at $envFile"
    $envKeys = Read-EnvKeys $envFile
    $requiredEnv = @('DB_NAME', 'DB_USER', 'DB_PASSWORD', 'DB_HOST', 'WP_ENV', 'WP_HOME', 'WP_SITEURL', 'AUTH_KEY', 'SECURE_AUTH_KEY', 'LOGGED_IN_KEY', 'NONCE_KEY', 'AUTH_SALT', 'SECURE_AUTH_SALT', 'LOGGED_IN_SALT', 'NONCE_SALT')
    $missingEnv = $requiredEnv | Where-Object { -not $envKeys.ContainsKey($_) }

    if ($missingEnv.Count -eq 0) {
        Add-Result 'OK' '.env keys' 'Required .env keys are present'
    } else {
        Add-Result 'ERROR' '.env keys' 'Required .env keys are missing' $missingEnv
    }
} else {
    Add-Result 'WARN' '.env' '.env is missing; bootstrap can create it when DbHost is provided'
}

if (Test-Path -LiteralPath $paths.LocalWP) {
    Add-Result 'OK' 'LocalWP' "LocalWP found at $($paths.LocalWP)"
} else {
    Add-Result 'WARN' 'LocalWP' "LocalWP not found at $($paths.LocalWP)"
}

$sitesFile = Join-Path $env:APPDATA 'Local\sites.json'
$statusesFile = Join-Path $env:APPDATA 'Local\site-statuses.json'

if ((Test-Path -LiteralPath $sitesFile) -and (Test-Path -LiteralPath $statusesFile)) {
    $sites = Get-Content -Raw -LiteralPath $sitesFile | ConvertFrom-Json
    $statuses = Get-Content -Raw -LiteralPath $statusesFile | ConvertFrom-Json
    $localSites = @()

    foreach ($property in $sites.PSObject.Properties) {
        $site = $property.Value
        $status = $statuses.PSObject.Properties[$property.Name].Value
        $mysqlPort = $site.services.mysql.ports.MYSQL[0]

        $localSites += [pscustomobject] @{
            name = $site.name
            domain = $site.domain
            dbHost = if ($mysqlPort) { "127.0.0.1:$mysqlPort" } else { $null }
            status = $status
        }
    }

    Add-Result 'OK' 'LocalWP sites' 'LocalWP site metadata detected' $localSites
}

if (Test-Path -LiteralPath $envFile) {
    $core = Invoke-Capture { & $paths.WPWrapper core version }
    if ($core.ExitCode -eq 0) {
        Add-Result 'OK' 'WordPress runtime' "WordPress $($core.Output)"

        $plugins = Invoke-Capture { & $paths.WPWrapper plugin list }
        if ($plugins.ExitCode -eq 0) {
            Add-Result 'OK' 'WordPress plugins' 'Plugin list loads'
        } else {
            Add-Result 'WARN' 'WordPress plugins' 'Plugin list failed' $plugins.Output
        }

        $themes = Invoke-Capture { & $paths.WPWrapper theme list }
        if ($themes.ExitCode -eq 0) {
            Add-Result 'OK' 'WordPress themes' 'Theme list loads'
        } else {
            Add-Result 'WARN' 'WordPress themes' 'Theme list failed' $themes.Output
        }
    } else {
        Add-Result 'WARN' 'WordPress runtime' 'WordPress DB/runtime is not available; start LocalWP and check .env DB_HOST' $core.Output
    }
}

if ($Json) {
    $results | ConvertTo-Json -Depth 8
} else {
    foreach ($result in $results) {
        '{0,-5} {1}: {2}' -f $result.status, $result.name, $result.message
    }
}

$hasErrors = ($results | Where-Object { $_.status -eq 'ERROR' }).Count -gt 0
$hasWarnings = ($results | Where-Object { $_.status -eq 'WARN' }).Count -gt 0

if ($hasErrors -or ($Strict -and $hasWarnings)) {
    exit 1
}

exit 0

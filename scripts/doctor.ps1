param(
    [switch] $Json,
    [switch] $Strict
)

$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$theme = Join-Path $root 'web\app\themes\starter-theme'
$envFile = Join-Path $root '.env'

. (Join-Path $PSScriptRoot '_tools.ps1')

$envVars = @{
    PHP = 'STARTER_PHP'
    Composer = 'STARTER_COMPOSER'
    WPCLI = 'STARTER_WP_CLI'
    Git = 'STARTER_GIT'
    Node = 'STARTER_NODE'
    Npm = 'STARTER_NPM'
}

$installUrls = @{
    PHP = 'https://windows.php.net/download/'
    Composer = 'https://getcomposer.org/download/'
    WPCLI = 'https://wp-cli.org/#installing'
    Git = 'https://git-scm.com/download/win'
    Node = 'https://nodejs.org/'
}

# Only tools with an official winget package; Composer and WP-CLI have none.
$wingetIds = @{
    PHP = 'PHP.PHP.8.3'
    Git = 'Git.Git'
    Node = 'OpenJS.NodeJS'
}

$paths = @{
    PHP = Get-PhpPath
    Composer = Get-ComposerPath
    WPCLI = Get-WpCliPath
    WPWrapper = Join-Path $root 'scripts\wp.ps1'
    Git = Get-GitPath
    Node = Get-NodePath
    Npm = Get-NpmPath
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
        $exitCode = $LASTEXITCODE
    } catch {
        $output = $_.Exception.Message
        $exitCode = 1
    } finally {
        $ErrorActionPreference = $previousErrorActionPreference
    }

    return [pscustomobject] @{
        ExitCode = $exitCode
        Output = ($output -join "`n").Trim()
    }
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
    if ($paths[$tool]) {
        Add-Result 'OK' $tool "at $($paths[$tool])"
    } else {
        $hint = if ($envVars.ContainsKey($tool)) { " Install it and ensure it's on PATH, or set `$env:$($envVars[$tool]) to its executable path." } else { '' }
        $howToInstall = if ($wingetIds.ContainsKey($tool)) {
            " winget install $($wingetIds[$tool]), or download from $($installUrls[$tool])"
        } elseif ($installUrls.ContainsKey($tool)) {
            " Download: $($installUrls[$tool])"
        } else { '' }
        Add-Result 'ERROR' $tool "$tool not found on PATH.$hint$howToInstall"
    }
}

if ($paths.PHP) {
    $phpVersion = Invoke-Capture { & $paths.PHP -r 'echo PHP_VERSION;' }
    if ($phpVersion.ExitCode -eq 0) {
        $requiredPhp = (Get-Content -Raw (Join-Path $root 'composer.json') | ConvertFrom-Json).require.php
        $belowRequirement = $requiredPhp -match '^>=\s*([\d.]+)$' -and [version] $phpVersion.Output -lt [version] $Matches[1]

        if ($belowRequirement) {
            Add-Result 'WARN' 'PHP version' "PHP $($phpVersion.Output) does not satisfy composer.json's '$requiredPhp' requirement; composer install will fail. If this came from LocalWP, switch the site's PHP version in Local, or point `$env:STARTER_PHP at a matching PHP."
        } else {
            Add-Result 'OK' 'PHP version' "PHP $($phpVersion.Output) (composer install enforces the '$requiredPhp' requirement in composer.json)"
        }
    } else {
        Add-Result 'ERROR' 'PHP version' 'Failed to read PHP version' $phpVersion.Output
    }
}

if ($paths.Composer) {
    $composerVersion = if ($paths.Composer -like '*.phar') {
        if ($paths.PHP) { Invoke-Capture { & $paths.PHP $paths.Composer --version } } else { $null }
    } else {
        Invoke-Capture { & $paths.Composer --version }
    }

    if ($composerVersion -and $composerVersion.ExitCode -eq 0) {
        Add-Result 'OK' 'Composer runtime' $composerVersion.Output.Split("`n")[0]
    } else {
        Add-Result 'ERROR' 'Composer runtime' 'Composer failed to run' ($composerVersion.Output)
    }
}

if ($paths.Git) {
    $gitVersion = Invoke-Capture { & $paths.Git --version }
    if ($gitVersion.ExitCode -eq 0) {
        Add-Result 'OK' 'Git version' $gitVersion.Output
    } else {
        Add-Result 'ERROR' 'Git version' 'Git command failed' $gitVersion.Output
    }
}

if ($paths.Node) {
    $nodeVersion = Invoke-Capture { & $paths.Node --version }
    if ($nodeVersion.ExitCode -eq 0) {
        $requiredNode = (Get-Content -Raw (Join-Path $theme 'package.json') | ConvertFrom-Json).engines.node
        Add-Result 'OK' 'Node version' "$($nodeVersion.Output) (npm install enforces '$requiredNode' via engine-strict)"
    } else {
        Add-Result 'ERROR' 'Node version' 'Failed to read Node version' $nodeVersion.Output
    }
}

if ($paths.Npm) {
    $npmVersion = Invoke-Capture { & $paths.Npm --version }
    if ($npmVersion.ExitCode -eq 0) {
        Add-Result 'OK' 'npm version' $npmVersion.Output
    } else {
        Add-Result 'ERROR' 'npm version' 'npm command failed' $npmVersion.Output
    }
}

if ($paths.WPCLI) {
    $wpInfo = if ($paths.WPCLI -like '*.phar') {
        if ($paths.PHP) { Invoke-Capture { & $paths.PHP $paths.WPCLI --info } } else { $null }
    } else {
        Invoke-Capture { & $paths.WPCLI --info }
    }

    if ($wpInfo -and $wpInfo.ExitCode -eq 0) {
        Add-Result 'OK' 'WP-CLI runtime' 'WP-CLI runs'
    } else {
        Add-Result 'ERROR' 'WP-CLI runtime' 'WP-CLI failed to run' ($wpInfo.Output)
    }
}

if (Test-Path -LiteralPath $envFile) {
    Add-Result 'OK' '.env' "at $envFile"
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

    Add-Result 'OK' 'LocalWP' 'LocalWP site metadata detected' $localSites
} else {
    Add-Result 'WARN' 'LocalWP' 'No LocalWP site metadata found; create a site in Local before running new-project.ps1'
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
    $statusColor = @{
        OK = 'Green'
        WARN = 'Yellow'
        ERROR = 'Red'
    }

    foreach ($result in $results) {
        Write-Host ('{0,-5} ' -f $result.status) -ForegroundColor $statusColor[$result.status] -NoNewline
        Write-Host "$($result.name): $($result.message)"
    }
}

$hasErrors = ($results | Where-Object { $_.status -eq 'ERROR' }).Count -gt 0
$hasWarnings = ($results | Where-Object { $_.status -eq 'WARN' }).Count -gt 0

if ($hasErrors -or ($Strict -and $hasWarnings)) {
    exit 1
}

exit 0

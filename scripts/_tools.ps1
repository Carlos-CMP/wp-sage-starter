# Shared tool resolution for the starter's PowerShell scripts.
# Resolves PHP, Composer, Node, npm, WP-CLI, and Git from PATH by default.
# Each tool can be pinned to a specific executable with an environment
# variable override (useful when a tool isn't on PATH, or multiple versions
# are installed side by side).
#
# Dot-source this file from another script:
#   . (Join-Path $PSScriptRoot '_tools.ps1')

function Resolve-Tool {
    param(
        [Parameter(Mandatory = $true)] [string] $EnvVar,
        [Parameter(Mandatory = $true)] [string[]] $CommandNames
    )

    $overridePath = [System.Environment]::GetEnvironmentVariable($EnvVar)
    if ($overridePath) {
        if (Test-Path -LiteralPath $overridePath) {
            return (Resolve-Path -LiteralPath $overridePath).Path
        }
        throw "`$env:$EnvVar is set to '$overridePath' but that path does not exist."
    }

    foreach ($name in $CommandNames) {
        $command = Get-Command $name -ErrorAction SilentlyContinue
        if ($command) {
            return $command.Source
        }
    }

    return $null
}

function Get-PhpPath { Resolve-Tool -EnvVar 'STARTER_PHP' -CommandNames @('php') }
function Get-ComposerPath { Resolve-Tool -EnvVar 'STARTER_COMPOSER' -CommandNames @('composer', 'composer.phar') }
function Get-NodePath { Resolve-Tool -EnvVar 'STARTER_NODE' -CommandNames @('node') }
function Get-NpmPath { Resolve-Tool -EnvVar 'STARTER_NPM' -CommandNames @('npm') }
function Get-WpCliPath { Resolve-Tool -EnvVar 'STARTER_WP_CLI' -CommandNames @('wp') }
function Get-GitPath { Resolve-Tool -EnvVar 'STARTER_GIT' -CommandNames @('git') }

function Assert-Tool {
    param(
        [Parameter(Mandatory = $true)] [string] $Name,
        [string] $Path,
        [Parameter(Mandatory = $true)] [string] $EnvVar
    )

    if (-not $Path) {
        throw "$Name not found on PATH. Install it and make sure it's on PATH, or set `$env:$EnvVar to its executable path."
    }
}

function Invoke-Composer {
    param(
        [Parameter(Mandatory = $true)] [string] $ComposerPath,
        [Parameter(Mandatory = $true)] [string[]] $Arguments,
        [string] $PhpPath
    )

    if ($ComposerPath -like '*.phar') {
        if (-not $PhpPath) {
            throw 'A PHP executable is required to run composer.phar (set $env:STARTER_PHP).'
        }
        & $PhpPath $ComposerPath @Arguments
    } else {
        & $ComposerPath @Arguments
    }

    if ($LASTEXITCODE -ne 0) {
        throw "composer $($Arguments -join ' ') failed with exit code $LASTEXITCODE"
    }
}

function Invoke-WpCli {
    param(
        [Parameter(Mandatory = $true)] [string] $WpCliPath,
        [string[]] $Arguments,
        [string] $PhpPath
    )

    if ($WpCliPath -like '*.phar') {
        if (-not $PhpPath) {
            throw 'A PHP executable is required to run wp-cli.phar (set $env:STARTER_PHP).'
        }
        & $PhpPath $WpCliPath @Arguments
    } else {
        & $WpCliPath @Arguments
    }

    return $LASTEXITCODE
}

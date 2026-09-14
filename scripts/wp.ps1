param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]] $WpArgs
)

$ErrorActionPreference = 'Stop'

. (Join-Path $PSScriptRoot '_tools.ps1')

$php = Get-PhpPath
$wpCli = Get-WpCliPath

Assert-Tool -Name 'WP-CLI' -Path $wpCli -EnvVar 'STARTER_WP_CLI'

if ($wpCli -like '*.phar') {
    Assert-Tool -Name 'PHP' -Path $php -EnvVar 'STARTER_PHP'
}

$exitCode = Invoke-WpCli -WpCliPath $wpCli -Arguments $WpArgs -PhpPath $php
exit $exitCode

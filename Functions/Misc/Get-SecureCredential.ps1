<#
.SYNOPSIS
    Loads secure credentials from a saved file and stores them as a global variable.

.DESCRIPTION
    Reads credentials previously saved using Save-CredentialSecurely. 
    Imports the XML file and stores the result in a global variable named after the alias.

.PARAMETER Alias
    The alias used when saving the credential.

.EXAMPLE
    Get-SecureCredential -Alias HE-DEV

.NOTES
    Author   : Ashley Hay-Ellis  
    Version  : 1.1  
    License  : MIT  
    Change History:
        2025-05-10 : Initial release
        2025-05-11 : Standardised naming, improved error handling
#>

function Get-SecureCredential {
    [CmdletBinding()]
    param (
        [string]$Alias
    )

    $FileName = if ($Alias) { "${Alias}_SCF.secxml" } else { "SCF.secxml" }
    $FilePath = ".\common\$FileName"

    if (-not (Test-Path -Path $FilePath)) {
        Write-Warning "No credentials found for alias '$Alias'."
        Write-Host "Run Set-SecureCredential -Alias $Alias to create them." -ForegroundColor Yellow
        return
    }

    try {
        $Credential = Import-CliXml -Path $FilePath
        New-Variable -Name $Alias -Value $Credential -Scope Global -Force
        Write-Host "Credential loaded into variable '$Alias'" -ForegroundColor Green
    } catch {
        Write-Error "Failed to import credential from $FilePath"
    }
}

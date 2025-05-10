<#
.SYNOPSIS
    Creates Secure credentials and stores them to be used later.

.DESCRIPTION
    Prompts for credentials and saves them securely as an XML file under the "common" folder.
    These can then be recalled in other functions using the saved alias.

.PARAMETER Alias
    Optional alias to name the credential file. Defaults to 'SCF.secxml' if not provided.

.EXAMPLE
    Set-SecureCredential -Alias HE-DEV

.NOTES
    Author   : Ashley Hay-Ellis  
    Version  : 1.0  
    License  : MIT  
    Change History:
        2025-05-10 : Initial release
#>

function Set-SecureCredential {
    [CmdletBinding()]
    param (
        [string]$Alias
    )

    $FileName = if ($Alias) { "${Alias}_SCF.secxml" } else { "SCF.secxml" }
    $FilePath = ".\common\$FileName"

    if (Test-Path -Path $FilePath) {
        $response = Read-Host "File '$FilePath' already exists. Overwrite? (Y/N)"
        if ($response -notin @('Y','y')) {
            Write-Host "Credentials not updated." -ForegroundColor Yellow
            return
        }
    }

    $Credential = Get-Credential
    $Credential | Export-CliXml -Path $FilePath
    Write-Host "Credential saved to '$FilePath'" -ForegroundColor Green
}

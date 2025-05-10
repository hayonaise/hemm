<#
.SYNOPSIS
    Lists all saved secure credential aliases in the common folder.

.DESCRIPTION
    Scans the .\common folder for any *_SCF.secxml files and extracts the alias name.
    Useful for seeing which credential aliases you’ve got saved and ready to load.

.EXAMPLE
    Show-SecureCredential

.NOTES
    Author   : Ashley Hay-Ellis  
    Version  : 1.0  
    License  : MIT  
    Change History:
        2025-05-11 : Initial release
#>

function Show-SecureCredential {
    [CmdletBinding()]
    param ()

    $CredentialFiles = Get-ChildItem -Path ".\common" -Filter "*_SCF.secxml" -ErrorAction SilentlyContinue

    if (-not $CredentialFiles) {
        Write-Host "No saved credentials found in .\common" -ForegroundColor Yellow
        return
    }

    Write-Host "Found saved credential aliases:" -ForegroundColor Cyan

    foreach ($file in $CredentialFiles) {
        $alias = $file.BaseName -replace '_SCF$', ''
        Write-Host " - $alias"
    }
}

<#
.SYNOPSIS
    One-line summary of what this function does.

.DESCRIPTION
    More detailed explanation, use cases, and what it helps with.

.PARAMETER Age
    Number of days to use for filtering (e.g., inactive objects).

.PARAMETER File
    If set, results are saved to a file in the OutputFiles folder.

.PARAMETER Count
    If set, outputs the total count of results.

.PARAMETER Domain
    The domain to target (default: Hay-Ellis.Local).

.PARAMETER Credential
    Optional credentials to run the query.

.EXAMPLE
    Get-Something -Age 90 -File -Count

.NOTES
    Author   : Ashley Hay-Ellis  
    Version  : 1.0  
    License  : MIT  
    Change History:
        YYYY-MM-DD : Initial release
#>

function Get-Something {
    [CmdletBinding()]
    param (
        [int]$Age = 180,  # Default: 180 days
        [switch]$File,    # Use as -File (true if present)
        [switch]$Count,   # Use as -Count (true if present)
        [string]$Domain = "Hay-Ellis.Local",
        [pscredential]$Credential
    )

    # Import the Active Directory module
    Import-Module ActiveDirectory

    $inactiveDate = (Get-Date).AddDays(-$age)

    #sets the date
    $OutFileDate = Get-date -Format "yyyy_MM_dd_HHmmss"

    #Specify the path for the output CSV file
    $outputFilePath = ".\OutputFiles\*filenamesomething*_${OutFileDate}.txt"


    if ($file -eq $true) {
        #write data to output
        write-host "Exported to file ${outputFilePath}" -ForegroundColor Green
    }else{
        #write data to screen only
        
    }
}
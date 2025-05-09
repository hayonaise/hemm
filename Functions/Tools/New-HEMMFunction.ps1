<#
.SYNOPSIS
    Creates a new PowerShell function from the standard HEMM template.

.DESCRIPTION
    Copies the function template from the common folder, renames the function, updates metadata, 
    and places it into the appropriate functions subfolder (e.g. network, files, etc).

.PARAMETER Name
    The name of the new function (e.g. Get-EmptyOUs).

.PARAMETER Category
    The subfolder in .\functions\ to drop the file into (e.g. activedirectory, network).

.PARAMETER Author
    Optional override for the author name.

.EXAMPLE
    .\New-HEMMFunction.ps1 -Name Get-EmptyOUs -Category activedirectory

.NOTES
    Author   : Ashley Hay-Ellis
    Version  : 1.0
    License  : MIT
#>
function New-HEMMFunction {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateSet("activedirectory", "files", "network", "misc")]
        [string]$Category,

        [string]$Author = "Ashley Hay-Ellis"
    )

    # Paths
    $TemplatePath = ".\common\FunctionTemplate.ps1"
    $TargetFolder = ".\functions\$Category"
    $TargetFile   = Join-Path $TargetFolder "$Name.ps1"

    # Check template exists
    if (-not (Test-Path $TemplatePath)) {
        Write-Error "Function template not found at $TemplatePath"
        exit 1
    }

    # Check destination folder
    if (-not (Test-Path $TargetFolder)) {
        Write-Host "Creating category folder: $TargetFolder"
        New-Item -Path $TargetFolder -ItemType Directory | Out-Null
    }

    # Copy and update content
    $templateContent = Get-Content $TemplatePath -Raw

    # Replace placeholders
    $today = Get-Date -Format yyyy-MM-dd
    $templateContent = $templateContent -replace 'function Get-Something', "function $Name"
    $templateContent = $templateContent -replace 'Get-Something', $Name
    $templateContent = $templateContent -replace 'Ashley Hay-Ellis', $Author
    $templateContent = $templateContent -replace 'YYYY-MM-DD', $today

    # Save to target
    Set-Content -Path $TargetFile -Value $templateContent -Encoding UTF8

    Write-Host "Created function: $TargetFile" -ForegroundColor Green
}
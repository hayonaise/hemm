# hemm.psm1

# Import all .ps1 files from Functions and its subfolders
Get-ChildItem -Path "$PSScriptRoot\Functions" -Recurse -Filter *.ps1 | ForEach-Object {
    . $_.FullName
}
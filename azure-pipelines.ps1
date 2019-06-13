
[CmdletBinding()]
param ()

Write-Verbose "current location: $(Get-Location)"
Write-Verbose "script root: $PSScriptRoot"
Write-Verbose "retrieve available modules"
$modules = Get-Module -list

if ($modules.name -notcontains 'Az.Accounts') {
    Install-Module 'Az.Accounts' -Scope CurrentUser -Force -SkipPublisherCheck
}
if ($modules.Name -notcontains 'Az.Resources') {
    Install-Module 'Az.Resources' -scope currentuser -force -SkipPublisherCheck
}
if ($modules.Name -notcontains 'Pester') {
    Install-Module -Name 'Pester' -Force -SkipPublisherCheck
}

Invoke-Pester -Script "./Tests/" -OutputFile "./Test-Pester.XML" -OutputFormat 'NUnitXML' -CodeCoverage "./LSECosmos/*.ps1" -PassThru

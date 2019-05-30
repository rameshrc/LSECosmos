"current location: $(Get-Location)"
"script root: $PSScriptRoot"
"retrieve available modules"
$modules = Get-Module -list

if ($modules.name -notcontains 'az.accounts') {
    Install-Module az.accounts -Scope CurrentUser -Force -SkipPublisherCheck
}
if ($modules.Name -notcontains 'az.resources') {
    Install-Module az.resources -scope currentuser -force -SkipPublisherCheck
}
if ($modules.Name -notcontains 'pester') {
    Install-Module -Name Pester -Force -SkipPublisherCheck
}

Invoke-Pester -Script "./Tests/" -OutputFile "./Test-Pester.XML" -OutputFormat 'NUnitXML' -CodeCoverage "./LSECosmos/*.ps1"
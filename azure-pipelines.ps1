"current location: $(gl)"
"script root: $PSScriptRoot"
$modules = gmo -list

if ($modules.name -notcontains 'az.accounts') {
    Install-Module az.accounts -Scope CurrentUser -Force -SkipPublisherCheck
}
if ($modules.Name -notcontains 'az.resources') {
    Install-Module az.resources -scope currentuser -force -SkipPublisherCheck
}
if ($modules.Name -notcontains 'pester') {
    Install-Module -Name Pester -Force -SkipPublisherCheck
}

# invoke-pester ./Tests/
# Invoke-Pester -Script $(System.DefaultWorkingDirectory)\MyFirstModule.test.ps1 -OutputFile $(System.DefaultWorkingDirectory)\Test-Pester.XML -OutputFormat NUnitXML
Invoke-Pester -Script ./Tests/ -OutputFile "./Test-Pester.XML" -OutputFormat 'NUnitXML' -CodeCoverage "./LSECosmos/*.ps1"
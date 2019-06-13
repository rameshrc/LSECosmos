
[CmdletBinding()]
param ()

# $analysis = Invoke-ScriptAnalyzer -Path './LSECosmos/*.ps1'
# $analysisGroups = $analysis | Group-Object 'Severity'

# if (($analysisGroups | Where-Object 'Name' -eq 'Warning').Count -gt 0 ) {
#     Write-Error ($analysis | Out-String)
#     $false
# }

# if (($analysisGroups | Where-Object 'Name' -eq 'Error').Count -gt 0 ) {
#     Write-Error ($analysis | Out-String)
#     $false
# }



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

$scriptAnalyzer = @'
Describe "Test PSScriptAnalyzer rules" {
    Context "PSScriptAnalyzer standard rules" {
        $analysis = Invoke-ScriptAnalyzer -Path "./LSECosmos/*.ps1"
        $scriptAnalyzerRules = Get-ScriptAnalyzerRule

        forEach ($rule in $scriptAnalyzerRules) {

            It "Should pass $rule" {
                If ($analysis.RuleName -contains $rule) {
                    $analysis |
                    Where-Object RuleName -EQ $rule -outvariable failures |
                    Out-Default
                    $failures.Count | Should Be 0
                }
            }
        }
    }
}
'@

Invoke-Pester -Script $scriptAnalyzer -OutputFile "./Script-Analyzer-Pester.xml" -OutputFormat 'NUnitXml' -PassThru

Invoke-Pester -Path "./Tests/" -OutputFile "./Test-Pester.XML" -OutputFormat 'NUnitXML' -CodeCoverage "./LSECosmos/*.ps1" -PassThru

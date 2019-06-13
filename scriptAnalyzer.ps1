Describe 'Test PSScriptAnalyzer rules' {
    Context 'PSScriptAnalyzer standard rules' {
        $analysis = Invoke-ScriptAnalyzer -Path './LSECosmos/*.ps1'
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
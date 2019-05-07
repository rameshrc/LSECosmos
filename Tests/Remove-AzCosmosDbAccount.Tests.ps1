Remove-Module 'LSECosmos' -Force -ErrorAction 'SilentlyContinue'
Import-Module $PSScriptRoot/../LSECosmos/LSECosmos.psm1 -Force -ErrorAction 'Stop'

Describe 'Remove-AzCosmosDbAccount' {
    InModuleScope 'LSECosmos' {
        Mock 'Remove-AzResource' -MockWith {
            return $true
        }

        It "Passing NULL to Mandatory parameters, it throws" -TestCases @(
            @{ 'AccountName' = $null; 'ResourceGroupName' = 'cosmosResourceGroup' } 
            @{ 'AccountName' = 'newcosmosaccount'; 'ResourceGroupName' = $null }
            @{ }
        ) -Test {
            param ($AccountName, $ResourceGroupName)

            { LSECosmos\Remove-AzCosmosDbAccount -AccountName $AccountName -ResourceGroupName $ResourceGroupName } | Should -Throw
        }
    }       
}
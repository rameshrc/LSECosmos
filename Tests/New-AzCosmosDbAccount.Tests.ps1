Remove-Module 'LSECosmos' -Force -ErrorAction 'SilentlyContinue'
Import-Module $PSScriptRoot/../LSECosmos/LSECosmos.psm1 -Force -ErrorAction 'Stop'

Describe 'New-AzCosmosDbAccount' {
    InModuleScope 'LSECosmos' {
        Mock -CommandName 'New-AzResource' -MockWith {
            return
        }

        Context 'Validate input parameters' {
            It "Passing NULL as <parameter> it throws" -TestCases @(
                @{ 'AccountName' = $null; 'ResourceGroupName' = 'cosmosResourceGroup'; 'Location' = 'northcentralus'; 'DisasterRecoveryLocation' = 'southcentralus' } 
                @{ 'AccountName' = 'newcosmosaccount'; 'ResourceGroupName' = $null; 'Location' = 'northcentralus'; 'DisasterRecoveryLocation' = 'southcentralus' }
                @{ 'AccountName' = 'newcosmosaccount'; 'ResourceGroupName' = 'cosmosResourceGroup'; 'Location' = $null; 'DisasterRecoveryLocation' = 'southcentralus' }
                @{ 'AccountName' = 'newcosmosaccount'; 'ResourceGroupName' = 'cosmosResourceGroup'; 'Location' = 'northcentralus'; 'DisasterRecoveryLocation' = $null }
            ) -Test {
                param ($AccountName, $ResourceGroupName, $Location, $DisasterRecoveryLocation)

                LSECosmos\New-AzCosmosDbAccount -AccountName $AccountName -ResourceGroupName $ResourceGroupName -Location $Location -DisasterRecoveryLocation $DisasterRecoveryLocation | Should -Throw
            }
        }
    }
}
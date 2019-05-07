Remove-Module 'LSECosmos' -Force -ErrorAction 'SilentlyContinue'
Import-Module $PSScriptRoot/../LSECosmos/LSECosmos.psm1 -Force -ErrorAction 'Stop'

Describe 'Get-AzCosmosDbAccount' {
    InModuleScope 'LSECosmos' {
        Mock -CommandName 'Get-AzResource' -MockWith {
            # make sure to return the proper object type
            $generic = [Microsoft.Azure.Management.ResourceManager.Models.GenericResource]::new()
            $resource = [Microsoft.Azure.Commands.ResourceManager.Cmdlets.SdkModels.PSResource]::new($generic)
            $resource.Name = 'mycosmosaccount'
            $resource.ResourceGroupName = 'mycosmosaccountRG'
            $resource.ResourceType = 'Microsoft.DocumentDb/databaseAccounts'
            $resource.Location = 'northcentralus'
            $resource.ResourceId = '/subscriptions/f897c2fa-a735-4e03-b019-890cd2f7109e/resourceGroups/mycosmosaccountRG/providers/Microsoft.DocumentDb/databaseAccounts/mycosmosaccount'

            return $resource
        }

        Context "Without input parameters" {
            It "Should return a 'Microsoft.Azure.Commands.ResourceManager.Cmdlets.SdkModels.PSResource' object type" {
                LSECosmos\Get-AzCosmosDbAccount | Should -BeOfType 'Microsoft.Azure.Commands.ResourceManager.Cmdlets.SdkModels.PSResource'
            }

            it "Should return exactly one object" {
                LSECosmos\Get-AzCosmosDbAccount | Should -HaveCount 1
            }
        }

        Context "Filter by AccountName" {
            It "Given valid AccountName <Filter> it returns <Expected>" -TestCases @(
                @{'Filter' = 'mycosmosaccount'; 'Expected' = 'mycosmosaccount' }
                @{'Filter' = 'mycosmosac*'; 'Expected' = 'mycosmosaccount' }
                @{'Filter' = '*cosmosac*'; 'Expected' = 'mycosmosaccount' }
                @{'Filter' = '*osaccount'; 'Expected' = 'mycosmosaccount' }
            ) -Test {
                param ($Filter, $Expected)

                $account = LSECosmos\Get-AzCosmosDbAccount -AccountName $Filter
                $account.AccountName | Should -Be 'mycosmosaccount'
            }

            It 'Given invalid AccountName "nonexisting" it returns NULL' {
                $account = LSECosmos\Get-AzCosmosDbAccount -AccountName 'nonexisting'
                $account.AccountName | Should -BeNullOrEmpty
            }
        }
    }
}
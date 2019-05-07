Remove-Module 'LSECosmos' -Force -ErrorAction 'SilentlyContinue'
Import-Module $PSScriptRoot/../LSECosmos/LSECosmos.psm1 -Force -ErrorAction 'Stop'

Describe 'Get-AzCosmosDbAccountKey' {
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

        Mock -CommandName 'Invoke-AzResourceAction' -MockWith {
            [PSCustomObject]@{
                'AccountName'                = 'mycosmosaccount';
                'PrimaryMasterKey'           = 'xxxxx';
                'PrimaryReadonlyMasterKey'   = 'xxxxx';
                'SecondaryMasterKey'         = 'xxxxx';
                'SecondaryReadonlyMasterKey' = 'xxxxx';
            }
        }

        Context "Validate Parameters" {
            It 'Validate AccountName' {
                (Get-AzCosmosDbAccount | Get-AzCosmosDbAccountKey).AccountName | Should -BeExactly 'mycosmosaccount'
            }
            it 'Validate PrimaryMasterKey' {
                (Get-AzCosmosDbAccount | Get-AzCosmosDbAccountKey).PrimaryMasterKey | Should -BeExactly 'xxxxx'
            }
            it 'Validate PrimaryReadonlyMasterKey' {
                (Get-AzCosmosDbAccount | Get-AzCosmosDbAccountKey).PrimaryReadonlyMasterKey | Should -BeExactly 'xxxxx'
            }
            it 'Validate SecondaryMasterKey' {
                (Get-AzCosmosDbAccount | Get-AzCosmosDbAccountKey).SecondaryMasterKey | Should -BeExactly 'xxxxx'
            }
            it 'Validate SecondaryReadonlyMasterKey' {
                (Get-AzCosmosDbAccount | Get-AzCosmosDbAccountKey).SecondaryReadonlyMasterKey | Should -BeExactly 'xxxxx'
            }
        }
    }
}
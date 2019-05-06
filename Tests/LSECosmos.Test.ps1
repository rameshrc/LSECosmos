Import-Module ./LSECosmos/LSECosmos.psm1 -Force -ErrorAction 'Stop'

Describe 'Get-AzCosmosDbAccount' {

    Mock -CommandName 'Get-AzResource' -MockWith {
        New-MockObject -Type 'Microsoft.Azure.Commands.ResourceManager.Cmdlets.SdkModels.PSResource' @{
            'Name'              = 'mycosmosaccount';
            'ResourceGroupName' = 'mycosmosaccountRG';
            'ResourceType'      = 'Microsoft.DocumentDb/databaseAccounts';
            'Location'          = 'northcentralus';
            'ResourceId'        = '/subscriptions/f897c2fa-a735-4e03-b019-890cd2f7109e/resourceGroups/mycosmosaccountRG/providers/Microsoft.DocumentDb/databaseAccounts/mycosmosaccount'
        }
    } -Verifiable

    Context "Without input parameters" {
        It "Should return a PSCustomObject object type" {
            # Get-AzCosmosDbAccount | Should -BeOfType [pscustomobject]
            Get-AzCosmosDbAccount | Should -BeOfType 'Microsoft.Azure.Commands.ResourceManager.Cmdlets.SdkModels.PSResource'
        }

        it "Should return exactly one object" {
            Get-AzCosmosDbAccount | Should -HaveCount 1
        }
    }

    Context "Filter by AccountName" {
        It "Given valid -AccountName <Filter> it returns <Expected>" -TestCases @(
            @{'Filter' = 'mycosmosaccount'; 'Expected' = 'mycosmosaccount' }
            @{'Filter' = 'mycosmosac*'; 'Expected' = 'mycosmosaccount' }
            @{'Filter' = '*cosmosac*'; 'Expected' = 'mycosmosaccount' }
            @{'Filter' = '*osaccount'; 'Expected' = 'mycosmosaccount' }
        ) {
            param ($Filter, $Expected)

            $account = Get-AzCosmosDbAccount -AccountName $Filter
            $account.Name | Should -Be 'mycosmosaccount'
        }

        It 'Invalid account name, should return null' {
            $account = Get-AzCosmosDbAccount -AccountName 'nonexisting'
            $account.AccountName | Should -BeNullOrEmpty
        }
    }
}
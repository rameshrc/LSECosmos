Remove-Module 'LSECosmos' -Force -ErrorAction 'SilentlyContinue'
Import-Module $PSScriptRoot/../LSECosmos/LSECosmos.psm1 -Force -ErrorAction 'Stop'

Describe 'Get-AzCosmosDbDatabase' {
    InModuleScope 'LSECosmos' {
        Mock 'Get-AzResource' -MockWith {
            # make sure to return the proper object type
            $generic = [Microsoft.Azure.Management.ResourceManager.Models.GenericResource]::new()
            $resource = [Microsoft.Azure.Commands.ResourceManager.Cmdlets.SdkModels.PSResource]::new($generic)
            $resource.Name = 'carloccosmos'
            $resource.ResourceGroupName = 'cosmosrg'
            $resource.Properties = [pscustomobject]@{
                'Id'     = 'Database1';
                '_rid'   = 'xxxxxxxx';
                '_self'  = 'xxxxxxxxxxxxx';
                '_etag'  = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx';
                '_colls' = 'colls/';
                '_users' = 'users/';
                '_ts'    = 'xxxxxxxxxx'
            }
            $resource
        }

        Context 'Without input parameters should return one object' {
            it "Should return exactly one object" {
                LSECosmos\Get-AzCosmosDbDatabase -AccountName 'carloccosmos' -ResourceGroupName 'cosmosrg' | Should -HaveCount 1
            }

            it 'Searchig for a non existing database, it should not return anything' {
                LSECosmos\Get-AzCosmosDbDatabase -AccountName 'carloccosmos' -ResourceGroupName 'cosmosrg' -Name 'nonexistingdatabase' | Should -BeNullOrEmpty
            }
        }
    }
}
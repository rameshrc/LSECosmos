function Get-AzCosmosDbAccountKey {
    <#
    .SYNOPSIS
        Returns the Primary and Secondary keys for a Cosmos DB account
    
    .EXAMPLE
        Get-AzCosmosDbAccountKey -Name 'mycosmosdbaccount' -ResourceGroupName='mycosmosRG'
    
    .NOTES
        https://docs.microsoft.com/en-us/azure/cosmos-db/manage-account-with-powershell
    #>
    [CmdletBinding()]
    param (
        [parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('AccountName')]
        [string]$Name,

        [parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$ResourceGroupName
    )

    process {
        $keys = $null
        $keys = Invoke-AzResourceAction -Action 'listKeys' -ResourceType "Microsoft.DocumentDb/databaseAccounts" -ApiVersion "2016-03-31" -ResourceGroupName $ResourceGroupName -Name $Name -Force

        if ($keys) {

            [PSCustomObject]@{
                'Name'               = $Name;
                'PrimaryMasterKey'   = $keys.primaryMasterKey;
                'SecondaryMasterKey' = $keys.secondaryMasterKey
            }
        }
        else {
            Write-Error $Error[0]
        }

        $keys = $null
    }
}

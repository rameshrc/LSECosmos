function Get-AzCosmosDbAccountKey {
    <#
    .SYNOPSIS
        Returns the Primary and Secondary keys for a Cosmos DB account

    .PARAMETER AccountName
        CosmosDb Account Name

    .PARAMETER ResourceGroupName
        Resource Group to contain the new CosmosDb Account

    .EXAMPLE
        Get-AzCosmosDbAccountKey -AccountName mycosmosdbaccount -ResourceGroupName mycosmosdbaccountRG

        AccountName             PrimaryMasterKey         SecondaryMasterKey
        ----                    ----------------         ------------------
        carloctestcosmosaccount xxxxx                    xxxxx

    .EXAMPLE
        Get-AzCosmosDbAccount -AccountName mycosmos* | Get-AzCosmosDbAccountKey | Format-List

        AccountName        : mycosmosdbaccount
        PrimaryMasterKey   : xxxxx
        SecondaryMasterKey : xxxxx

    .NOTES
        This function uses Get-AzResource -ApiVersion '2016-03-31'
    #>
    [CmdletBinding()]
    param (
        [parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$AccountName,

        [parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$ResourceGroupName
    )

    process {
        $keys = $null
        $keys = Invoke-AzResourceAction -Action 'listKeys' -ResourceType "Microsoft.DocumentDb/databaseAccounts" -ApiVersion "2016-03-31" -ResourceGroupName $ResourceGroupName -Name $AccountName -Force

        if ($keys) {
            [PSCustomObject]@{
                'AccountName'        = $AccountName;
                'PrimaryMasterKey'   = $keys.primaryMasterKey;
                'SecondaryMasterKey' = $keys.secondaryMasterKey
            }
        }

        $keys = $null
    }
}

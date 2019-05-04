function Get-AzCosmosDbAccountKey {
    <#
    .SYNOPSIS
        Returns the Primary and Secondary keys for a Cosmos DB account

    .PARAMETER Name
        CosmosDb Account Name

    .PARAMETER ResourceGroupName
        Resource Group to contain the new CosmosDb Account
    
    .EXAMPLE
        Get-AzCosmosDbAccountKey -Name mycosmosdbaccount -ResourceGroupName mycosmosdbaccountRG

        Name                    PrimaryMasterKey         SecondaryMasterKey
        ----                    ----------------         ------------------
        carloctestcosmosaccount xxxxx                    xxxxx           

    .EXAMPLE
        Get-AzCosmosDbAccount -Name mycosmos* | Get-AzCosmosDbAccountKey | Format-List

        Name               : mycosmosdbaccount
        PrimaryMasterKey   : xxxxx
        SecondaryMasterKey : xxxxx

    .NOTES
        This function uses Get-AzResource -ApiVersion '2016-03-31'
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

        $keys = $null
    }
}

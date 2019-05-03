function Get-AzCosmosDbAccountKey {
    <#
    .SYNOPSIS
        Returns the Primary and Secondary keys for a Cosmos DB account

    .EXAMPLE
        Get-AzCosmosDbAccountKey -Name mycosmosdbaccount -ResourceGroupName mycosmosdbaccountRG

        Name                    PrimaryMasterKey                                                                         SecondaryMasterKey
        ----                    ----------------                                                                         ------------------
        carloctestcosmosaccount wdWZokK3Bx0UEj4sVQ9QjkEX3UUrwjivqZeXKWKReBQXszKl1qWde5PURcXn3VCgBf1XNoOhNjDYrl09DT9MRw== nZgiW1ycgHAvXcd3X4kOjMlxG27qUxp3uRweYYiQ7fwTuM3N7WXFPIzFm1I4nP8BzKhmAdO02VC6RptbMI7Ahw==

    .EXAMPLE
        Get-AzCosmosDbAccount -Name mycosmos* | Get-AzCosmosDbAccountKey | Format-List

        Name               : mycosmosdbaccount
        PrimaryMasterKey   : wdWZokK3Bx0UEj4sVQ9QjkEX3UUrwjivqZeXKWKReBQXszKl1qWde5PURcXn3VCgBf1XNoOhNjDYrl09DT9MRw==
        SecondaryMasterKey : nZgiW1ycgHAvXcd3X4kOjMlxG27qUxp3uRweYYiQ7fwTuM3N7WXFPIzFm1I4nP8BzKhmAdO02VC6RptbMI7Ahw==

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
        else {
            Write-Error $Error[0]
        }

        $keys = $null
    }
}

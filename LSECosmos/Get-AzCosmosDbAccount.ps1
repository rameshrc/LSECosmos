function Get-AzCosmosDbAccount {
    <#
    .SYNOPSIS
    Returns information about CosmosDB accounts in the current subscription. 
    You can pass a single Account name or ResourceGroup name
    
    .PARAMETER AccountName
    CosmosDB Account name to return information for
    Accepts wildcards
    
    .PARAMETER ResourceGroupName
    Resource Group containing the CosmosDB account to look for
    Accepts wildcards
    
    .EXAMPLE
    Get-AzCosmosDbAccount -AccountName mycosmos*

    AccountName       : mycosmosaccount
    ResourceGroupName : mycosmosaccountRG
    ResourceType      : Microsoft.DocumentDb/databaseAccounts
    Location          : northcentralus
    ResourceId        : /subscriptions/f897c2fa-a735-4e03-b019-890cd2f7109e/resourceGroups/mycosmosaccountRG/providers/Microsoft.DocumentDb/databaseAccounts/mycosmosaccount

    .NOTES
    This function uses Get-AzResource -ApiVersion '2018-11-01'
    #>
    
    [CmdletBinding()]
    param (
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Position = 1)]
        [string]$AccountName = '*',

        [parameter(ValueFromPipelineByPropertyName, Position = 2)]
        [string]$ResourceGroupName = '*'
    )

    process {
        Get-AzResource -ResourceType 'Microsoft.DocumentDb/databaseAccounts' -ApiVersion '2018-11-01' | Where-Object 'ResourceGroupName' -Like $ResourceGroupName | Where-Object 'Name' -Like $AccountName | Select-Object -Property *, @{l = 'AccountName'; e = { $_.Name } }  -ExcludeProperty 'Name'
    }
}
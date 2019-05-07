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
        $resources = $null
        $resources = Get-AzResource -ResourceType 'Microsoft.DocumentDb/databaseAccounts' -ApiVersion '2018-11-01' | Where-Object 'ResourceGroupName' -Like $ResourceGroupName | Where-Object 'Name' -Like $AccountName

        # for consistency and make pipeline use easier, I'm adding a new properly 'AccountName';
        # this notation is needed to maintain the object type.
        # we could have piped the previous command to Select-Object and add the new property @{l='AccountName';e={$_.Name}}
        # anyway that syntax would have returned a generic PSCustomObject type
        $res = $null
        foreach ($res in $resources) {
            $res | Add-Member -Name 'AccountName' -MemberType 'NoteProperty' -TypeName [System.String] -Value $res.Name
            return $res
        }
    }
}
function Get-AzCosmosDbDatabase {
    <#
    .SYNOPSIS
    Lists the Cosmos databases under the given Cosmos Account
    
    .PARAMETER AccountName
    Cosmos Account to query
    
    .PARAMETER ResourceGroupName
    Resource Group containing the Cosmos Account to query
    
    .PARAMETER Name
    Cosmos Account name
    
    .EXAMPLE
    Get-AzCosmosDbAccount -ResourceGroupName cosmosdb | Get-AzCosmosDbDatabase

    id     : testcosmosdb
    _rid   : axQVAA==
    _self  : dbs/axQVAA==/
    _etag  : "0000a300-0000-0300-0000-5d007b280000"
    _colls : colls/
    _users : users/
    _ts    : 1560312616

    This command lists all Cosmos Accounts under the Resource Group 'cosmosdb' and lists their databases
    
    .NOTES
    # Microsoft.DocumentDB/databaseAccounts/apis/databases/read
    #>
    [CmdletBinding()]
    param (
        [parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$AccountName,

        [parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$ResourceGroupName,

        [parameter()]
        [Alias('DatabaseName', 'Id')]
        [string]$Name = '*'
    )

    process {
        $outObj = Get-AzResource -ResourceType "Microsoft.DocumentDb/databaseAccounts/apis/databases" -ApiVersion "2015-04-08" -ResourceGroupName $ResourceGroupName -Name "$AccountName/sql/" #| Select-Object -ExpandProperty 'Properties'

        if ($Name -eq '*') {
            $outObj.Properties
        }
        else {
            $outObj.Properties | Where-Object 'Id' -EQ $Name
        }
    }
}
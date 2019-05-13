function Get-AzCosmosDbDatabase {
    # Microsoft.DocumentDB/databaseAccounts/apis/databases/read
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
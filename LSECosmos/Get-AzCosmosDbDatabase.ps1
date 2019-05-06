function Get-AzCosmosDbDatabase {
    # Microsoft.DocumentDB/databaseAccounts/apis/databases/read
    [CmdletBinding()]
    param (
        [parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$AccountName,

        [parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$ResourceGroupName,

        [parameter()]
        [Alias('DatabaseName')]
        [string]$Name = '*'
    )

    process {
        Invoke-AzResourceAction -ResourceName $AccountName -ResourceGroupName $ResourceGroupName -ResourceType 'Microsoft.DocumentDB/databaseAccounts/apis/databases' -Action 'read' -ApiVersion '2016-03-31' -Force
    }
}
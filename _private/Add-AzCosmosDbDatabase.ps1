function Add-AzCosmosDbDatabase {
    [CmdletBinding()]
    param (
        [parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$AccountName,

        [parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$ResourceGroupName,

        [parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('DatabaseName')]
        [string]$Name
    )

    process {
        # Microsoft.DocumentDB/databaseAccounts/apis/databases/write
        
    }
}
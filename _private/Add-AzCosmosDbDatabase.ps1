function Add-AzCosmosDbDatabase {
    # Microsoft.DocumentDB/databaseAccounts/apis/databases/write
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$AccountName,

        [parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$ResourceGroupName,

        [parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('DatabaseName')]
        [string]$Name,

        [parameter()]
        [switch]$Force
    )

    process {
        $resourceName = $accountName + "/sql/" + $databaseName

        $DataBaseProperties = @{
            "resource" = @{"id" = $databaseName }
        } 

        if ($Force -or ($PSCmdlet.ShouldProcess($AccountName, "Create database $Name"))) {
            if ($Force -or ($PSCmdlet.ShouldContinue("Create database $Name on account $AccountName?", "Create database $Name"))) {
                New-AzResource -ResourceType "Microsoft.DocumentDb/databaseAccounts/apis/databases" `
                    -ApiVersion "2015-04-08" -ResourceGroupName $resourceGroupName `
                    -Name $resourceName -PropertyObject $DataBaseProperties
            }
        }
    }
}
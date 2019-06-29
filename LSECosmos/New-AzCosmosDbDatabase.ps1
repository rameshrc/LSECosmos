[CmdletBinding()]
param (
    [parameter(Mandatory, ValueFromPipelineByPropertyName)]
    [string]$AccountNAme,
    
    [parameter(Mandatory, ValueFromPipelineByPropertyName)]
    [string]$ResourceGroupName,

    [parameter(Mandatory, ValueFromPipelineByPropertyName)]
    [Alias('Name')]
    [string]$DatabaseName
)


# Microsoft.DocumentDB/databaseAccounts/apis/databases/write
# https://docs.microsoft.com/en-us/azure/cosmos-db/scripts/powershell/sql/ps-sql-create?toc=%2fpowershell%2fmodule%2ftoc.json

$location = Get-AzResourceGroup -Name $ResourceGroupName | Select-Object -ExpandProperty 'Location'

$locations = @(
    @{ "locationName" = "West US"; "failoverPriority" = 0 },
    @{ "locationName" = "East US"; "failoverPriority" = 1 }
)

$consistencyPolicy = @{
    "defaultConsistencyLevel" = "BoundedStaleness";
    "maxIntervalInSeconds"    = 300;
    "maxStalenessPrefix"      = 100000
}

$CosmosDBProperties = @{
    "databaseAccountOfferType"     = "Standard";
    "locations"                    = $locations;
    "consistencyPolicy"            = $consistencyPolicy;
    "enableMultipleWriteLocations" = "true"
}

New-AzResource -ResourceType "Microsoft.DocumentDb/databaseAccounts" `
    -ApiVersion "2015-04-08" -ResourceGroupName $ResourceGroupName -Location $location `
    -Name $AccountNAme -PropertyObject $CosmosDBProperties


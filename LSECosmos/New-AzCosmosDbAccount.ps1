function New-AzCosmosDbAccount {
    <#
    .SYNOPSIS
    Create a new CosmosDb account
    
    .PARAMETER AccountName
    CosmosDb Account Name
    
    .PARAMETER ResourceGroupName
    Resource Group to contain the new CosmosDb Account
    
    .PARAMETER Location
    Location where to create the new CosmosDb Account
    
    .PARAMETER DRLocation
    Disaster Recover (failover) location for the new CosmosDb Account
    
    .EXAMPLE
    New-AzCosmosDbAccount -AccountName carloctestcosmosaccount -ResourceGroupName carloctestrg -Location centralus -DisasterRecoveryLocation southcentralus
    #>
    [CmdletBinding()]
    param (
        [parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$AccountName,
    
        [parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$ResourceGroupName,

        [parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Location,
    
        [parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$DisasterRecoveryLocation
    )

    $locations = @(
        @{"locationName"       = $Location; 
            "failoverPriority" = 0
        }, 
        @{"locationName"       = $DisasterRecoveryLocation; 
            "failoverPriority" = 1
        }
    )

    $consistencyPolicy = @{
        "defaultConsistencyLevel" = "Session";
        "maxIntervalInSeconds"    = "5"; 
        "maxStalenessPrefix"      = "100"
    }

    $DBProperties = @{
        "databaseAccountOfferType" = "Standard"; 
        "locations"                = $locations; 
        "consistencyPolicy"        = $consistencyPolicy; 
    }

    New-AzResource -ResourceType "Microsoft.DocumentDb/databaseAccounts" `
        -ApiVersion "2015-04-08" `
        -ResourceGroupName $ResourceGroupName `
        -Location $Location `
        -Name $AccountName `
        -PropertyObject $DBProperties `
        -Force
}
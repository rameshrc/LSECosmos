
# https://docs.microsoft.com/en-us/azure/cosmos-db/scripts/powershell/sql/ps-sql-create?toc=%2fpowershell%2fmodule%2ftoc.json


$containerProperties = @{
    "resource" = @{
        "id"                       = $containerName; 
        "partitionKey"             = @{
            "paths" = @("/myPartitionKey"); 
            "kind"  = "Hash"
        }; 
        "indexingPolicy"           = @{
            "indexingMode"  = "Consistent"; 
            "includedPaths" = @(@{
                    "path"    = "/*";
                    "indexes" = @(@{
                            "kind"      = "Range";
                            "dataType"  = "number";
                            "precision" = -1
                        },
                        @{
                            "kind"      = "Range";
                            "dataType"  = "string";
                            "precision" = -1
                        }
                    )
                });
            "excludedPaths" = @(@{
                    "path" = "/myPathToNotIndex/*"
                })
        };
        "uniqueKeyPolicy"          = @{
            "uniqueKeys" = @(@{
                    "paths" = @(
                        "/myUniqueKey1";
                        "/myUniqueKey2"
                    )
                })
        };
        "defaultTtl"               = 100;
        "conflictResolutionPolicy" = @{
            "mode"                   = "lastWriterWins"; 
            "conflictResolutionPath" = "/myResolutionPath"
        }
    };
    "options"  = @{ "Throughput" = 400 }
} 

New-AzResource -ResourceType "Microsoft.DocumentDb/databaseAccounts/apis/databases/containers" `
    -ApiVersion "2015-04-08" -ResourceGroupName $resourceGroupName `
    -Name $containerResourceName -PropertyObject $containerProperties


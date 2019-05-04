function Remove-AzCosmosDbAccount {
    <#
        .SYNOPSIS
        Short description
        
        .PARAMETER Name
        CosmosDb Account Name    
        
        .PARAMETER ResourceGroupName
        Resource Group to contain the new CosmosDb Account    
        
        .PARAMETER Force
        Suppress confirmation prompt
        
        .EXAMPLE
        Get-AzCosmosDbAccount | Remove-AzCosmosDbAccount -Force
        
        .EXAMPLE
        Remove-AzCosmosDbAccount -Name carloctestcosmosaccount -ResourceGroupName carloctestcosmosaccountRG -Force
    #>
    
    [CmdletBinding(ConfirmImpact = 'High', SupportsShouldProcess)]
    param (
        [parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('AccountName')]
        [string]$Name,

        [parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$ResourceGroupName,

        [parameter()]
        [switch]$Force
    )

    process {
        if ($Force -or ($PSCmdlet.ShouldProcess($Name, 'Remove CosmosDb Account'))) {
            if ($Force -or ($PSCmdlet.ShouldContinue("Remove CosmosDb Account $Name?", 'Confirm remove CosmosDb Account'))) {
                Remove-AzResource -ResourceName $Name -ResourceGroupName $ResourceGroupName -ResourceType "Microsoft.DocumentDb/databaseAccounts" -Force
            }
        }
    }
}
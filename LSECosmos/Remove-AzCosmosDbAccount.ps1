function Remove-AzCosmosDbAccount {
    <#
        .SYNOPSIS
        Short description

        .PARAMETER AccountName
        CosmosDb Account Name

        .PARAMETER ResourceGroupName
        Resource Group to contain the new CosmosDb Account

        .PARAMETER Force
        Suppress confirmation prompt

        .EXAMPLE
        Get-AzCosmosDbAccount | Remove-AzCosmosDbAccount -Force

        .EXAMPLE
        Remove-AzCosmosDbAccount -AccountName carloctestcosmosaccount -ResourceGroupName carloctestcosmosaccountRG -Force
    #>

    [CmdletBinding(ConfirmImpact = 'High', SupportsShouldProcess)]
    param (
        [parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$AccountName,

        [parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$ResourceGroupName,

        [parameter()]
        [switch]$Force
    )

    process {
        if ($Force -or ($PSCmdlet.ShouldProcess($AccountName, 'Remove CosmosDb Account'))) {
            if ($Force -or ($PSCmdlet.ShouldContinue("Remove CosmosDb Account $AccountName?", 'Confirm remove CosmosDb Account'))) {
                Remove-AzResource -ResourceName $AccountName -ResourceGroupName $ResourceGroupName -ResourceType "Microsoft.DocumentDb/databaseAccounts" -Force
            }
        }
    }
}
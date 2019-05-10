[![Build Status](https://carlocardella.visualstudio.com/LSECosmos%20to%20Powershell%20Gallery/_apis/build/status/carlocardella.LSECosmos?branchName=master)](https://carlocardella.visualstudio.com/LSECosmos%20to%20Powershell%20Gallery/_build/latest?definitionId=6&branchName=master)

# LSECosmos
[CloudNotes.io](https://www.cloudnotes.io)

## Prequisites

- Powershell Core: (https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-6)
- Azure "Az" modules: (https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-1.8.0)

## Installation

### Windows

Download the zip file or cloune the repo locally: copy the LSECosmos folder under `$env:PSUserProfile\Documents\WindowsPowershell\Modules` folder

### macOS

Download the zip file or cloune the repo locally: copy the LSECosmos folder under `/Users/<user>/.local/share/powershell/Modules/` folder

## Credits

- Thanks to [Stephane Lapointe](https://www.linkedin.com/in/stephanelapointe/) for this script to [get the Bearer Token from an existing Powershell session](https://gallery.technet.microsoft.com/scriptcenter/Easily-obtain-AccessToken-3ba6e593/view/Reviews) that I reused as base for my `Get-AzAccessToken`

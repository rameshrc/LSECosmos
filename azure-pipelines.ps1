"current location: $(gl)"
"script root: $PSScriptRoot"
install-module az.accounts -Scope CurrentUser -Force
install-module az.resources -scope currentuser -force
install-module pester -scope currentuser -force
# gmo -list

invoke-pester ./LSECosmos/Tests
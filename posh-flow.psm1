#####################################################################
# posh-flow requires posh-git
#####################################################################
if(-not(@(Get-Module posh-git).Length -eq 1))
{
    Write-Host "Module 'posh-git' must be imported."
    return
}

. (Join-Path ((Get-Module posh-git).Path | Split-Path) Utils.ps1)
. (Join-Path ((Get-Module posh-git).Path | Split-Path) GitUtils.ps1)

Export-ModuleMember -Function Get-GitBranch
#####################################################################

Resolve-Path $PSScriptRoot\*.ps1 `
    | ?{ -not($_.ProviderPath.Contains(".tests.")) } `
    | %{ . $_.ProviderPath }

Export-ModuleMember -Function Init-GitFlow
Export-ModuleMember -Function Start-Feature
Export-ModuleMember -Function Finish-Feature
Export-ModuleMember -Function Start-Release
Export-ModuleMember -Function Finish-Release
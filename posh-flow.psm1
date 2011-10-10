####################################################################################################
# Import scripts and utility functions from posh-git
####################################################################################################
$local = Split-Path -Parent $MyInvocation.MyCommand.Path

. "$local\..\posh-git\Utils.ps1"
. "$local\..\posh-git\GitUtils.ps1"

Export-ModuleMember -Function Get-GitBranch
Export-ModuleMember -Function Get-GitDirectory
####################################################################################################

$featureBranchFormat = "feature/{0}"
$releaseBranchFormat = "release-{0}"

$versionFilepath = "VERSION"

function Format-FeatureBranch {
    param(
        [parameter(Mandatory = $true)]
        [string] $name
    )
    
    $featureBranchFormat -f $name
}

function Format-ReleaseBranch {
    param(
        [parameter(Mandatory = $true)]
        [string] $version
    )
    
    $releaseBranchFormat -f $version
}

Export-ModuleMember -Function Init-GitFlow
Export-ModuleMember -Function Start-Feature
Export-ModuleMember -Function Finish-Feature
Export-ModuleMember -Function Start-Release
Export-ModuleMember -Function Finish-Release
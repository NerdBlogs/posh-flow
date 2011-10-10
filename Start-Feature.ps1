<#
    .SYNOPSIS
    Start a new feature branch from the 'develop' branch.
    
    .DESCRIPTION
    Feature branches are used to devleop new features for upcoming releases. The feature branch exists as long as the 
    feature is in development. It will eventually be merged back to the 'develop' branch (or discarded) and the feature
    branch will be deleted.
    
    .PARAMETER name
    The name of the feature to start.
    
    .NOTES
    Feature branches typically exist only in developer repositories and not in the 'origin'.
#>
function Start-Feature {
    param(
        [parameter(Mandatory = $true)]
        [string] $name
    )
    
    $featureBranch = (Format-FeatureBranch $name)
    git checkout -b $featureBranch develop
}
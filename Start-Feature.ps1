$featureBranchFormat = "feature/{0}"

function Format-FeatureBranch 
{
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $name
    )
    
    $featureBranchFormat -f $name
}

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
function Start-Feature 
{
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $name
    )
    
    $featureBranch = (Format-FeatureBranch $name)
    git checkout -b $featureBranch develop
}

<#
    .SYNOPSIS
    Merge a feature branch with 'develop' and delete the feature branch.
    
    .DESCRIPTION
    Finished features will be merged back into the 'develop' branch and pushed to the 'origin/develop'. The feature
    branch will then be deleted. This function uses '--no-ff' by default (look it up!).
    
    .PARAMETER name
    The name of the feature to finish.
    
    .NOTES
    I'd like to make $name optional. If you are currently in a feature branch, this function could simply finish that
    feature.
#>
function Finish-Feature 
{
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $name
    )
    
    $featureBranch = (Format-FeatureBranch $name)
    
    git checkout develop
    git merge --no-ff $featureBranch
    git branch -d $featureBranch
    
    # TODO: check for remote/develop first
    git push origin develop
}
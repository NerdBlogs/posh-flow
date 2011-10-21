$branchFormat = "feature/{0}"

function Format-FeatureBranch 
{
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $name
    )
    
    $branchFormat -f $name
}

<#
    .SYNOPSIS
    Start a new feature branch from the 'develop' branch.
    
    .DESCRIPTION
    Feature branches are used to devleop new features for upcoming 
    releases. The feature branch exists as long as the feature is 
    in development. It will eventually be merged back to the 
    'develop' branch (or discarded) and the feature branch will be 
    deleted.
    
    .PARAMETER name
    The name of the feature to start.
    
    .NOTES
    Feature branches typically exist only in developer repositories 
    and not in the 'origin'.
#>
function Start-Feature 
{
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $name
    )
    
    $branch = (Format-FeatureBranch $name)
    git checkout -b $branch develop
}

<#
    .SYNOPSIS
    Merge a feature branch with 'develop' and delete the feature 
    branch.
    
    .DESCRIPTION
    Finished features will be merged back into the 'develop' branch 
    and pushed to the 'origin/develop'. The feature branch will then 
    be deleted. This function uses '--no-ff' by default.
    
    .PARAMETER name
    The name of the feature to finish.
#>
function Finish-Feature 
{
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $name
    )
    
    # TODO: if you're already in a feature branch, just go for it!
    $branch = (Format-FeatureBranch $name)
    
    git checkout develop
    git merge --no-ff $branch
    git branch -d $branch
    
    # TODO: check for remote/develop first
    git push origin develop
}
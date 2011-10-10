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
function Finish-Feature {
    param(
        [parameter(Mandatory = $true)]
        [string] $name
    )
    
    $featureBranch = (Format-FeatureBranch $name)
    
    git checkout develop
    git merge --no-ff $featureBranch
    git branch -d $featureBranch
    
    # TODO: check for remote/develop first
    git push origin develop
}
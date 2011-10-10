<#
    .SYNOPSIS
    Merge a release branch with 'develop' and 'master' and delete the release branch.
    
    .DESCRIPTION
    When the release branch is ready to become a real release, it is merged with 'master' and 'master' is tagged with 
    the version number. The branch is also merged with 'develop'. The release is done, so the branch is deleted.
    
    .PARAMETER version
    The version of the release to finish.
    
    .NOTES
    I'd like to make $version optional. If you are currently in a release branch, this function could simply finish 
    that release.
#>
function Finish-Release {
    param(
        [parameter(Mandatory = $true)]
        [string] $version
    )
    
    $releaseBranch = (Format-ReleaseBranch $version)
    
    git checkout master
    git merge --no-ff $releaseBranch
    git tag -a -m "released $version" $version
    
    # TODO: check for remote/master first
    git push origin master
    
    git checkout develop
    git merge --no-ff $releaseBranch
    git branch -d $releaseBranch
    
    # TODO: check for remote/develop first
    git push origin develop
}
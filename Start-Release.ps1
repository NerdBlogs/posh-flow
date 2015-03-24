<#
    .SYNOPSIS
    Start a new release branch from the 'develop' branch.
    
    .DESCRIPTION
    Release branches support preparation of a new production release 
    (minor bug fixes, preparing metadata, etc). By doing all of this 
    in a release branch, the 'develop' branch is clear to receive 
    features for the next release. At exactly the start of the 
    release branch, the release will be assigned a version number 
    (in the 'VERSION' file).
    
    .PARAMETER version
    The version of the release to start.
#>
function Start-Release 
{ 
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $version
    )
    
    # TODO: implement default patch ver increment
    # TODO: implement -major, -minor switches
    $branch = "release-$version"
    
    git checkout -b $branch
    
    Set-Content "VERSION" $version
    git add "VERSION"
    git commit -a -m "set version to $version"
}

<#
    .SYNOPSIS
    Merge a release branch with 'develop' and 'master' and delete the 
    release branch.
    
    .DESCRIPTION
    When the release branch is ready to become a real release, it is 
    merged with 'master' and 'master' is tagged with the version 
    number. The branch is also merged with 'develop'. The release is 
    done, so the branch is deleted.
    
    .PARAMETER version
    The version of the release to finish.
#>
function Finish-Release 
{
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $version
    )
    
    # TODO: if you're in a release branch, just do it!
    $branch = "release-$version"
    
    git checkout master
    git merge --no-ff $branch
    git tag -a -m "released $version" $version
    
    # TODO: check for remote/master first
    git push origin master
    
    git checkout develop
    git merge --no-ff $branch
    git branch -d $branch
    
    # TODO: check for remote/develop first
    git push origin develop
}
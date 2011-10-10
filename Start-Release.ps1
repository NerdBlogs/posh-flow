$releaseBranchFormat = "release-{0}"
$versionFilepath = "VERSION"

# TODO: implement default patch ver increment
# TODO: implement -major, -minor switches
function Format-ReleaseBranch 
{
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $version
    )
    
    $releaseBranchFormat -f $version
}

<#
    .SYNOPSIS
    Start a new release branch from the 'develop' branch.
    
    .DESCRIPTION
    Release branches support preparation of a new production release (minor bug fixes, preparing metadata, etc). By 
    doing all of this in a release branch, the 'develop' branch is clear to receive features for the next release. At 
    exactly the start of the release branch, the release will be assigned a version number (in the 'VERSION' file).
    
    .PARAMETER version
    The version of the release to start.
    
    .NOTES
    I'd like to accept user-customizable versioning schemes (numbering and file name/location).
#>
function Start-Release 
{ 
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $version
    )
    
    $releaseBranch = (Format-ReleaseBranch $version)
    
    git checkout -b $releaseBranch
    
    Set-Content $versionFilepath $version
    git add $versionFilepath
    git commit -a -m "set version to $version"
}

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
function Finish-Release 
{
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
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
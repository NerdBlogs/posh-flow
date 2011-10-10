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
function Start-Release { 
    param(
        [parameter(Mandatory = $true)]
        [string] $version
    )
    
    $releaseBranch = (Format-ReleaseBranch $version)
    
    git checkout -b $releaseBranch
    
    Set-Content $versionFilepath $version
    git add $versionFilepath
    git commit -a -m "set version to $version"
}
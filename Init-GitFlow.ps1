<#
    .SYNOPSIS
    Initialize a git-flow controlled repository.
    
    .DESCRIPTION
    The central repository holds two main branches with an infinite 
    lifetime: 'master' and 'develop'. The HEAD of 'origin/master' is 
    considered to be production ready code. The HEAD of 'origin/
    develop' is the features for the next release. This is where 
    automatic nightly builds would build from.
        
    .NOTES
    This function will initialize a directory as a git repository if 
    necessary. It will create a readme and a gitignore file and 
    commit them to start up the master branch.
#>
function Init-GitFlow 
{
    # posh-git looks for the git directory all the way up to the root
    if(-not(Test-Path .git)) 
    {
        git init .
        Set-Content readme.markdown ""
        Set-Content .gitignore ""
        git add .
        git commit -a -m "initialized git-flow repository: $(Get-Location | Split-Path -Leaf)"
    }

    git checkout -b develop master
}
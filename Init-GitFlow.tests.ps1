Import-Module posh-flow -Force -DisableNameChecking

Describe "When initializing posh-flow in an empty repository" {
    
    Setup -Dir "repo"
    Push-Location "TestDrive:\repo"
    
    Init-GitFlow
    
    It "should initialize the git repo" {
        "TestDrive:\repo\.git".should.exist()
    }
    
    It "should create an empty readme" {
        "TestDrive:\repo\readme.markdown".should.exist()
    }
    
    It "should create an empty .gitignore" {
        "TestDrive:\repo\.gitignore".should.exist()
    }
    
    It "should commit the initial repository" {
        $commit = git log --pretty=oneline `
            | Select-String "initialized git-flow repository" `
            | Measure-Object
        $commit.Count.should.be(1)
    }
    
    It "should checkout the develop branch" {
        dir -force
        Get-GitBranch
    
        $branch = Get-GitBranch
        $branch.should.be("(develop)")
    }
    
    Pop-Location
}

Describe "When initializing posh-flow in an existing git repository" {
    
    Push-Location $TestDrive
    
    git init $TestDrive
    Set-Content hello.txt "hello"
    git add .
    git commit -a -m "it's a repo"
 
    Init-GitFlow
    
    It "should not create any extra files" {
        $files = @(Get-ChildItem -Exclude hello.txt)
        $files.Count.should.be(0)
    }
    
    It "should checkout the develop branch" {
        $branch = Get-GitBranch
        $branch.should.be("(develop)")
    }
    
    Pop-Location
}

Describe "When initializing posh-flow in a repo with a develop branch" {

    Push-Location $TestDrive
    
    git init $TestDrive
    Set-Content hello.txt "hello"
    git add .
    git commit -a -m "it's a repo"
    git checkout -b develop
    git checkout master
 
    Init-GitFlow

    It "should not create any extra files" {
        $files = @(Get-ChildItem -Exclude hello.txt)
        $files.Count.should.be(0)
    }
    
    It "should checkout the develop branch" {
        $branch = Get-GitBranch
        $branch.should.be("(develop)")
    }
    
    Pop-Location
}
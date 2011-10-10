Describe "When initializing posh-flow in an empty repository" {
    Setup
    Push-Location $TestDrive
    
    Init-GitFlow | Out-Null
    
    It "should initialize the git repo" {
        "TestDrive:\.git".should.exist()
    }
    
    It "should create an empty readme" {
        "TestDrive:\readme.markdown".should.exist()
    }
    
    It "should create an empty .gitignore" {
        "TestDrive:\.gitignore".should.exist()
    }
    
    It "should commit the initial repository" {
        $commit = git log --pretty=oneline `
            | Select-String "initialized git-flow repository" `
            | Measure-Object
        $commit.Count.should.be(1)
    }
    
    It "should checkout the develop branch" {
        (Get-GitBranch).should.be("(develop)")
    }
    
    Pop-Location
}

Describe "When initializing posh-flow in an existing git repository" {
    Setup
    Push-Location $TestDrive
    
    git init $TestDrive | Out-Null
    Set-Content hello.txt "hello"
    git add .
    git commit -a -m "it's a repo" | Out-Null
 
    Init-GitFlow
    
    It "should not create any extra files" {
        $actual = @(Get-ChildItem -Exclude hello.txt)
        $actual.Count.should.be(0)
    }
    
    It "should checkout the develop branch" {
        $expected = "(develop)"
        $actual = Get-GitBranch
        $actual.should.be($expected)
    }
    
    Pop-Location
}

Describe "When initializing posh-flow in a repo with a develop branch" {
    Setup
    Push-Location $TestDrive
    
    git init $TestDrive | Out-Null
    Set-Content hello.txt "hello"
    git add .
    git commit -a -m "it's a repo" | Out-Null
    git checkout -b develop
    git checkout master
 
    Init-GitFlow

    It "should not create any extra files" {
        $actual = @(Get-ChildItem -Exclude hello.txt)
        $actual.Count.should.be(0)
    }
    
    It "should checkout the develop branch" {
        $expected = "(develop)"
        $actual = Get-GitBranch
        $actual.should.be($expected)
    }
    
    Pop-Location
}
######################################################################
# Import Pester
######################################################################
. ..\Pester\Pester.ps1
Update-TypeData -pre ..\Pester\ObjectAdaptations\types.ps1xml -ErrorAction SilentlyContinue
######################################################################

Import-Module posh-flow | Out-Null

Describe "When importing the posh-flow module" {
    Setup
    Push-Location $TestDrive
    git init $TestDrive | Out-Null

    It "should import the Get-GitDirectory function" {
        $expected = Join-Path $TestDrive ".git"
        $actual = Get-GitDirectory
        $actual.should.be($expected)
    }
    
    It "should import the Get-GitBranch function" { 
        $expected = "(master)"
        $actual = Get-GitBranch
        $actual.should.be($expected)
    }
    
    Pop-Location
}

Describe "When initializing posh-flow in an empty repository" {
    Setup
    Push-Location $TestDrive
    
    Init-GitFlow | Out-Null
    
    It "should initialize the git repo" {
        $actual = Join-Path $TestDrive ".git"
        $actual.should.exist()
    }
    
    It "should create an empty readme" {
        $actual = Join-Path $TestDrive "readme.markdown"
        $actual.should.exist()
    }
    
    It "should create an empty .gitignore" {
        $actual = Join-Path $TestDrive ".gitignore"
        $actual.should.exist()
    }
    
    It "should commit the initial repository" {
        $actual = git log $TestDrive `
            | Select-String "initialized repository" `
            | Measure-Object
        $actual.Count.should.be(1)
    }
    
    It "should checkout the develop branch" {
        $expected = "(develop)"
        $actual = Get-GitBranch
        $actual.should.be($expected)
    }
    
    Pop-Location
}

Describe "When initializing posh-flow in an existing git repository" {
    Setup
    Push-Location $TestDrive
    git init $TestDrive | Out-Null
    Set-Content hello.txt "hello"
    git add .
    git commit -a -m "it's a repo"
 
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
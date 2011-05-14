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
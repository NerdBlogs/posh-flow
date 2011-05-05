$testresults = Join-Path (Resolve-Path .) "TestResults"
$out = Join-Path $testresults (Get-Date).ToString("yyyy-mm-dd HHMMssfff")
New-Item $out -Type Directory | Out-Null
Push-Location $out

####################################################################################################

Import-Module posh-flow | Out-Null

####################################################################################################

"When importing the posh-flow module"

git init . | Out-Null
    
"> It should import the Get-GitDirectory function: {0}" -f ((Get-GitDirectory) -eq (Join-Path $pwd .git))
"> It should import the Get-GitBranch function: {0}" -f ((Get-GitBranch) -eq "(master)")

Remove-Item .git -Force -Recurse | Out-Null

####################################################################################################

"When initializing posh-flow in an empty repository"

Init-GitFlow | Out-Null

"> It should initialize the git repo: {0}" -f (Test-Path .git)
"> It should create an empty readme: {0}" -f (Test-Path readme.markdown)
"> It should create an empty .gitignore: {0}" -f (Test-Path .gitignore)
"> It should commit the initial repo: {0}" -f "(pending)"
  
Remove-Item .git -Force -Recurse | Out-Null

####################################################################################################

Pop-Location
######################################################################
# Import Pester
######################################################################
. ..\Pester\Pester.ps1
Update-TypeData -pre ..\Pester\ObjectAdaptations\types.ps1xml -ErrorAction SilentlyContinue
######################################################################

Get-ChildItem .\specs\*.specs.ps1 | %{ & $_.PSPath }
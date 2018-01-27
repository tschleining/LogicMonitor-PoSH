# dot-source all function files
Get-ChildItem -Path $PSScriptRoot\*.ps1 | Foreach-Object{ . $_.FullName }

# Export all commands except for Test-ElevatedShell
#oExport-ModuleMember Function @(Get-Command Module $ExecutionContext.SessionState.Module)
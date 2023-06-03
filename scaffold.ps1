$script = @"
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted
iwr "https://raw.githubusercontent.com/rvdwegen/Powershell/main/autopilot.ps1" | iex
"@

Write-Host $script

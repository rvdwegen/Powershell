$script = @"
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted
iwr "otherscript" | iex
"@

Write-Host $script

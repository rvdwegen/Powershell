cls

$script = @"
      ___        _              _ _       _     _____            __  __      _     _ 
     / _ \      | |            (_) |     | |   /  ___|          / _|/ _|    | |   | |
    / /_\ \_   _| |_ ___  _ __  _| | ___ | |_  \ `--.  ___ __ _| |_| |_ ___ | | __ | |
    |  _  | | | | __/ _ \| '_ \| | |/ _ \| __|  `--. \/ __/ _` |  _|  _/ _ \| |/ _`  |
    | | | | |_| | || (_) | |_) | | | (_) | |_  /\__/ / (_| (_| | | | || (_) | | (_| |
    \_| |_/\__,_|\__\___/| .__/|_|_|\___/ \__| \____/ \___\__,_|_| |_| \___/|_|\__,_|
                        | |                                                         
                        |_|                                                         


              ============ OfficeGrip autopilot hash scaffold ============
                                        v1.3

"@

Write-Host $script

$ScriptData = 'Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force -Confirm:$false; iwr "https://raw.githubusercontent.com/rvdwegen/Powershell/main/autopilot.ps1" | iex ~'

$wshell = New-Object -ComObject wscript.shell
$wshell.SendKeys($ScriptData)

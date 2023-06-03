cls

$script = @"
  ___        _              _ _       _    ______             _       _                   
 / _ \      | |            (_) |     | |   | ___ \           | |     | |                  
/ /_\ \_   _| |_ ___  _ __  _| | ___ | |_  | |_/ / ___   ___ | |_ ___| |_ _ __ __ _ _ __  
|  _  | | | | __/ _ \| '_ \| | |/ _ \| __| | ___ \/ _ \ / _ \| __/ __| __| '__/ _` | '_  \ 
| | | | |_| | || (_) | |_) | | | (_) | |_  | |_/ / (_) | (_) | |_\__ \ |_| | | (_| | |_) |
\_| |_/\__,_|\__\___/| .__/|_|_|\___/ \__| \____/ \___/ \___/ \__|___/\__|_|  \__,_| .__/ 
                     | |                                                           | |    
                     |_|                                                           |_|    
                                                
              ============ OfficeGrip autopilot hash scaffold ============
                                        v1.5

"@

Write-Host $script

$ScriptData = 'Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force -Confirm:$false; iwr "https://raw.githubusercontent.com/rvdwegen/Powershell/main/autopilot.ps1" | iex ~'

$wshell = New-Object -ComObject wscript.shell
$wshell.SendKeys($ScriptData)

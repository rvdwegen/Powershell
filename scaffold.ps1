cls

$script = @"
    ___        _              _ _       _     _                 _                            
   / _ \      | |            (_) |     | |   | |               | |                           
  / /_\ \_   _| |_ ___  _ __  _| | ___ | |_  | |__   ___   ___ | |_ ___  ___ _ __ __ _ _ __  
  |  _  | | | | __/ _ \| '_ \| | |/ _ \| __| | '_ \ / _ \ / _ \| __/ __|/ __| '__/ _` | '_  \ 
  | | | | |_| | || (_) | |_) | | | (_) | |_  | |_) | (_) | (_) | |_\__ \ (__| | | (_| | |_) |
  \_| |_/\__,_|\__\___/| .__/|_|_|\___/ \__| |_.__/ \___/ \___/ \__|___/\___|_|  \__,_| .__/ 
                       | |                                                            | |    
                       |_|                                                            |_|    

                  ============ OfficeGrip autopilot hash bootstrap ============

"@

Write-Host $script

$lol = 'Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force -Confirm:$false; iwr "https://raw.githubusercontent.com/rvdwegen/Powershell/main/autopilot.ps1" | iex ~'

$wshell = New-Object -ComObject wscript.shell;
#$wshell.AppActivate('title of the application window')
$wshell.SendKeys($lol)

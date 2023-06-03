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
                               Author: Roel van der Wegen
                                        v1.5

"@

Write-Host $script

# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
        $CommandLine = 'iwr "https://raw.githubusercontent.com/rvdwegen/Powershell/main/bootstrap3.ps1" | iex'
        Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
        exit
}

$ScriptData = 'Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force -Confirm:$false; iwr "https://raw.githubusercontent.com/rvdwegen/Powershell/main/autopilot.ps1" | iex ~'

$wshell = New-Object -ComObject wscript.shell
$wshell.SendKeys($ScriptData)

pause

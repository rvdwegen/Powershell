cls

$script = @"
                                                
     _         _              _ _       _     ____              _       _                   
    / \  _   _| |_ ___  _ __ (_) | ___ | |_  | __ )  ___   ___ | |_ ___| |_ _ __ __ _ _ __  
   / _ \| | | | __/ _ \| '_ \| | |/ _ \| __| |  _ \ / _ \ / _ \| __/ __| __| '__/ _`  | '_ \ 
  / ___ \ |_| | || (_) | |_) | | | (_) | |_  | |_) | (_) | (_) | |_\__ \ |_| | | (_| | |_) |
 /_/   \_\__,_|\__\___/| .__/|_|_|\___/ \__| |____/ \___/ \___/ \__|___/\__|_|  \__,_| .__/ 
                       |_|                                                           |_|    
                                                 
                                                
              ============ OfficeGrip autopilot hash bootstrap ============
                               Author: Roel van der Wegen
                                        v0.3

"@

Write-Host $script

# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
        $CommandLine = '-noexit iwr "https://raw.githubusercontent.com/rvdwegen/Powershell/main/bootstrap.ps1" | iex'
        Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
        exit
}

$ScriptData = 'Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force -Confirm:$false; iwr "https://raw.githubusercontent.com/rvdwegen/Powershell/main/autopilot.ps1" | iex ~'

$wshell = New-Object -ComObject wscript.shell
$wshell.SendKeys($ScriptData)

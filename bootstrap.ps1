cls

$script = @"
        ___         __              _ __      __     ____              __       __                 
       /   | __  __/ /_____  ____  (_) /___  / /_   / __ )____  ____  / /______/ /__________ _____ 
      / /| |/ / / / __/ __ \/ __ \/ / / __ \/ __/  / __  / __ \/ __ \/ __/ ___/ __/ ___/ __ `/ __ \
     / ___ / /_/ / /_/ /_/ / /_/ / / / /_/ / /_   / /_/ / /_/ / /_/ / /_(__  ) /_/ /  / /_/ / /_/ /
    /_/  |_\__,_/\__/\____/ .___/_/_/\____/\__/  /_____/\____/\____/\__/____/\__/_/   \__,_/ .___/ 
                        /_/                                                              /_/      
                                                
              ============ OfficeGrip autopilot hash bootstrap ============
                               Author: Roel van der Wegen
                                        v0.1

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

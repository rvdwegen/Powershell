[CmdletBinding()]
param(
    [Parameter(Mandatory=$True)]
    [ValidateSet(0,1)]
    [Int]$Value
)

# Script to enable/disable Fast Startup

# Package as Win32app, then upload to tenant with the following settings:

# App information
# - Name: Set-FastStartup
# - Description: Install to disable fast startup, uninstall to enable fast startup.
# - Publisher: OfficeGrip

# Program
# - Install command: PowerShell.exe -WindowStyle Hidden -ExecutionPolicy ByPass -File Set-FastStartup.ps1 -Value "0"
# - Uninstall command: PowerShell.exe -WindowStyle Hidden -ExecutionPolicy ByPass -File Set-FastStartup.ps1 -Value "1"
# - Install behavior: System

# Requirements
# - Operating system architecture: x64
# - Minimum operating system: oldest selectable version

# Detection Rules
# - Rules format: Manually configure detection rules
# - Detection rules
# 	- Rule Type: Registry
# 	- Key Path: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power
# 	- Value name: HiberBootEnabled
# 	- Detection method: String comparison
# 	- Operator: Equals
# 	- Value: 0

Function Set-RegistryProperty {
    # Version 2.3
    Param(
        [Parameter(Mandatory=$true)][string]$RegistryKey,
        [Parameter(Mandatory=$true)][string]$PropertyName,
        [Parameter(Mandatory=$true)][string][ValidateSet("String","ExpandString","Binary","DWord","MultiString","Qword")]$PropertyType,
        [Parameter(Mandatory=$true)][string]$PropertyValue
    )
    #Check for registry key path and create if needed
    If(!(Test-Path -Path $RegistryKey)){
        New-Item -Path $RegistryKey -Force
    }

    #Remove previous itemproperty with a different property type. Error will be ignored if it does not exist.
    Remove-ItemProperty -Path $RegistryKey -Name $PropertyName -Force -ErrorAction SilentlyContinue
    #Create new itemproperty with the right settings
    New-ItemProperty -Path $RegistryKey -Name $PropertyName -PropertyType $PropertyType -Value $PropertyValue -Force | Out-Null

    Write-Host "Registry edit done to $RegistryKey\$PropertyName" -ForegroundColor Green
}

Try {
    $RegistryParam = @{
        RegistryKey = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power"
        PropertyName = "HiberBootEnabled"
        PropertyType = "DWORD"
        PropertyValue = $Value
    }
    
    Set-RegistryProperty @RegistryParam -ErrorAction Stop
}
Catch {
    Write-Error $_.Exception.Message
}

[CmdletBinding()]
param(
[Boolean]$Settask
)

switch ($settask) {
    $true {
        # Define task action
        $ActionParam = @{
            Execute = 'Powershell.exe'
            Argument = ("-ExecutionPolicy Bypass -File " + ($MyInvocation.ScriptName))
        }

        # Define task trigger
        $TriggerParam = @{
            AtLogOn = $True
            User = (([System.Security.Principal.WindowsIdentity]::GetCurrent().Name).Split('\')[-1])
        }

        # Define task settings
        $SettingsParam = @{
            AllowStartIfOnBatteries = $true
            DontStopIfGoingOnBatteries = $true
        }

        # Construct task
        $Register = @{
            Action = (New-ScheduledTaskAction @ActionParam)
            Trigger = (New-ScheduledTaskTrigger @TriggerParam)
            Settings = (New-ScheduledTaskSettingsSet @SettingsParam)
            User = (([System.Security.Principal.WindowsIdentity]::GetCurrent().Name).Split('\')[-1])
            TaskName = "PrepareScriptRebootTask"
            Description = "PrepareScriptRebootTask"
        }

        # Register task
        Register-ScheduledTask @Register
    }
    $false {
        Unregister-ScheduledTask -TaskName "PrepareScriptRebootTask" -Confirm:$false -ErrorAction SilentlyContinue
    }
    Default {Throw "Something went wrong, this isn't supposed to happen"}
}

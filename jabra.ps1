Function Update-settings {

    Try {

        $ConfigFile = "$([Environment]::GetFolderPath("ApplicationData"))\Jabra Direct\config.json"

        If (Test-Path $ConfigFile) {

            $config = Get-Content $ConfigFile -Raw | ConvertFrom-Json
    
            $config.DirectShowNotification.value = $false
            $config.DirectShowNotification.locked = $true
        
            $config.EnableFeedback.value = $true
            $config.EnableFeedback.locked = $false
        
            $config | ConvertTo-Json | Set-Content $ConfigFile
    
        }

        Else {
            Throw "ConfigFileNotFound"
        }
    }

    Catch {
        # Figure out if there is some way to report errors back through Intune.
    }

}

Update-settings
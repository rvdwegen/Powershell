Function Test-InternetConnection {
    # Lists outside connections that are not the VPN
    $Status = Get-NetRoute | Where-Object DestinationPrefix -eq '0.0.0.0/0' | Get-NetIPInterface | Where-Object {($_.ConnectionState -eq 'Connected')}

    # If someone finds a list of possible default InterfaceAlias results please share it
    If ($Status.InterfaceAlias -like "*Wi-Fi*" -OR $Status.InterfaceAlias -like "*Ethernet*") {
        Write-Host "Internet connection detected" -ForegroundColor Green
        Return $true
    }
    Else {
        Write-Host "Internet connection not detected" -ForegroundColor Red
        Return $false
    }
}

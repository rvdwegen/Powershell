<#
.Synopsis
  Search DHCP for a specified Hostname or MacAddress or export all leases
.DESCRIPTION
  This script searches the specified DHCP server for the requested Hostname or MacAddress
.EXAMPLE 
  .\DHCP-Search.ps1 -DHCPServer "DHCPhostname" -Export "DHCPLeases.csv" 
.EXAMPLE
  .\DHCP-Search.ps1 -DHCPServer "DHCPhostname" -Hostname "FullOrPartialHostname" -Export "DHCPLeases.csv"
.EXAMPLE
  .\DHCP-Search.ps1 -DHCPServer "DHCPhostname" -MacAddress "FullMacAddress" -Export "DHCPLeases.csv"
#>

[CmdletBinding()]
param(
    # Set the DHCP server to query
    [Parameter(Mandatory=$true)]
    [ValidatePattern('^[a-zA-Z0-9.]*$')]
    [String]$DHCPServer,

    # Hostname to search for, can be partial match
    [parameter(Mandatory=$false)]
    [ValidatePattern('^[a-zA-Z0-9.]*$')]
    [String]$Hostname,

    # MacAddress, must be a valid Mac address matching the XX-XX-XX-XX-XX-XX or XX:XX:XX:XX:XX:XX pattern
    [parameter(Mandatory=$false)]
    [ValidatePattern('^([0-9A-F]{2}[:-]){5}([0-9A-F]{2})$')]
    [String]$MacAddress,

    # CSV file location
    [parameter(Mandatory=$true)]
    [String]$Export
)

Try {
    # Log script start
    Write-Host "Starting Script"

    # Get the scopes
    $Scopes = Get-DhcpServerv4Scope -ComputerName $DHCPServer -ErrorAction Stop
    Write-Host "Scopes have been retrieved from the DHCP server" -ForegroundColor "Green"

    # Initialize array
    $DHCPLeases = @()
    Write-Host "DHCP Leases array has been initialized" -ForegroundColor "Green"

    # Loop through $Scopes to fill the $DHCPLeases array
    foreach ($ScopeID in $Scopes) {
        $DHCPLeases += Get-DhcpServerv4Lease -ComputerName $DHCPServer -ScopeId $ScopeID.scopeid -ErrorAction Stop
    }
    Write-Host "DHCP leases have been retrieved from all scopes" -ForegroundColor "Green"

    if ($Hostname) {
        Write-Host "Retrieving matching Hostnames and exporting" -ForegroundColor "Green"
        $DHCPLeases | Select-Object HostName, IPAddress, ClientId, ScopeId, AddressState | Where-Object {$_.Hostname -Match "$Hostname"} | Export-Csv -Path $Export -delimiter ';' -NoTypeInformation -ErrorAction Stop
        Write-Host "File has been exported to $Export"
    }
    elseif ($MacAddress) {
        Write-Host "Retrieving matching Mac adresses and exporting" -ForegroundColor "Green"
        $DHCPLeases | Select-Object HostName, IPAddress, ClientId, ScopeId, AddressState | Where-Object {$_.ClientId -Match "$MacAddress"} | Export-Csv -Path $Export -delimiter ';' -NoTypeInformation -ErrorAction Stop
        Write-Host "File has been exported to $Export"
    }
    else {
        Write-Host "Exporting all leases" -ForegroundColor "Green"
        $DHCPLeases | Select-Object HostName, IPAddress, ClientId, ScopeId, AddressState | Export-Csv -Path $Export -delimiter ';' -NoTypeInformation -ErrorAction Stop
        Write-Host "File has been exported to $Export"
    }
}
Catch {
    Write-Host "Something went wrong!"
    Write-Host $_.Exception.GetType().FullName
    Write-Host $_.Exception.Message
}
Finally {
    Write-Host "Script has completed"
}

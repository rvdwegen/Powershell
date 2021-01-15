<#
.Synopsis
  Search DHCP for a specified Hostname or MacAddress or export all leases
.DESCRIPTION
  This script searches the specified DHCP server for the requested Hostname or MacAddress
.EXAMPLE 
  .\DHCP-Search.ps1 -Type "Wildcard" -DHCPServer "DHCPhostname" -Export "DHCPLeases.csv" 
.EXAMPLE
  .\DHCP-Search.ps1 -Type "Hostname" -DHCPServer "DHCPhostname" -Hostname "FullOrPartialHostname" -Export "DHCPLeases.csv"
.EXAMPLE
  .\DHCP-Search.ps1 -Type "MacAddress" -DHCPServer "DHCPhostname" -MacAddress "FullOrPartialMacAddress" -Export "DHCPLeases.csv"
#>

[CmdletBinding()]
param(
    # Used to determine the request type
    [Parameter(Mandatory=$true)]
    [ValidateSet("Wildcard", "Hostname", "MacAddress")]
    [String]$Type,

    # Set the DHCP server to query
    [Parameter(Mandatory=$true)]
    [ValidatePattern('^[a-zA-Z0-9]*$')]
    [String]$DHCPServer,

    # Hostname to search for, can be partial match
    [parameter(Mandatory=$false)]
    [ValidatePattern('^[a-zA-Z0-9]*$')]
    [String]$Hostname="",

    # MacAddress to search for, can be partial match
    [parameter(Mandatory=$false)]
    [ValidatePattern('^([0-9A-F]{2}[:-]){5}([0-9A-F]{2})$')] # Must be a valid Mac address matching the XX-XX-XX-XX-XX-XX or XX:XX:XX:XX:XX:XX pattern
    [String]$MacAddress="",

    # CSV file location
    [parameter(Mandatory=$true)]
    [String]$Export
)

Function Start-Script {
    Try {
        $MacAddress = $MacAddress -replace '[^\p{L}\p{Nd}]', '' # Strip out special characters
        $MacAddress = $MacAddress -replace '..(?!$)', '$&-' # Add a - after every second character

        Get-DHCPLeases -Type $Type -DHCPServer $DHCPServer -Hostname $Hostname -MacAddress $MacAddress -Export $Export -ErrorAction Stop
        Write-Log -Type "Info" -LogMsg "Output can be found at $Export" -Console
    }
    Catch {
        Write-Log -Type "Error" -LogMsg "Something went wrong!" -Console
        Write-Log -Type "Error" -LogMsg $_.Exception.GetType().FullName -Console
        Write-Log -Type "Error" -LogMsg $_.Exception.Message -Console
    }
    Finally {
        Write-Log -Type "Info" -LogMsg "Script has been completed" -Console
    }
}

Function Get-DHCPLeases {
    [CmdletBinding()]
    param(
        # Used to determine the request type
        [Parameter(Mandatory=$true)]
        [ValidateSet("Wildcard", "Hostname", "MacAddress")]
        [String]$Type,

        # Set the DHCP server to query
        [Parameter(Mandatory=$true)]
        [String]$DHCPServer,

        # Hostname to search for, can be partial match
        [parameter(Mandatory=$false)]
        [String]$Hostname,

        # MacAddress to search for, can be partial match
        [parameter(Mandatory=$false)]
        [ValidatePattern('^([0-9A-F]{2}[--]){5}([0-9A-F]{2})$')]
        [String]$MacAddress,

        # CSV file location
        [parameter(Mandatory=$true)]
        [String]$Export
    )

    # Determine the request type
    switch ($Type) {
        "Wildcard" { [int]$Type = 1 }
        "Hostname" { [int]$Type = 2 }
        "MacAddress" { [int]$Type = 3 }
    }

    # Get the scopes
    $Scopes = Get-DhcpServerv4Scope -ComputerName $DHCPServer -ErrorAction Stop

    # Initialize array
    $DHCPLeases = @()

    # Loop through $Scopes to fill the $DHCPLeases array
    foreach ($ScopeID in $Scopes) {
        $DHCPLeases += Get-DhcpServerv4Lease -ComputerName $DHCPServer -ScopeId $ScopeID.scopeid -ErrorAction Continue
    }

    # Determine the request type and execute an option accordingly
    switch ($Type) {
        # Wildcard, exports EVERYTHING
        "1" {
            $DHCPLeases | Select-Object HostName, IPAddress, ClientId, ScopeId, AddressState | Export-Csv -Path $Export -delimiter ';' -NoTypeInformation -ErrorAction Stop
        }
        # Hostname, exports everything that matches the hostname. Partial matches are possible
        "2" {
            $DHCPLeases | Select-Object HostName, IPAddress, ClientId, ScopeId, AddressState | Where-Object {$_.Hostname -Match "$Hostname"} | Export-Csv -Path $Export -delimiter ';' -NoTypeInformation -ErrorAction Stop
        }
        # MacAddress, exports everything that matches the MacAddress. Partial matches are possible
        "3" {
            $DHCPLeases | Select-Object HostName, IPAddress, ClientId, ScopeId, AddressState | Where-Object {$_.ClientId -Match "$MacAddress"} | Export-Csv -Path $Export -delimiter ';' -NoTypeInformation -ErrorAction Stop
        }
    }

}

# Log function
Function Write-Log{
    [CmdletBinding()]
    param(
        # Used to determine the log entry type
        [Parameter(Mandatory=$true)]
        [ValidateSet("Info", "Warning", "Error")]
        [String]$Type,

        # Message to be logged
        [Parameter(Mandatory=$True)]
        [String]$LogMsg,

        # Path to the log file, defaults to false so if no input is given there will not be an entry in the logfile
        [Parameter(Mandatory=$false)]
        [String]$Logpath=$false,

        # Used to print log entries to a GUI console
        [parameter(Mandatory=$false)]
        [Switch]$GUI=$false,

        # Used to print log entries to the Powershell console
        [parameter(Mandatory=$false)]
        [Switch]$Console=$false
    )

    # Determine the log entry type
    switch ($Type) {
        "Info" { [int]$Type = 1 }
        "Warning" { [int]$Type = 2 }
        "Error" { [int]$Type = 3 }
    }

    # Date
    $LogDate = Get-Date -Format "d-M-yyyy"

    # Time
    $LogTime = Get-Date -Format "HH:mm:ss"

    # Retrieve the calling function name
    $GetFunctionName = [string]$(Get-PSCallStack)[1].FunctionName

    # Used to print a log entry to a GUI console
    if ($GUI -eq $true) {
        switch ($Type) {
            "1" { $GUIconsole.SelectionColor = 'black'; $GUIconsole.AppendText($LogMsg + "`r`n") }
            "2" { $GUIconsole.SelectionColor = 'orange'; $GUIconsole.AppendText($LogMsg + "`r`n") }
            "3" { $GUIconsole.SelectionColor = 'red'; $GUIconsole.AppendText($LogMsg + "`r`n") }
        }
    }

    # Used to print a log entry to the Powershell console
    if ($Console -eq $true) {
        switch ($Type) {
            "1" { Write-Host $LogMsg }
            "2" { Write-Host $LogMsg }
            "3" { Write-Host $LogMsg }
        }
    }

    # Used to print a log entry to a logfile
    if ($LogPath -eq $true) {
        # Create a CMTrace compatible log entry
        $Content = "<![LOG[$LogMsg]LOG]!>" +`
            "<time=`"$(Get-Date -Format "HH:mm:ss.ffffff")`" " +`
            "date=`"$(Get-Date -Format "M-d-yyyy")`" " +`
            "component=`"$GetFunctionName`" " +`
            "context=`"$([System.Security.Principal.WindowsIdentity]::GetCurrent().Name)`" " +`
            "type=`"$Type`" " +`
            "thread=`"$([Threading.Thread]::CurrentThread.ManagedThreadId)`" " +`
            "file=`"C:\stuff.ps1`">"

        # Add log entry to log file
        Out-File -InputObject $Content -Append -NoClobber -Encoding Default -FilePath $Logpath -WhatIf:$False
    }

    # ($LogDate + " " + $LogTime + " | Function: " + $GetFunctionName + " | Message: " + $LogMsg + "`r`n") # Example formatting if you need a full log entry in the GUIConsole
    # ($LogDate + " " + $LogTime + " | Function: " + $GetFunctionName + " | Message: " + $LogMsg) # Example formatting if you need a full log entry in the Powershell Console
} # End of logging function

Start-Script

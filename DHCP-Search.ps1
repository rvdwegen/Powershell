[CmdletBinding()]
param(
    # Set the DHCP server to query
    [Parameter(Mandatory=$true)]
    [String]$DHCPServer,

    # Hostname to search for (can be partial match)
    [parameter(Mandatory=$false)]
    [String]$Hostname="",

    # CSV file location
    [parameter(Mandatory=$false)]
    [String]$Export="C:\Temp\DHCPLeases.csv"
)

# Main
Function Start-Script {
    Try {
        Get-DHCPLeases -DHCPServer $DHCPServer -Hostname $Hostname -Export $Export -ErrorAction Stop
        Write-Log -Type "Info" -LogMsg "Script has been completed" -Console
        Write-Log -Type "Info" -LogMsg "Output can be found at $Export" -Console
    }
    Catch {
        Write-Log -Type "Error" -LogMsg "Something went wrong!" -Console
        Write-Log -Type "Error" -LogMsg $_.Exception.GetType().FullName -Console
        Write-Log -Type "Error" -LogMsg $_.Exception.Message -Console
    }
}

# Gets the DHCP leases, searches them for matching hostnames and exports to $export
Function Get-DHCPLeases {
    [CmdletBinding()]
    param(
        # Set the DHCP server to query
        [Parameter(Mandatory=$true)]
        [String]$DHCPServer,

        # Hostname to search for
        [parameter(Mandatory=$false)]
        [String]$Hostname="",

        # CSV file location
        [parameter(Mandatory=$false)]
        [String]$Export
    )

    $Scopes = Get-DhcpServerv4Scope -ComputerName $DHCPServer -ErrorAction Stop

    $DHCPLeases = @()

    foreach ($ScopeID in $Scopes) {
        $DHCPLeases += Get-DhcpServerv4Lease -ComputerName $DHCPServer -ScopeId $ScopeID.scopeid -ErrorAction Continue | Select-Object IPAddress, ScopeId, AddressState, HostName | Where-Object {$_.hostname -match $Hostname}
    }

    $DHCPLeases | Export-Csv -Path $Export -delimiter ';' -NoTypeInformation -ErrorAction Stop
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

# Starts the script
Start-Script

# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
        $CommandLine = "iwr "https://raw.githubusercontent.com/rvdwegen/Powershell/main/autopilot3.ps1" | iex"
        Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
        pause
}

function Save-File ([string]$filename) {
    [void][System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")

    $OpenFileDialog = New-Object System.Windows.Forms.SaveFileDialog
    $OpenFileDialog.initialDirectory = $env:HOMEDRIVE
    $OpenFileDialog.filter = 'CSV (*.csv)|*.csv'
    $OpenFileDialog.FileName = "$filename.csv"
    [void]$OpenFileDialog.ShowDialog()

    return $OpenFileDialog.filename
}

$SerialNumber = (Get-WmiObject win32_bios | select Serialnumber).SerialNumber


Install-Script -name Get-WindowsAutopilotInfo -Force
Get-WindowsAutopilotInfo -OutputFile (Save-File -filename $SerialNumber)

#Requires -RunAsAdministrator

function Save-File {
    [void][System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")

    $OpenFileDialog = New-Object System.Windows.Forms.SaveFileDialog
    $OpenFileDialog.initialDirectory = $env:USERPROFILE
    $OpenFileDialog.filter = 'CSV (*.csv)|*.csv'
    $OpenFileDialog.DefaultFileName = "test.csv"
    [void]$OpenFileDialog.ShowDialog()

    return $OpenFileDialog.filename
}

$SerialNumber = (Get-WmiObject win32_bios | select Serialnumber).SerialNumber

Install-Script -name Get-WindowsAutopilotInfo -Force
Get-WindowsAutopilotInfo -OutputFile (Save-File)

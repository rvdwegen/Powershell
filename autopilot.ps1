function Save-File ([string]$filename) {
    [void][System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")

    $OpenFileDialog = New-Object System.Windows.Forms.SaveFileDialog
    $OpenFileDialog.initialDirectory = "::{20D04FE0-3AEA-1069-A2D8-08002B30309D}"
    $OpenFileDialog.filter = 'CSV (*.csv)|*.csv'
    $OpenFileDialog.FileName = "$filename.csv"
    [void]$OpenFileDialog.ShowDialog()

    return $OpenFileDialog.filename
}

$SerialNumber = (Get-WmiObject win32_bios | select Serialnumber).SerialNumber

Install-Script -name Get-WindowsAutopilotInfo -Force
Get-WindowsAutopilotInfo -OutputFile (Save-File -filename $SerialNumber)

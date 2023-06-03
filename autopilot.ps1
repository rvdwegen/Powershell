#Requires -RunAsAdministrator

function Save-File {
    [void][System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")

    $OpenFileDialog = New-Object System.Windows.Forms.SaveFileDialog
    $OpenFileDialog.initialDirectory = $env:USERPROFILE
    $OpenFileDialog.filter = 'CSV (*.csv)|*.csv'
    [void]$OpenFileDialog.ShowDialog()

    return $OpenFileDialog.filename
}

Install-Script -name Get-WindowsAutopilotInfo -Force
Get-WindowsAutopilotInfo -OutputFile (Save-File)

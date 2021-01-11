# Assemblies
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName Microsoft.VisualBasic

# Enable Visual Styles
[Windows.Forms.Application]::EnableVisualStyles()

# Hide PowerShell Console
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
$consolePtr = [Console.Window]::GetConsoleWindow()
[Console.Window]::ShowWindow($consolePtr, 0) | Out-Null

# Variables
$Title = "BlankGUI"
$LogFile = "$env:SystemRoot\@MYPCMGT\LOGS\$Title.log"

# Starts the show
Function StartTheShow {
    BuildGUI
}

# Builds the GUI
Function BuildGUI {

    # Form variables
    $FormFont = "Segoe UI" # Define the font used by the Form
    $BaseColor = "#39ACFF"
    $MouseOverColor = "#0086e6"

    # Builds the form
    $Form                               = New-Object system.Windows.Forms.Form
    $Form.ClientSize                    = New-Object System.Drawing.Point(530,530)
    $Form.text                          = ""
    $Form.BackColor                     = [System.Drawing.ColorTranslator]::FromHtml("#dadada")
    $Form.StartPosition                 = [System.Windows.Forms.FormStartPosition]::CenterScreen
    $Form.ControlBox                    = $false
    $Form.FormBorderStyle               = "None"
    $Form.BackColor                     = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

    # Form TitleBar
    $TitleBar                           = New-Object system.Windows.Forms.Panel
    $TitleBar.Size                      = New-Object System.Drawing.Size(530,30)
    $TitleBar.Location                  = New-Object System.Drawing.Point(0,0)
    $TitleBar.BackColor                 = [System.Drawing.ColorTranslator]::FromHtml("#1a9fff")

    # Titlebar Label
    $TitleBarLabel                      = New-Object system.Windows.Forms.Label
    $TitleBarLabel.Text                 = "$Title"
    $TitleBarLabel.Size                 = New-Object System.Drawing.Size(530,30)
    $TitleBarLabel.location             = New-Object System.Drawing.Point(5,0)
    $TitleBarLabel.Font                 = New-Object System.Drawing.Font($FormFont,12)
    $TitleBarLabel.ForeColor            = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
    $TitleBarLabel.BackColor            = [System.Drawing.ColorTranslator]::FromHtml("#1a9fff")
    $TitleBarLabel.TextAlign            = "MiddleLeft"

    #Builds the - button
    $ButtonMinimize                     = New-Object system.Windows.Forms.Button
    $ButtonMinimize.text                = [char]0xE921
    $ButtonMinimize.Size                = New-Object System.Drawing.Size(40,30)
    $ButtonMinimize.location            = New-Object System.Drawing.Point(450,0)
    $ButtonMinimize.Font                = New-Object System.Drawing.Font('Segoe MDL2 Assets',7)
    $ButtonMinimize.FlatStyle           = "Flat"
    $ButtonMinimize.ForeColor           = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
    $ButtonMinimize.BackColor           = [System.Drawing.ColorTranslator]::FromHtml("#1a9fff")
    $ButtonMinimize.FlatAppearance.BorderSize = 0
    $ButtonMinimize.FlatAppearance.MouseOverBackColor = [System.Drawing.ColorTranslator]::FromHtml("$MouseOverColor")
    $ButtonMinimize.TextAlign           = "MiddleCenter"
    $ButtonMinimize.Cursor              = "Hand"

    #Builds the X button
    $ButtonClose                        = New-Object system.Windows.Forms.Button
    $ButtonClose.text                   = [char]0xE8BB
    $ButtonClose.Size                   = New-Object System.Drawing.Size(40,30)
    $ButtonClose.location               = New-Object System.Drawing.Point(490,0)
    $ButtonClose.Font                   = New-Object System.Drawing.Font('Segoe MDL2 Assets',7)
    $ButtonClose.FlatStyle              = "Flat"
    $ButtonClose.ForeColor              = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
    $ButtonClose.BackColor              = [System.Drawing.ColorTranslator]::FromHtml("#1a9fff")
    $ButtonClose.FlatAppearance.BorderSize = 0
    $ButtonClose.FlatAppearance.MouseOverBackColor = [System.Drawing.ColorTranslator]::FromHtml("#e81123")
    $ButtonClose.TextAlign              = "MiddleCenter"
    $ButtonClose.Cursor                 = "Hand"

    # Top menu background
    $GUIPanel1                          = New-Object system.Windows.Forms.Panel
    $GUIPanel1.Size                     = New-Object System.Drawing.Size(530,150)
    $GUIPanel1.Location                 = New-Object System.Drawing.Point(0,0)
    $GUIPanel1.BackColor                = [System.Drawing.ColorTranslator]::FromHtml("$BaseColor")

    # Builds the first button
    $ButtonOne                          = New-Object system.Windows.Forms.Button
    $ButtonOne.text                     = 'One'
    $ButtonOne.Size                     = New-Object System.Drawing.Size(100,150)
    $ButtonOne.location                 = New-Object System.Drawing.Point(20,0)
    $ButtonOne.Font                     = New-Object System.Drawing.Font('Agency FB',23)
    $ButtonOne.FlatStyle                = "Flat"
    $ButtonOne.ForeColor                = "White"
    $ButtonOne.BackColor                = [System.Drawing.ColorTranslator]::FromHtml("$BaseColor")
    $ButtonOne.FlatAppearance.BorderSize = 0
    $ButtonOne.FlatAppearance.MouseOverBackColor = [System.Drawing.ColorTranslator]::FromHtml("$MouseOverColor")
    $ButtonOne.TextAlign                = "BottomCenter"
    $ButtonOne.Cursor                   = "Hand"

    #Builds the second button
    $ButtonTwo                          = New-Object system.Windows.Forms.Button
    $ButtonTwo.text                     = "Two"
    $ButtonTwo.Size                     = New-Object System.Drawing.Size(100,150)
    $ButtonTwo.location                 = New-Object System.Drawing.Point(150,0)
    $ButtonTwo.Font                     = New-Object System.Drawing.Font('Agency FB',23)
    $ButtonTwo.FlatStyle                = "Flat"
    $ButtonTwo.ForeColor                = "White"
    $ButtonTwo.BackColor                = [System.Drawing.ColorTranslator]::FromHtml("$BaseColor")
    $ButtonTwo.FlatAppearance.BorderSize = 0
    $ButtonTwo.FlatAppearance.MouseOverBackColor = [System.Drawing.ColorTranslator]::FromHtml("$MouseOverColor")
    $ButtonTwo.TextAlign                = "BottomCenter"
    $ButtonTwo.Cursor                   = "Hand"
    $ButtonTwo.Enabled                  = $true

    #Builds the third button
    $ButtonThree                        = New-Object system.Windows.Forms.Button
    $ButtonThree.text                   = "Three"
    $ButtonThree.Size                   = New-Object System.Drawing.Size(100,150)
    $ButtonThree.location               = New-Object System.Drawing.Point(280,0)
    $ButtonThree.Font                   = New-Object System.Drawing.Font('Agency FB',23)
    $ButtonThree.FlatStyle              = "Flat"
    $ButtonThree.ForeColor              = "White"
    $ButtonThree.BackColor              = [System.Drawing.ColorTranslator]::FromHtml("$BaseColor")
    $ButtonThree.FlatAppearance.BorderSize = 0
    $ButtonThree.FlatAppearance.MouseOverBackColor = [System.Drawing.ColorTranslator]::FromHtml("$MouseOverColor")
    $ButtonThree.TextAlign              = "BottomCenter"
    $ButtonThree.Cursor                 = "Hand"

    #Builds the logo image
    $ISLogo                             = New-Object system.Windows.Forms.PictureBox
    $ISLogo.Size                        = New-Object System.Drawing.Size(100,150)
    $ISLogo.location                    = New-Object System.Drawing.Point(410,0)
    $ISLogo.imageLocation               = "$env:temp\logo_panel.png"
    $ISLogo.SizeMode                    = [System.Windows.Forms.PictureBoxSizeMode]::zoom

    # Set a tooltip on $ISLogo
    $tooltip1 = New-Object System.Windows.Forms.ToolTip
    $tooltip1.SetToolTip($ISLogo, "Designed and coded by Roel van der Wegen in 2020.")

    # Console border
    $GUIConsoleBorder                   = New-Object system.Windows.Forms.Panel
    $GUIConsoleBorder.Size              = New-Object System.Drawing.Size(514,284)
    $GUIConsoleBorder.Location          = New-Object System.Drawing.Point(8,238)
    $GUIConsoleBorder.BackColor         = [System.Drawing.ColorTranslator]::FromHtml("$BaseColor")

    # Builds the console
    $GUIconsole                         = New-Object System.Windows.Forms.RichTextBox 
    $GUIconsole.Multiline               = $True;
    $GUIconsole.Location                = New-Object System.Drawing.Point(10,240) 
    $GUIconsole.Size                    = New-Object System.Drawing.Size(510,280)
    $GUIconsole.Scrollbars              = "Vertical"
    $GUIconsole.ReadOnly                = $True
    $GUIconsole.BorderStyle             = 'None'
    $GUIconsole.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
    $GUIConsole.Font                    = New-Object System.Drawing.Font($FormFont,8)

#####################################################################################################



#####################################################################################################

    Write-Log -Type "Info" -LogMsg "Starting $Title" -Logpath $LogFile

    $ButtonOne.Add_Click({
        # actions
    })

    $ButtonTwo.Add_Click({
        # actions
    })

    $ButtonThree.Add_Click({ 
        # actions   
    })

    $ButtonMinimize.Add_Click({ 
        $form.WindowState = [System.Windows.Forms.FormWindowState]::Minimized
    })

    $ButtonClose.Add_Click({ 
        Write-Log -Type "Info" -LogMsg "Exiting $Title" -Logpath $LogFile
        $form.Close()
    })

    $defaultText = @("
    Stuff
    ")
    $GUIconsole.Text = ("$defaultText")

    $Form.controls.AddRange(@(
        $ButtonClose,
        $ButtonMinimize,
        $TitleBarLabel,
        $GUIconsole,
        $TitleBar,
        $ButtonOne,
        $ButtonTwo,
        $ButtonThree,
        $ISLogo,
        $GUIPanel1,
        $GUIConsoleBorder
    ))

#####################################################################################################

# Add a custom class that allows us to move the form via a separate control
Add-Type -ReferencedAssemblies System.Windows.Forms -Language CSharp -TypeDefinition @"
 
using System;
using System.Windows.Forms;
using System.Runtime.InteropServices;
 
/////////////////////////////////////////////////////
/// FormMover Class /////////////////////////////////
/////////////////////////////////////////////////////
/// Credit to https://www.reddit.com/r/PowerShell/comments/6zffyd/customize_your_winforms_use_a_panel_as_controlbox/
/////////////////////////////////////////////////////

public partial class FormMover : Form
{
    /// begin define class variables
    ///
    public const int WM_NCLBUTTONDOWN = 0xA1;
    public const int HT_CAPTION = 0x2;
    ///
    /// end define class variables
 
    /// begin import c++ modules / connect to windowsAPI 
    ///
    [DllImport("user32.dll")]
    public static extern int SendMessage(IntPtr hWnd, int Msg, int wParam, int lParam);
    [DllImport("user32.dll")]
    public static extern bool ReleaseCapture();
    ///
    /// end import c++ modules / connect to windowsAPI
 
    /// begin class methods
    ///
    public static void OnMouseDown_MoveForm(Form f, MouseEventArgs e)
    {
 
        if (e.Button == MouseButtons.Left)
        {
            f.Opacity = 0.9;
            ReleaseCapture();
            SendMessage(f.Handle, WM_NCLBUTTONDOWN, HT_CAPTION, 0);
            f.Opacity = 1;
        }
      
    } 
    ///
    /// end class methods
 
} 
///
/// end FormMover Class
 
"@

$TitleBarLabel_MouseDown=[System.Windows.Forms.MouseEventHandler]{
    # $_ = MouseEventArgs
    # Use our custom class with the PanelDrag
    # Tie the mouse down event to interact with our main form
    # Send the MouseEventArgs to our class so it can handle them
    $MouseEventArguments = $_
    [FormMover]::OnMouseDown_MoveForm($Form, $MouseEventArguments)
}

$TitleBarLabel.add_MouseDown($TitleBarLabel_MouseDown)

#####################################################################################################

    $form.Add_Shown({ $form.Activate()})
    [Windows.Forms.Application]::Run($form)

} # End of BuildGUI

######
###### Start code
######



######
###### Log function
######

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
    if ($LogPath) {
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

    # Example formatting if you need a full log entry in the GUIConsole
    # ($LogDate + " " + $LogTime + " | Function: " + $GetFunctionName + " | Message: " + $LogMsg + "`r`n")
    # Example formatting if you need a full log entry in the Powershell Console
    # ($LogDate + " " + $LogTime + " | Function: " + $GetFunctionName + " | Message: " + $LogMsg)
} # End of logging function

######
###### Base64 (IS logo)
######

$Base64_logo = 'iVBORw0KGgoAAAANSUhEUgAAAGQAAACWCAYAAAAouC1GAAABhWlDQ1BJQ0MgcHJvZmlsZQAAKJF9kT1Iw1AUhU9TpSIVh3YQcchQddCCqIijVLEIFkpboVUHk5f+QZOGJMXFUXAtOPizWHVwcdbVwVUQBH9A3NycFF2kxPuSQosYLzzex3n3HN67DxAaFaaaXROAqllGKh4Ts7lVMfAKH/wIYRRjEjP1RHoxA8/6uqduqrsoz/Lu+7P6lLzJAJ9IPMd0wyLeIJ7ZtHTO+8RhVpIU4nPicYMuSPzIddnlN85FhwWeGTYyqXniMLFY7GC5g1nJUImniSOKqlG+kHVZ4bzFWa3UWOue/IXBvLaS5jqtIcSxhASSECGjhjIqsBClXSPFRIrOYx7+QcefJJdMrjIYORZQhQrJ8YP/we/ZmoWpSTcpGAO6X2z7YxgI7ALNum1/H9t28wTwPwNXWttfbQCzn6TX21rkCOjfBi6u25q8B1zuAANPumRIjuSnJRQKwPsZfVMOCN0CvWvu3FrnOH0AMjSr5Rvg4BAYKVL2use7ezrn9m9Pa34/krBytKEQsDsAAAAGYktHRAA5AKwA/6gSKgEAAAAJcEhZcwAALiMAAC4jAXilP3YAAAAHdElNRQflAQMTLi8bPo+TAAAAGXRFWHRDb21tZW50AENyZWF0ZWQgd2l0aCBHSU1QV4EOFwAAHWpJREFUeNrtnXd0XPWVxz9vqjRqo1GXZXUJy3I3NhgDNrB0CG0XSCgJkASWnmyWLAmJc9gQFgJkQ0KccDYJEMiSDSEQCB1TjI0xbrIty5YsWb3X0cxo+ts/7ihTNJILtjD2u+fMsTzz5pXf93fv797vvfc3yrIXVBVNjhrRaUOgAaKJBogGiCYaIBogmmiAaIBoogGiAaKJBogmGiAaIJpogGiAaKIBogGiiQaIBogmGiCaaIBogGiiAaIBookGiAaIJhogGiCaaIBoogGiAaKJBogGiCYaIBogmmiAaIBoogGiiQaIBogmGiAaIJpogGiAaKIBogGiiQaIJhogGiCaaIBogGiiAaIBookGyHEmhi/SzZ6RAdVZoAbAHYD2UXD5oDITLDp4twPm2iDbAr4guP3w1D5NQw5KVCCggtUIl+TDDWXgj3PMSVY4swheb4PyTJiTBdW58KVKeKcdelzwzfmwJB9sieAPQKYF/mUmGJQvDiDK57mRsleFr5dBdhLkWKDDCUY9fNgGnwyGj0szwG2zwKSHbhegQEAH+CEALMiBTT1gApJM4FEh4INZNni/BawJ8IeW+PdgMYDLr5ksAKpSZKZ3OGFjF5RbISkB1gxAUsSsHvBBghHMJsAJ67rhvWG4JBsuLYcXd8PsdAgo8EgdOALw8xNhVz9cUAkPbBSQ0k2wIBnmZoKqgsUEeUnw8xro9GqAsGcUWoahOgfyE0GvwIgbbi2GpyNmtB/wB2FwEAa8kGeGTD2sG4Bl2bBmCE4pgHu2glUHGToYdEKaGT5qg0VpcM4MsJqgzw19Tmgfg01DsCAFvlIOD+4C4/G+hlQnQ24SPLIJ3miGuz6Bmj4oSoPl6eHjEhR4dR/MtEFlGpycL6YNoG4YzssEvQ4sCvhV+FYVpBgFEAX4a6/8+3IrPNMMO4agfwyCwOZR2DMINxUex2tIvgmunwUOD/yiQQZyLCAD9KUceKYbfjEf1nbAuwOyqAN8KQ8uPgHeb4YTc6DRDj4/5CTK50Ne8bAaBmFZAXQ74aEacAfhxFRZ8I0K/Lwu9PCh85r08P258O1tkBzx/nGjIZ1eIABvd8CcVEgP2YpL8mHUBzl6+H4NLJ8hJmVcXu6Cv9fDOcXwRgv0u8CsgN0Hdg94/PBOK5yUD40D8KNtAgbAx6NQYYUd/XDpDLi3GoKKeHj/NAOeqIPHFsENJeEJcFyZrFGP2PUkYFayvPd+D1xVDd+phtMzwJYcPVsV4KVOeK0RZtsg1SQLsyG04KeYwGYGux/urwUlYmT1QdjQDmWp0OeA1AQYU0UrbWZoHoPuUajp/3w15HNb1H/fDLfOgk9HYNV8CeTe6offbYMLS+H0fPhNDexyRn/Pp8IsK7gVaBqCh+ohEAQfcHY6nJkHVjMYIqaaXwV7EB5vgRwj3FIK23tlMgR1UJgAJgXMBuj1HEdriArYDHBGLqSZID0B1nfChmH4agkUpIl31OKA+Zlg98Jze2E4EI5b7qqAEQ881wYmHSxMhfwkcPigdhjaPFBugdvnwKrNogG3V4HJBMEg+LzwXje0OSHHBJeVwXMNMOaHm6rgge2QZZTzjItJOcYACagw0wJfKQZVBx4f9LthcR4MueCtVjgrH35YC7OTZEBnZ4LfD1kp8NhOcPjhX8vEbX2+Ha4thKurJagcF5cfNnfAfVsgxwC3VMPuYWgegb/1w6PzJUbx+uWe7B74sBtaPfDjRdAxIvHOqA/SEiDRCL6AmLun9kKv9xgB5J654t280CQD8ZUy8YCCQKUN2uzyfrEVhj3QZ4cNvXBdFdyyGVYvgp/ugG9Uwn/uhB/MEW9rMukahbs+gNIkuGYOvLYXFmXBi02wdhjMOjg7A7aNgj0ANxZBeqKYPmsCDLghwQAP7RRTelMp7B0WTT4mFvW1bRAIQL0Ten1iq1c3Cs3RMgz/XQ+/2AMDLnhouwR8F5eBMwAJQWixw51z4Me1cE2BgLGhHZ7cBoMuGbRx8QQg3QKrlsJr/TLrU4yyWN+yAH66GH44Dy6vFO/uf06FXAuoCgyMwR/3wKpasIQ8vytnQFaiUDTHzKJ+QRnogdsqYE4OrG2FLLMEd16f0BgGBYbdMki77FBTA5flwYMLockuYAWBGxZAXR+81AjfXQo/2ww3z5MIf3Y2vN8EK0ugOhtuLpLjbpwrJnJrJ7zRAUN+qEiSdWZtC/gVKLSCyQiDfkjViYdmUmBmmkyg9UOi5ceEhrQPwq/rYVYmeIKw1w53zYZdvZCfKubKpwo72+GFFTYoscBzHfDITliaA/WD8M0iSDULMMEgmAzwej8YjbAmRLW82CZRO8DZpbDDCU2DcOGnMDsLTs4V52DLCNz5CfyqBeZmgNMJwQCcmglzk+DPDXDfPPD5ZLJMV3wwLdf5v3b41wp4uhaa+uCDQTDo4ZU+uQGjIq4nQWFsG1xweSH8bClcXQSrd0B2shCRADpFeC9UcATFHL7dDZu7o+38jDRI0oE1EV49EV7fB//XLGYtVS8BYiKiXY83QakVlubB7Quh1gUJCWI29wyGrnesADLkg8YRuKwC7t8D1+RLDLEyTQZ3WTrcXi2UhgJ0uuHxPfDvnwotcn4JtIxAdkrYfTYpEplfkSlmr9cLv9kOwQgXJckIS20wMgb/sQXe7IHiRHhoKdy7AOoGZQC2DsK5NgHUaIDfbYf/Wgwdw5CRACfmiVYeU4FhhwMahuAEMyzME5MzPwf2DMCSLLhtkzC1kTHLeRkh6t0s2b9xQjEYFPb3w3a4dQE0h7Rixyi4AhKTWM3yXoUN9o7IwN9xgmjB9n65nzoXJOok7pmXCtuGYEUhbHZAbgtUZkCDHX6ySzTtmALk9R7591tVMts398oAn5YHD9eFwTAoUJIAS7Lh1CLod8KaNkjQS0wAkg1s98APS2XB/agFllolOu90Q58rDMi6LrjuBKjKhIAfHtkGigIXzoRHZ8APtkDPGMwogCSz3NvFOfBmL/T4JD56rfMY5rLG/JBshHdG4NR8eGR3+CaWp8Nd1bA4R4Ky9hFoG4aLS6HJBX2joXN4YUm6gAFQOwpfroQzc2VdGHCEA8UWp7DA77VBshnOK4CLCiEzGer6YW4aDPjF1DWMwF9aYGYynJ8FlxbDi9Ock592QAJB8envrYS0xDABONsCF5SCywO5Jhh1i2la0wUftEJ5EtT2y7H9Y3BivvzdOgynZYsHl2KBU4okpwKyBowGwe+DimT4cyP8Zi/8cg/oArC6BbaPyIL9+F5Jdu1zSXBamQE7eqFx7BgnF59shGsKoTRDZsP4GnxhCazaIu6vIg4XD2RAgwe8A3BZsQSQV8+VhffkmfK9YQ/8U7nM8MX5spBX2sSVfq9FXNihMehwCYdm1MPSTEkVe4KAXtaHr1dKAuz788DphVQj/LmTaZdp1xAFeLYF/ncP2F0CiAfIssDdc+C2Sslh3FAMXU5Q/bDXDUVWGArC77fCeeXh883LCbvCSaHo+oxi2DsAP2+Cf6mAlzrg3UFZn/JMYHdLoHlHUSgVEBBtSDaANyA0/h/rjwO2F2C5VapEkgySfq22gVEHv90Nl8wUDuvUPHGLX+6RQbwsXwLC3EShTx5aCGeWTX6NHgfcHeKyTsqXOGTvoFxn0AV/7YRVC4Sz2tgF7w1KLHT1TNG0p1vF+zouElQLs+CVVkhNhKosWbTvr4E2t0TexSlQNwBLC+DuE4RiOSkPdg5CiQ2uL4B7t8GvNgkNHzmb/EH4uA2uf0dY3bOKZC14eCv8vhE+7oHcZPj2XBjwwEO1kuhaNR9uKYd3uqEoBSqTjpN8CMCt5bBnWLytNwaFN4pMPp2fBQtzoXkI1vQJw9vlhPJ0uGIjPDFLqhafaIREA5yfKebO44ePB6DeBYtS4KoKISqvKYaFOfDHOliSA0/uhRYPpOlE+1TAqUK1BW6cBZ2j8PcOqUo5LgC5eza82gRXVcKDO8WTihWfClcXwIpi+MNOOKdEPKXdA1KQ4A9CcTps6YUPh4T/StbDySkSZGaZ4ZNeyE2QKkYFmJUFd30cPz2rAmdnQnWmgN/rgvcHPh9ApsXLMunC5ZwmnczUZxvgntnweN3E410B+EsH/K0Tri0BqwGeb4aKdJiZJMmrXUNwURlcEBS2GASsHg+kGeFKG2zrgX1OaLVLniOoiourAgm6MD9VYIb5WfBoHVSnQlUyWPTRCTZvcHqKH6ZFQ364SAoLxt3ZpbmwpRPyrdBunzhbTToxa/MzJbgzKJLEcgRhwwDMTZV4ZVGeJJ3qvXDfCdA3JpTI7Ez4dRN8rRhGnZCXImRmilmCxmE/5FvCeZREA5SkwycdUidm0Mn6NC6FqfBIDfT7jhENqe2WQf1Th/x/dQOUJEF9Q3S+OkEHN5bLgBQkw0O74OxsyDbBDKvQ4/UjcFIObO6R48ZUKVwotIHRARmJkly6JE8W9V9uhTn5UN8LtYMw4oez82Ud2tYneQ5Crvc/50HTKHzYH9ae6iS4xCyJNd2xoiFjQXjkRPi3zVIUN5n4gPvmwJ018L/L4dNOKWBQdZKW3TEAxWkw6BYCsSgFOp1SONE4JoHfziGhzNPNUkTXMwZnFUK/A2ZniOlpcUg5qc0AL3VPfj8qkmv/7hZJCxwza8g5NilqS9xPTkGPkIipevioFbYOQbYD1KAUSJ9TBJsH4MxCcHjBZoGBUcmHnxQARQ9jHnAqMMMiGmdNgJebIS8Rnq6XZFSWUWKdB2qnrsFSgLeb4e5y+NXeYwiQiyqgpheuLzkAbVLh1kJJpZ5fIFT9T7eC2ytBnVkvDkGqXhjdBMR0KYpUuNt9QiheWSxB5onZUJECK0thdKfk6B9tghdWwHWF8r0pRYXiDDA1iXYdEyYry3jg+QS/CtecAM/XQ2malOoEgaVZYEsCRQd+ryy6Tj+M+mVx1imQpBcGINUkORSDHhwuqQFutEOhBVIt0GuHkjR47wC5Kq8K3d7pSVJNi4b0+aDvYBjhAJw/ExJM0rI27JLitg12SbmaFQFgKvGpwvQWmIWuOTlH3OJkA1Snw+paGeSjTT7XDqpJ6ZUUcAI77DL4h0uCSFPPBVnwdi9HpRyVgBzPorVFa4BockiLerJeOJyxcXpBJ4GSOxiNZqoeRgLymV6B5DgQ2/fzuSsoizBIXiJJN5E38qly3Hh8kKaXFoNgzIEmReIPe0ztp06R7zgC4WuB9LfHq0gMIokrkyLPPv4MILXBCcrkzznVeCWHxks5GECGAvDCudA2BN/aKCe+f7H07N2wNvwA1Vb49Vlw3ZvQ5IAzs+B7y0Nqp4T9+K++BQ1OWH0KVGVH+/6qKvW3l68RD+rqIrhpYejrEedw+eDH62DdEBQlw7PnwupN8FxMu/O/VcOKErj0dSkdGpeLc+A7p8AfaiSNPE4a/my5MMGoAq5Okev2OuDKt+EbZfDPc+Hrr0OjW2ic1WdIlWXkqAZVWN8C92yW51+1WFoublkXPuxkK9y/Asr/AsWGg9QQvRJdradXoDxDSnTaPeGZGiog/MesMuvgdzXQMhqmHzrHJAIvTYft3fBKU/i8J+fB+WXC0Hp98mAmHTy4ITyg6Wa4cwksyhBA1NBsW5ILTzeHmeSAKsUO5jgalp8sz1CWFq01T+6QDiprInxrMTxbK/VjLr9MFh2SafwH0ZgoLRCv1cOmvvAzXlslGxq4gmIFjArMy4UMEwxGuNcG3dTxzEHFIQkGuGgm/Ho/NELTMKzpjzEZoUGyu+HtnvD7ZalhMCPlk/5wN1OVRZ46EDPKlRkwBoy3IfoVKLVJ3VaslKZJAJmTKibLqMhk2hwqsqsM3UeLPfr+JgTuoXvocYSPC6hwebn0lkRqvwLcXAE/qT3wNrmDXtTPLIGR4NGxACaZJSk1Lpflxa/B9auQmwZ/2yuJLac6NVVyOGVx/sG1MhwUICMeyUmfmX50AGLUwUJbeBxPyZUZrMbhxwrSoKZHzGFV8vTc36hXisSXpR0hQPocoqrnzTw6AOl1SaZPRXZ7KLfBYJymzcpkWVca7TKpVmZOz/11jsCefrio+MAV76AAMYVo8SUFQrgdaa0PqGJugmr8c77bAhXZ4m7mGaU8dGv3RHu9IgOG3NDlA4cbKtKmJx1rNMCmTji5EEYO8IIHTS4+0wRXzoEzMsVPjyfnF4v5AOlc+mUDmA+a1IHHlkrzpSGU//bGXK9uAL5cJd1Qs5NlZ5/GATitIHpyzEoH+5jEIL0uyEmW9490y4eiwJsdUm1544zQTkaHe1Hv9sKePriibGJQNi4VWTAvX16zc6bWpkmJQFW8uiIrtA/DMzXwu5iYw+6XMtHL8mFlPtQPSH489jx5KdDtkIftcwgg09WAU+eSDq7TC44gdbKxQ3r4EifRr0c2wPlvyOsbaw+tt0IHvNksZZ0vNourHTsBvAFoG5EChfIsaZGLpeX1OllY+5xyztZRsFokap8OSdDBW/tkcgbVIwTIE/vE5cxLiP+5WS8FcKk6oSYOVf7aKYvwNRUTY5DxwK6uTybHjBTYHifpkmmQbTRqQwHlB31i2vITps/5eKFNqv6X5YfjmMO2hgAoAdjUDtfPOcKLogLbu2BBnjgUgTjxz/OtcNVcierXDEqHVKTMTBRNPr1AGj7Hx2OeDXY5pgeQAFDTCSuL968lhzR/dYp4OPnT4M+v7ZB6qguy43/eNgZdDtg3DCNx6qaq0gWEDIt0/OanCnhzbNO768977VLyatAdAUAAXumVfPeRlmc6JcA6szD+7DIpsG8AansmVqyrwPwMaVO7ag1c/z5c/544JXlpof6QaZKnO6SX5YisISBFazVdh+Y96ZTwa38qnK6DjW2weEZo48s4sr0fXm2f+L4rCLlWGHLK4qqEtLvHIdWI7s/gaanB8DPoFfn/VJKph7UH0B4Xdw0JIgxqpGuoU6K3W9UpUud0WnHYsxn/PF5pjU+VIulTCuEveeH3LQYJ/lx+KUYzxpxDAV5thrPK4PZS+E1jeBaNX/e3++Ta4+yzEvobHcxMgbd6omOOdocQgQuSoDkUG+hjzhnJcusiZq4zFAtdOQ++VB0+zmqWslhDBLEYOwxvtcG5FVOzvfqZV/7oRxNQUiDJDzv7YU+oJtcYkH1JdtjDF+r3guKBTYOi/sEgBD2wvlfqZ2NVsbYHfG5oGQq/9g7AU7XQNRbWPM8YrOsPJ5K6PKC4ocsF9Q7RKosfPuqVYE+vhO9JF4RhB2wclOSZxQ9rOqE7wlx4veB2Q/1w+D6DKph8sL4PBiPWIiUoGra+X+q+er3QNwxDjujnqOuDX9VKobiigCkArSOwYyRiInjA7JVC8cm26dCKHI4ymdTt9amwyCqJo3hc1cahcN/4OPO6zBZfHRWg0SE95CBJm9mpk3s5viCsHQzX09qMUJ0mG5rV2Ccen2eG8hTodYtGA5RapMK93wN1o9HmIzcBypPj32ePB3bao4vAq1MkSRZP3AHRxnFTN6bCqTZpZ1DjcHPrB6O3HjwgQPwq/HgBnFs++RcHXPC1t6XHGyDTBP+1YvLjX6qFh3eHyL4s+M7JU8+UliG4+j25+apkeGiF2Oir35noCFxbBpdVwdsNsGq7DMR15WKvP+2A2z4Or28X5sC9y6cutHt6m6xV44N4x/xwc2msDLth8d9k404F+J9l4oBMSj05YOVrYNMfBCCDQVgWoth39MCYL3oWVWWLXz/HCh/0RzO83gDUdEdHpAqwZyTa0wJxm3fHia4Xz4C8VChPhEYXNDll0bcmysx1xwCSF+oJrB+O79VFpOY5tUDA6BoV2iVSbImSpl6SD6v3ynEK4WdpGpKdJaL4NC8kK+FAtjxLrlnTHW1BVFWeK8MCQyrYDjVSX10LWwajGcznz4JkU3y21OWDb2+MvhkiPZ8I6RmFOzfEaCfw4aXRHl2nT3ZvyLBAthlax6LNQGaKDELr6IHb6p3d8IOa6PeuLxJAJqOB398HTzZNfD+Wq/Or8OgW2Btxn20BaLhCTLvyWeIQgxIdN+iYumJcifcdJf5NKHGOi3d+f1BiB5BKl6j1BqkA8QZg20FQIYoS//pTBm26OPerxB+D2GMOlKP6QhTKGRToDZmKRTG6bjNJDOD0hqthvsjyhQBEQXaUA9ml1B+xhpwY0phW+9TdWZ/7MyifARBdyEyAUOyxXprdLS/vNHJB485DbrK4luOyJKQx3SOffU9Ed0A2Oxs9RE1TEUZap0hrdlQEjmyoY3dPfZ9xTZtNDx80iyt5x2Lp29s3Fr7oVz+SxTRRmb5tuesdwgZkJEqPB0GJebJD8cSmw9BX/nw7PNUmJvJQNk/2qbC7R3Yk+t4yuOFdYTNA3OLz3pQBnKk/BA356S5hRZNN8Ohp0is+LmbEPEynhdCpsje7UQ+ViWEPKzcEyM6hw2O/Lcpna/D8zhahmDIs8Ngp4I74LJH991lOuYZ8cx30OCE3BR5YOvG3oSZTW3dQYoXx1/5y6j6k6nD8Fe9wvSKdtCa97HwNUmOVbgltvjwN3VDBmOdyq3GYiSB8b500pZZnwC+XHFzeZUpvzBeA+z6CX5wlzZcPzofvbZu6QCDZBM+tjL6JES/cti6+RgUU+NNK6aT9x0zSixvri3mS9lFYjBQt0AfZRulJ73dGV5kfKbmwUrb7iHQ2nqqFd2K6sfa54UcfwU9WwLJCuG0Ynmg4MIuyXy+r1gGPbZBF/owy2R1hKsQNOqmvLYt4laRPnVcYGhNATAYZ2A47vL4H9saUzXSHAr/C5DCHZTFK1D0dDGlOcvRzldrCezvGyvoheHqrgHDtPLgk9zBoyLi82gOltVJfdPNi2b5izSSL6IgHbloTXfAcUKfoh1DglX1CKwy54PJ35LegxreCjZRtI0JB5KWK61sSKtHscU7PevbcDvhzTCnSyBTbbfy2Rcz9xSfAnUuhYQ3UOQ5THPLwHviwWVy6e5ZNUbWhyl5UvRGvgf3Y9zd6ZN/1/FQ41Tr5bF8/IuBmJYNLDVes7xliWsQXiH6uXs/UaWAdsifXrh7R5IdPgwzDYQIkQYH7tkLDgOzu9tjy6L6Jz+rd7OwWsM+aoqAsEIROh2wQo+hgZigoXDdNgBySI6DCN9dDp108rweXhTvBDhgQV1D2HHlwIRRbojmlOz4Ss1RohcWph+/G14Y2pjmlSPZWjOswKNAVyocsS5PF3eGTde5wyPJ0+MkCuLns0NYkvQLfnwP3z5fNEiK9s++uE+2uyoTOgwVkVJVc+YpS+amGqM/8Es2ClHoeLnm2Swqi0xPga5PkE3QK7AtpwyKrlNV02GV3uMMhZamwsgyWzNh/QVtcQIDTSmTcrDFjs3ZU9pwP7scs6SbjjsbvJ+6NHYEVNF0HG1rl76nqYGtDgBRaBaBe+/T+JNGBxGGR/zLVOB7N5KICvNkqDzI7Z3K+p9UhHlZFpgDSMMIxJUcV2/vxiHS/ppnhsknMVqtXyL+iUCtbu/3YAmS/q4ArAD2BGHO2n2advoD8cmekpCj7L7zWAVu74LwK2fjymbaJ/eB2v7Cm6QkSze92HtqDB4LyXJGn9+0n2vfHjMX4PWfpJ45B7Li1Bj4DIArh3UIfOz26yFkJ0SPjXlespJrho4smgra2GR48gA3Dft8ggJTaoDQBOmOocCOy/2KhVX5tbZcLLAfJR4EsvJtjfv/WFPFzGPHyF1+eB1dUx4AUhFP+DlmhLuPxtu7fnjOxGCPRIGMZPFiTlamHP+6UBL5ZL0HN+CvRKO7b1i7YNBw9K/yqzLJEQ/R3LMbww4b4N7zB+PmU1jHY3S/p0nPy43taXaNyjg6HFLLFDeKC4tX4Yoot/tQgxdmKMvEeDTrZPvDl+oma4wnI57HfSTSGB9inwuv14PSJBxp7rDsgGz3PmIJ+n7JQrj8AkwXZmbpo70YFOqfYMiJNCRcD+FToCwrVbY23FUcQHKp4XvHoao8K3QFxd62TmEFXEIZVMZUpMcc4gmCf5KkTgXR9/PuZbEbn6aM3T+gPxGfGFUSTDMohAqLJce5laaIBogGiiQaIBogmGiAaIJpogGiAaKIBctzL/wMcze42wCiRVQAAAABJRU5ErkJggg=='

$Content = [System.Convert]::FromBase64String($Base64_logo)
Set-Content -Path $env:temp\logo_panel.png -Value $Content -Encoding Byte

######
###### CALL THE GUI
######

StartTheShow

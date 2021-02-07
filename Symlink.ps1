[CmdletBinding()]
param(
    # Symlink path to be created
    [Parameter(Mandatory=$True)]
    [String]$SymlinkPath,

    # Value to link to
    [Parameter(Mandatory=$True)]
    [String]$SymlinkValue
)

Try {
    if ((Test-Path -Path $SymlinkPath)) {
        throw "Symlink path already exists!"
    }

    if (!(Test-Path -Path $SymlinkValue)) {
        throw "Symlink value does not exist!"
    }

    New-Item -ItemType SymbolicLink -Path $SymlinkPath -Value $SymlinkValue -ErrorAction Stop
}
Catch {
    $_.Exception.GetType().FullName
    $_.Exception.Message
}

# Small code snippet that can be used to force a script to elevate. Copy and paste at the top of your script and comment/uncomment the function call as needed
Function ForceRunAsAdmin {
    if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Start-Process PowerShell -Verb RunAs "-NoProfile -Command `"cd '$pwd'; & '$PSCommandPath';`"";
        exit;
    }
}

#ForceRunAsAdmin # Uncomment to enable ForceRunAsAdmin

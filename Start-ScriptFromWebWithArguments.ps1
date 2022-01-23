$url = & $([scriptblock]::Create((New-Object Net.WebClient).DownloadString("https://raw.githubusercontent.com/pbatard/Fido/master/Fido.ps1"))) -Win "Windows 10" -Ed "Pro" -Arch "x64" -GetUrl

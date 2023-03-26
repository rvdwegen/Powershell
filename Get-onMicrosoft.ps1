# Assumes you are already connected to Graph and have relevant permissions

(Invoke-RestMethod -Method 'GET' -Headers $header -Uri "https://graph.microsoft.com/v1.0/domains?").value | Where-Object { $_.isInitial -eq $true }

$onMicrosoft = ((Invoke-MgGraphRequest -Method 'GET' -Uri "https://graph.microsoft.com/v1.0/domains?`$select=id").value | Where-Object { $_.id -like('*.onmicrosoft.com') }).id

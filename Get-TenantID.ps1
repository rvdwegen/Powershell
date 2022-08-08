# Oneliner
$UserPrincipalName = "Bill@Contoso.com" # For example: Bill@Contoso.com
(Invoke-RestMethod "https://login.windows.net/$($UserPrincipalName.Split("@")[1])/.well-known/openid-configuration" -Method GET).userinfo_endpoint.Split("/")[3]

# Or use as a function,

Function Get-TenantID {
    param (
        [Parameter(Mandatory)]
        [String]$UserPrincipalName
    )

    $Tenant = $($UserPrincipalName.Split("@")[1])

    $Params = @{
        Method = 'GET'
        Uri = "https://login.windows.net/$Tenant/.well-known/openid-configuration"
    }

    $Payload = Invoke-RestMethod @Params

    $TenantID = $Payload.userinfo_endpoint.Split("/")[3]

    Return $TenantID
}

Get-TenantID -UserPrincipalName "Bill@Contoso.com"

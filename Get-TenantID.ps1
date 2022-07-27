$UserPrincipalName = "Bill@Contoso.com" # For example: Bill@Contoso.com
(Invoke-RestMethod "https://login.windows.net/$($UserPrincipalName.Split("@")[1])/.well-known/openid-configuration" -Method GET).userinfo_endpoint.Split("/")[3]

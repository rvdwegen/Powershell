Function Get-AzADoauth2Token {
    param (
        [Parameter(Mandatory)]
        [MailAddress]$UserPrincipalName,

        [Parameter(Mandatory)]
        [string]$Password,

        [Parameter(Mandatory)]
        [string]$tenantID
    )

    # Create $tokenBody
    $tokenBody = @{
        Grant_Type    = "password"
        client_id     = '1950a258-227b-4e31-a9cf-717495945fc2'
        resource      = '74658136-14ec-4630-ad9b-26e160ff0fc6'
        username      = $UserPrincipalName
        password      = $password
    }

    # Create $RestMethodBody
    $RestMethodBody = @{
    Uri = "https://login.microsoftonline.com/$tenantID/oauth2/token"
    Method = 'POST'
    Body = $tokenBody
    }

    # Get token
    $tokenResponse = Invoke-RestMethod @RestMethodBody

    Return $tokenResponse
}

# Effectively using basic auth, unknown if this will stop working after October. Figure out a Modern Auth way regardless.

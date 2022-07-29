$Body = @{
    'Param1' = 'Value1'
    'Param2' = 'Value2'
    'Param3' = 'Value3'
}

$Params = @{
	Method = "GET"
	Uri = "https://yoururl.tld"
	Body = $Body
}

Invoke-RestMethod @Params

# the above basically does this,
# Invoke-RestMethod -Method GET -Uri "https://yoururl.tld?Param1=Value1&Param2=Value2&Param3=Value3"

# Forego the double splatting by just defining $Body and using this,
# Invoke-RestMethod -Method GET -Uri "https://yoururl.tld" -Body $Body

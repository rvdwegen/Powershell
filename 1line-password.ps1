(((Get-Verb | Get-Random -Count 3).Verb) + (('+-*=@$^%_&#?>/').ToCharArray() | Get-Random -Count 1) + (('0123456789').ToCharArray() | Get-Random -Count 1)) -Join ""

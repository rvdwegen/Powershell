# Do not hardcode credentials in production, obviously.
$username = 'Account'
$password = ConvertTo-SecureString 'Password' -asplaintext -force;
$cred = New-Object -TypeName PSCredential -argumentlist $username, $password

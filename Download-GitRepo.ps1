$RepoURL = "urltorepozip"
$RepoName = (([uri]$RepoURL).Segments[2]).trim('/')
Invoke-WebRequest $RepoURL -OutFile .\$RepoName.zip
Expand-Archive .\$RepoName.zip .\
Rename-Item (".\" + $RepoName + "-main") .\$RepoName
Remove-Item .\$RepoName.zip

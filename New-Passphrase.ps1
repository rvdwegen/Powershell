Function New-PassPhrase {
    param(
        [Parameter(Mandatory = $false)]
        [ValidateRange(2,20)]
        [int]$WordCount = 3
    )

    $SpecialCharacters = @((33,35) + (36..38) + (40..46) + (60..62) + (64))
    $Numbers = @(48..57)

    $url = "https://raw.githubusercontent.com/rvdwegen/Powershell/main/WordList"
    $List = Invoke-WebRequest -Uri $url
    $FullList = $List.Content.Trim().split("`n")

    # Needs some more randomization for the SpecialChars and numbers
    $Password = ($FullList | Get-Random -Count $WordCount) + ([char]($SpecialCharacters | Get-Random -Count 1)) + ([char]($Numbers | Get-Random -Count 1))

    Return ($Password -as [string]).Replace(' ','')
}

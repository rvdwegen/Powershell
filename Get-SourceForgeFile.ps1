# Example using MPV Player
$filename = ((Invoke-RestMethod -Uri https://sourceforge.net/projects/mpv-player-windows/rss?path=/64bit | Select-Object -property link -Last 1).link.split("/")[-2])
$fullurl = "https://download.sourceforge.net/mpv-player-windows/" + $filename
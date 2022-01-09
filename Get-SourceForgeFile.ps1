# Example using MPV Player
$filename = ((Invoke-RestMethod -Uri 'https://sourceforge.net/projects/mpv-player-windows/rss?path=/64bit').link[0].split("/")[-2])
$fullurl = "https://download.sourceforge.net/mpv-player-windows/" + $filename

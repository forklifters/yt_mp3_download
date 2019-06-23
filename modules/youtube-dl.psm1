function GetVideoTitle ($url)
{
    return ./bin/youtube-dl.exe --no-playlist --get-filename -o "%(title)s" $url
}


function DownloadVideoAndExtractAudio ($url)
{
    if (![System.IO.Directory]::Exists("./output"))
    {
         New-Item -ItemType Directory -Force -Path "./output"
    }


    ./bin/youtube-dl.exe --no-playlist --format bestaudio --extract-audio --audio-format mp3 --audio-quality 0 -o "./output/__tmp.%(ext)s" $url
}
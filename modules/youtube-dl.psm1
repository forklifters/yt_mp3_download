
function GetVideoTitle ($url)
{
    return GetExeOutput $(& ./bin/youtube-dl.exe --no-playlist --get-filename -o "%(title)s" $url 2>&1)
}


function DownloadVideoAndExtractAudio ($url)
{
    if (![System.IO.Directory]::Exists("./output"))
    {
         New-Item -ItemType Directory -Force -Path "./output"
    }

    GetExeOutput $(./bin/youtube-dl.exe --no-playlist --format bestaudio --extract-audio --audio-format mp3 --audio-quality 0 -o "./output/__tmp.%(ext)s" $url 2>&1)
}
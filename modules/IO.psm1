function GetVideoTitle ($url)
{
    return ./bin/youtube-dl.exe --no-playlist --get-filename -o "%(title)s" $url
}


function DownloadVideo ($url)
{
    if (![System.IO.Directory]::Exists("./output"))
    {
         New-Item -ItemType Directory -Force -Path "./output"
    }


    ./bin/youtube-dl.exe --no-playlist --format bestaudio --extract-audio --audio-format mp3 --audio-quality 0 -o "./output/__tmp.%(ext)s" $url
}

function SaveAudioWithMetaData ($metaData)
{
    $destFilename = "./output/$($metaData['artist']) - $($metaData['title']).mp3"
    Remove-Item $destFilename -ErrorAction Ignore

    ./bin/ffmpeg.exe -i "./output/__tmp.mp3" -c copy -metadata artist="$($metaData['artist'])" -metadata title="$($metaData['title'])" $destFilename

    Remove-Item "./output/__tmp.mp3" -ErrorAction Ignore
    Write-Host "`nSaved file as $destFilename`n"
}
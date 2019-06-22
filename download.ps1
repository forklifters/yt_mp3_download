Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"


function GetMetaDataFromURL ($url)
{
    $videoTitle = ./youtube-dl.exe --no-playlist --get-filename -o "%(title)s" $url
    $videoTitle = $videoTitle -replace "(\s|\()feat\.",'$1ft.' # 'feat. xy' -> 'ft. xy'
    $videoTitle = $videoTitle -replace "\((ft\.[^)]*)\)",'$1' # '(ft. xy)' -> 'ft. xy'

    $titleFragments = $videoTitle -split ' - '
    $artist = $titleFragments[0]
    $title = $titleFragments[1]

    if ([string]::IsNullOrEmpty($title)) # no ' - ' in video title -> cannot determine artist and title
    {
        $title = $artist
    } 
    elseif ($title -match "(\sft\.[^(]*)($|\()") # move 'ft. xy' to the artist and remove it from the title
    {
        $artist += $matches[1]
        $title = $title -replace "(\sft\.[^(]*)($|\()",' $2'
    }
    
    return @{
     'artist'=$artist.Trim() -replace '\s+', ' '
     'title'=$title.Trim() -replace '\s+', ' '
    }
}



function PromptMetaData ($metaData)
{
    Write-Host "`nYou can override the auto-detected artist and title of the video « $($metaData["artist"]) - $($metaData["title"]) »`n";

    $artist = Read-Host -Prompt "Artist  « $($metaData["artist"]) » "
    $title = Read-Host -Prompt "Title  « $($metaData["title"]) » "

    if ([string]::IsNullOrWhiteSpace($artist))
    {
        $artist = $metaData["artist"]
    }

    if ([string]::IsNullOrWhiteSpace($title))
    {
        $title = $metaData["title"]
    }

    return @{
    'artist'=$artist.Trim() -replace '\s+', ' '
    'title'=$title.Trim() -replace '\s+', ' '
   }
}


function DownloadAudio ($url)
{
    if (![System.IO.Directory]::Exists("./output"))
    {
         New-Item -ItemType Directory -Force -Path "./output"
    }


    ./youtube-dl.exe --no-playlist --format bestaudio --extract-audio --audio-format mp3 --audio-quality 0 -o "./output/__tmp.%(ext)s" $url
}


function SaveAudioWithMetaData ($metaData)
{
    $destFilename = "./output/$($metaData['artist']) - $($metaData['title']).mp3"
    Remove-Item $destFilename -ErrorAction Ignore

    ./ffmpeg.exe -i "./output/__tmp.mp3" -c copy -metadata artist="$($metaData['artist'])" -metadata title="$($metaData['title'])" $destFilename

    Remove-Item "./output/__tmp.mp3" -ErrorAction Ignore
    Write-Host "`nSaved file as $destFilename`n"
}


$done = $false

while (!$done)
{
    $url = Read-Host -Prompt 'Enter a youtube URL'

    $metaData = GetMetaDataFromURL $url
    $metaData = PromptMetaData $metaData

    DownloadAudio $url
    SaveAudioWithMetaData $metaData


    $input = Read-Host -Prompt 'Download another video? « y | n »'
    if ($input -ne "y") 
    {
        $done = $true
    }
}
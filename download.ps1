#Requires -Version 5.1

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Remove-Variable * -ErrorAction SilentlyContinue; Remove-Module *; $error.Clear(); Clear-Host

Import-Module ./modules/youtube-dl.psm1
Import-Module ./modules/ffmpeg.psm1
Import-Module ./modules/metaData.psm1
Import-Module ./modules/prompt.psm1


$done = $false

while (!$done)
{
    $url = Read-Host -Prompt 'Enter an URL to a music video'

    $videoTitle = GetVideoTitle $url
    $metaData = ExtractMetaData $videoTitle
    $metaData = PromptMetaData $videoTitle $metaData
    $prefix = PromptPrefix

    DownloadVideoAndExtractAudio $url
    SaveAudioWithMetaData $prefix $metaData


    $input = Read-Host -Prompt 'Download another video? « y | n »'
    if ($input -ne "y") 
    {
        $done = $true
    }
}
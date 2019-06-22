#Requires -Version 5.1

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Remove-Variable * -ErrorAction SilentlyContinue; Remove-Module *; $error.Clear(); Clear-Host

Import-Module ./modules/IO.psm1
Import-Module ./modules/MetaData.psm1


$done = $false

while (!$done)
{
    $url = Read-Host -Prompt 'Enter an URL to a music video'

    $videoTitle = GetVideoTitle $url
    $metaData = ExtractMetaData $videoTitle
    $metaData = PromptMetaData $videoTitle $metaData

    DownloadVideo $url
    SaveAudioWithMetaData $metaData


    $input = Read-Host -Prompt 'Download another video? « y | n »'
    if ($input -ne "y") 
    {
        $done = $true
    }
}
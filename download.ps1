#Requires -Version 5.1

Set-StrictMode -Version Latest
Remove-Variable * -ErrorAction SilentlyContinue; Remove-Module *; $error.Clear(); Clear-Host


Import-Module ./modules/inputOutput.psm1
Import-Module ./modules/youtube-dl.psm1
Import-Module ./modules/ffmpeg.psm1
Import-Module ./modules/metaData.psm1


$done = $false

while (!$done)
{
    clearConsole
    $url = ShowPrompt "Enter an URL to a music video"

    #
    #
    #

    clearConsole
    ShowText "Fetching video information ..." -fc DarkCyan
    $videoTitle = GetVideoTitle $url
    $metaData = ExtractMetaData $videoTitle

    #
    #
    #

    clearConsole
    $metaData = PromptMetaData $videoTitle $metaData
    $prefix = ShowPrompt "File Name Prefix (optional) "

    #
    #
    #

    clearConsole
    ShowText "Downloading video ..." -fc DarkCyan
    DownloadVideoAndExtractAudio $url

    #
    #
    #

    clearConsole
    ShowText "Converting to mp3 ..." -fc DarkCyan
    $destFilename = SaveAudioWithMetaData $prefix $metaData

    #
    #
    #

    Clear-Host
    ShowText "Saved file as  « $destFilename »`n"

    $input = ShowPrompt "Download another video? « y | n »"
    if ($input -ne "y") 
    {
        $done = $true
    }
}
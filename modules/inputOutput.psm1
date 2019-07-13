function GetExeOutput ($exeOutput)
{
    $stderr = $exeOutput | ?{ $_ -is [System.Management.Automation.ErrorRecord] }
    $stdout = $exeOutput | ?{ $_ -isnot [System.Management.Automation.ErrorRecord] }

    If ($lastExitCode -eq "1" -Or ! [string]::IsNullOrWhiteSpace($stderr)) {
        clearConsole
        ShowText $stderr -fc "Red"
        ShowPrompt "`nPress any key to exit"
        Exit
    }

    return $stdout
}


function ShowPrompt ($msg)
{
    $out = Read-Host -Prompt $msg
    return $out.Trim()
}


function clearConsole ()
{
    Clear-Host
}


function ShowText ()
{
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$msg,

        [alias("fc")]
        [String]
        $color=""
    )

    if (! [string]::IsNullOrWhiteSpace($color))
    {
        Write-Host $msg -ForegroundColor $color
    }
    else 
    {
        Write-Host $msg
    }
}


function PromptMetaData ($videoTitle, $metaData)
{
    function trim ($str) 
    {
        return $str.Trim() -replace '\s+', ' '
    }

    ShowText "You can override the auto-detected artist and title of the video « $(trim $videoTitle) »`n";

    $artist = ShowPrompt "Artist  « $($metaData["artist"]) » "
    $title = ShowPrompt "Title  « $($metaData["title"]) » "

    if ([string]::IsNullOrWhiteSpace($artist))
    {
        $artist = $metaData["artist"]
    }

    if ([string]::IsNullOrWhiteSpace($title))
    {
        $title = $metaData["title"]
    }

    return @{
     'artist'=trim $artist
     'title'=trim $title
    }
}



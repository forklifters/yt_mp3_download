function PromptPrefix ()
{
    $prefix = Read-Host -Prompt "File Name Prefix (optional) "

    return $prefix.Trim()
}


function PromptMetaData ($videoTitle, $metaData)
{
    function trim ($str) 
    {
        return $str.Trim() -replace '\s+', ' '
    }

    Write-Host "`nYou can override the auto-detected artist and title of the video « $(trim $videoTitle) »`n";

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
     'artist'=trim $artist
     'title'=trim $title
    }
}



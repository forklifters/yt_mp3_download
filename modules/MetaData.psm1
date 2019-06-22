function ExtractMetaData ($videoTitle)
{
    $videoTitle = $videoTitle -ireplace  "(\s|\()feat\.",'$1ft.' # 'feat. xy' -> 'ft. xy'
    $videoTitle = $videoTitle -ireplace  "[[(](HD|HQ)[])]",'' # '[HD]' -> ''
    $videoTitle = $videoTitle -ireplace  "[[(]?official (music|lyrics?) (video|audio)[])]?",'' # '(Official Music Video)' -> ''
    $videoTitle = $videoTitle -ireplace  "[[(]?(official|music|lyrics?) (video|audio)[])]?",'' # '(Official Video)' -> ''
    $videoTitle = $videoTitle -ireplace  "[[(]?video edit[])]?",'' # '(Video Edit)' -> ''
    $videoTitle = $videoTitle -ireplace  "[[(]?original mix[])]?",'' # '(Original Mix)' -> ''

    $titleFragments = $videoTitle -split ' - '
    $artist = $titleFragments[0]
    $title = $titleFragments[1]

    if ([string]::IsNullOrEmpty($title)) # no ' - ' in video title -> cannot determine artist and title
    {
        $title = $artist
    } 
    elseif ($title -match "(\s|\()(ft\.[^()]*)($|\)|\()") # move '(ft. xy)' to the artist and remove it from the title
    {
        $artist += " " +$matches[2]
        $title = $title -replace "(\s|\()ft\.[^()]*\)?",' '
    }
    
    return @{
     'artist'=trim $artist
     'title'=trim $title
    }
}


function PromptMetaData ($videoTitle, $metaData)
{
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

function trim ($str) 
{
    return $str.Trim(" -_.;") -replace '\s+', ' '
}

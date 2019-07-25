function ExtractMetaData ($videoTitle)
{
    function trim ($str) 
    {
        return $str.Trim(" -_;") -replace '\s+', ' '
    }

    $videoTitle = $videoTitle -ireplace  "(\s|\()feat\.",'$1ft.' # 'feat. xy' -> 'ft. xy'
    $videoTitle = $videoTitle -ireplace  "[[(](HD|HQ|audio|video)[])]",'' # '[HD]' -> ''
    $videoTitle = $videoTitle -ireplace  "[[(]high (definition|quality)[])]",'' # '[High Quality]' -> ''
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
    elseif ($title -imatch "(^|\s|\()(ft\.[^()]*)($|\)|\()") # move '(ft. xy)' to the artist and remove it from the title
    {
        $artist += " " +$matches[2]
        $title = $title -ireplace "(^|\s|\()ft\.[^()]*\)?",' '
    }

    $artist = $artist -ireplace "\((ft\.[^)]*)\)",'$1' # '(ft. xy)' -> 'ft. xy'
    $artist = $artist -ireplace "\sFT\.\s",' ft. ' # 'Ft.' -> 'ft.'
    
    return @{
     'artist'=trim $artist
     'title'=trim $title
    }
}

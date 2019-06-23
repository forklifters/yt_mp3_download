function SaveAudioWithMetaData ($prefix, $metaData)
{
    function trim ($str) 
    {
        return $str.Trim() -replace '[\/:*?"<>|]', '_' # removes all illegal characters from the filename to prevent errors
    }


    $destFilename = $(trim $metaData['artist']) + " - " + $(trim $metaData['title']) + ".mp3"

    if (! [string]::IsNullOrWhiteSpace($prefix))
    {
        $destFilename = $(trim $prefix) + $destFilename
    }


    $destPath = "./output/" + $destFilename

    Remove-Item $destPath -ErrorAction Ignore

    ./bin/ffmpeg.exe -i "./output/__tmp.mp3" -c copy -metadata artist="$($metaData['artist'])" -metadata title="$($metaData['title'])" $destPath

    Remove-Item "./output/__tmp.mp3" -ErrorAction Ignore
    Write-Host "`nSaved file as  « $destFilename »`n"
}
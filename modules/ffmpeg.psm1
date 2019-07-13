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

    GetExeOutput $(& ./bin/ffmpeg.exe -i "./output/__tmp.mp3" -loglevel error -c copy -metadata artist="$($metaData['artist'])" -metadata title="$($metaData['title'])" $destPath 2>&1)

    Remove-Item "./output/__tmp.mp3" -ErrorAction Ignore

    return $destFilename
}
#Requires -Version 5.1

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12


# Download the latest version of ffmpeg and extract to executables from the zip file
Write-Host "Fetching latest version of ffmpeg ..."
Invoke-WebRequest https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-latest-win64-static.zip -OutFile ffmpeg.zip

$zip = [IO.Compression.ZipFile]::OpenRead("ffmpeg.zip")
$zip.Entries | where {$_.Name -like '*.exe'} | foreach {[System.IO.Compression.ZipFileExtensions]::ExtractToFile($_, "./" + $_.Name, $true)}
$zip.Dispose()

Remove-Item ffmpeg.zip -ErrorAction Ignore


# Download the latest executable of youtube-dl
Write-Host "Fetching latest version of youtube-dl ..."
Invoke-WebRequest https://yt-dl.org/latest/youtube-dl.exe -OutFile youtube-dl.exe
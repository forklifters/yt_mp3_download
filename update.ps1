#Requires -Version 5.1

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12


if (![System.IO.Directory]::Exists("./bin"))
{
    New-Item -ItemType Directory -Force -Path "./bin"
}


# Download the latest version of ffmpeg and extract to executables from the zip file
Write-Host "Fetching latest version of ffmpeg ..."
Invoke-WebRequest https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-latest-win64-static.zip -OutFile bin/ffmpeg.zip

Add-Type -Assembly System.IO.Compression.FileSystem
$zip = [IO.Compression.ZipFile]::OpenRead("bin/ffmpeg.zip")
$zip.Entries | where {$_.Name -like '*.exe'} | foreach {[System.IO.Compression.ZipFileExtensions]::ExtractToFile($_, "bin/" + $_.Name, $true)}
$zip.Dispose()

Remove-Item ./bin/ffmpeg.zip -ErrorAction Ignore


# Download the latest executable of youtube-dl
Write-Host "Fetching latest version of youtube-dl ..."
Invoke-WebRequest https://yt-dl.org/latest/youtube-dl.exe -OutFile bin/youtube-dl.exe
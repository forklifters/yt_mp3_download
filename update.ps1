#Requires -Version 5.1

Set-StrictMode -Version Latest
Remove-Variable * -ErrorAction SilentlyContinue; Remove-Module *; $error.Clear(); Clear-Host

Import-Module ./modules/inputOutput.psm1

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12


#
#
# Download the latest version of ffmpeg and extract to executables from the zip file
#

if (![System.IO.Directory]::Exists("./bin"))
{
    New-Item -ItemType Directory -Force -Path "./bin"
}


#
#
#
# Download the latest version of ffmpeg and extract to executables from the zip file
#

clearConsole
ShowText "Downloading latest version of ffmpeg ..." -fc DarkCyan
Invoke-WebRequest https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-latest-win64-static.zip -OutFile bin/ffmpeg.zip

clearConsole
ShowText "Unpacking ffmpeg ..." -fc DarkCyan
Add-Type -Assembly System.IO.Compression.FileSystem
$zip = [IO.Compression.ZipFile]::OpenRead("bin/ffmpeg.zip")
$zip.Entries | where {$_.Name -like '*.exe'} | foreach {[System.IO.Compression.ZipFileExtensions]::ExtractToFile($_, "bin/" + $_.Name, $true)}
$zip.Dispose()

Remove-Item ./bin/ffmpeg.zip -ErrorAction Ignore


#
#
#
# Download the latest executable of youtube-dl
#

clearConsole
ShowText "Fetching latest version of youtube-dl ..." -fc DarkCyan
Invoke-WebRequest https://yt-dl.org/latest/youtube-dl.exe -OutFile bin/youtube-dl.exe
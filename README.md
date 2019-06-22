# YouTube mp3 Downloader

[![PowerShell 5.1](https://img.shields.io/badge/PowerShell-5.1-ffaa00.svg)](https://en.wikipedia.org/wiki/PowerShell)
[![made for Windows](https://img.shields.io/badge/made_for-Windows-blue.svg)](https://en.wikipedia.org/wiki/PowerShell)
[![Build Status](https://travis-ci.org/Kiuryy/yt_mp3_download.svg?branch=master)](https://travis-ci.org/Kiuryy/yt_mp3_download)


This is a PowerShell script, which allows you to download music videos from YouTube and other video platforms. It's using `youtube-dl` to download the videos and `ffmpeg` to convert the video into a mp3. 

You can also have a look at the [supported websites](https://ytdl-org.github.io/youtube-dl/supportedsites.html) you can download music from.

## Usage

Run `update.ps1` the first time, to download all needed executables (`youtube-dl` and `ffmpeg`). 
This will download the latest versions of these packages and puts them into the working directory.
You can run this file at times to get the latest packages or in case, something is not working properly.

Run `download.ps1` to download a music video from YouTube. You will be asked to enter the URL of the video. 
The script will try to automatically extract the artist and the title of the track. 
If you aren't satisfied with the result of this auto-detection, you can manually change the artist and track title.

The video will then be automatically converted into a mp3 file in the highest possible quality and put in a folder `output`.

## Output

- The artist and the track title will be determined by splitting at the first hyphen surrounded by spaces `Artist - Title Of The Song`.
- To be more consistent along with other music videos, a section `feat. Artist`, `ft. Artist` or `(feat. Artist)` will be moved from the track title to the artist and converted to `ft. Artist` without surrounding parantheses.
- Some sections of the video title will be omitted. For instance `[HD]`, `(Official video)` or `(Music video)` will be removed.

Here are some examples showing the video title, the extracted meta tags and the name of the output file:

```
Video title           Depeche Mode - It's No Good [HQ]
Artist                Depeche Mode
Title                 It's No Good
Output filename       Depeche Mode - It's No Good.mp3
```

```
Video title           Pendulum - Self vs Self (feat. In Flames)
Artist                Pendulum ft. In Flames
Title                 Self vs Self
Output filename       Pendulum ft. In Flames - Self vs Self.mp3
```

```
Video title           Phantogram - You Don’t Get Me High Anymore (Lyric Video)
Artist                Phantogram
Title                 You Don’t Get Me High Anymore
Output filename       Phantogram - You Don’t Get Me High Anymore.mp3
```




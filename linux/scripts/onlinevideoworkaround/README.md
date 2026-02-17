# Overview
This script is a method to get online videos working while playing voices of the void on linux, by essentially downloading the stream externally from votv and cutting it up into small snippets to feed back to votv using the tv folder and abuse of the sequence looping type. It's fairly janky and overall just a inelegant solution but it does the job.

The script is made and tested to work with the VOTV community broadcaster, along with being able to play Youtube Videos and Youtube Playlists, it should also work for other online video links but it's not been tested and may need some fiddling with the script's args on a case by case basis.

# Quickstart
First make sure you have ffmpeg and yt-dlp installed from your local package manager.

### Ubuntu/Debian
```sudo apt install ffmpeg```
```sudo apt install yt-dlp```
### Arch
```sudo pacman -S ffmpeg```
```sudo pacman -S yt-dlp```
### Fedora
```dnf install ffmpeg-free```
```dnf install yt-dlp```

With the two required packages installed, now download the `onlinevideoworkaround.sh` file from this repo, you can do so by clicking on the script and finding the "download raw file" button that looks like a arrow pointing into a open box. Download it somewhere you'll remember or can easily find, such as a folder in your home directory or desktop.

Then open a terminal in it's install location and run:
```chomod u+x onlinevideoworkaround.sh```
You should now be able to run the script like so:
```./onlinevideoworkaround.sh```

Once the script is running it should instruct you the rest of the way, asking for the location of your assets/tv, the link you want to stream from, and how to properly set it up in-game!

If you experince any issues please contact @slepdepriv on the EernityDev Games discord server.

# Advanced Usage

The script has support for a large variety of arguments that can be given to the script based on what you want to do, including being able to skip must of the script's menus by just providing the assets/tv path and the link path at the start, along with alot of tweaking of exactly how the script works.

### Basic Args

### -p path/to/assets
Directly points to the assets/tv you want the script to use, example usage:

```./onlinevideoworkaround.sh -p /home/USER/.steam/steam/steamapps/compatdata/4294897876/pfx/drive_c/users/steamuser/AppData/Local/VotV/Assets/tv/```

### -o https://example.com/movie.mp4
Directly points to the online link the script will use, example usage:

```./onlinevideoworkaround.sh -o https://www.youtube.com/watch?v=9Pd3qYrrF-A```

### -l \##
How long each "snippet" of the streamed video will be in seconds, defaults to 30, example usage:

```./onlinevideoworkaround.sh -l 15```

An example of using all three together:

```./onlinevideoworkaround.sh -p /home/USER/.steam/steam/steamapps/compatdata/4294897876/pfx/drive_c/users/steamuser/AppData/Local/VotV/Assets/tv/ -o https://www.youtube.com/watch?v=9Pd3qYrrF-A -l 60```

### -h
Displays all the basic arg infomation, incase you need a refresher and don't want to come back here, example usage:

```./onlinevideoworkaround.sh -h```

### Advanced Args

### -s
Skips the 'Press any key to continue...' prompt, this means you need to be fast to select the stream, also may slightly mess up timing, example usage:

```./onlinevideoworkaround.sh -s```

### -f
Downloads the full video instead of chopping it up into snippets, great for youtube videos and youtube playlists but won't work for live streams, example usage:

```./onlinevideoworkaround.sh -f```

### -n
Experimental arg to treat normal online video links like a youtube link for cases where it's not live, not tested, example usage:

```./onlinevideoworkaround.sh -n```

### -c
Stops the script from creating the "cache" folder in your assets/tv, instead just downloading the two required videos each time the script runs on the fly, example usage:

```./onlinevideoworkaround.sh -c```

# Known Issues

## Looping clip while set to sequence
Voices of The Void sometimes lies to you about the looping status, sometimes it will say "sequence" but actually be set to "looping". It's annoying but simply click the button until it lands on sequence again to fix the issue.

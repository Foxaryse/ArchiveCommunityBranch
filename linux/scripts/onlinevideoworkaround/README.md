# Overview
This is a very crude script to work around the issue of online videos not working in Voices of The Void on linux, since no matter the system the people deserve brainrot.

It works by essentially taking over the TV folder (without harming anything you already have there) and downloading any streamed video in snippets to display on the tv by abusing the way the "sequence" looping function works.

It also supports youtube videos and even youtube playlists, as a bonus.

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
### Bazzite
```rpm-ostree install ffmpeg-free```
```rpm-ostree install yt-dlp```


With the two required packages installed, now download the `onlinevideoworkaround.sh` file from this repo, and install it somewhere you'll remember.

Then open a terminal in it's install location and run:
```chomod u+x onlinevideoworkaround.sh```
You should now be able to run the script like so:
```./onlinevideoworkaround.sh```

The script itself will guide you on the rest of the process!

# Full Usage

Instead of going through each step of the process each time you run the script, you can tell it all the infomation just through args!

### Basic Args

### -p path/to/assets
Directly points to the assets/tv you want the script to use, example usage:

```./onlinevideoworkaround.sh -p /home/USER/.steam/steam/steamapps/compatdata/4294897876/pfx/drive_c/users/steamuser/AppData/Local/VotV/Assets/tv/```

### -o https://example.com/movie.mp4
Directly points to the online link the script will use, example usage:

```./onlinevideoworkaround.sh -o https://www.youtube.com/watch?v=9Pd3qYrrF-A```

### -l \##
How long each "snippet" of the streamed video will be in seconds, defaults to 30 but can be anything, example usage:

```./onlinevideoworkaround.sh -l 15```

Using all three of them together:

```./onlinevideoworkaround.sh -p /home/USER/.steam/steam/steamapps/compatdata/4294897876/pfx/drive_c/users/steamuser/AppData/Local/VotV/Assets/tv/ -o https://www.youtube.com/watch?v=9Pd3qYrrF-A -l 60```

### -s
Skips the 'Press any key to continue...' prompt, this means you need to be fast to select the stream, also may slightly mess up timing, example usage:

```./onlinevideoworkaround.sh -s```

### -f
Downloads the full video instead of chopping it up into snippets, better used with youtube videos then actual streams, example usage:

```./onlinevideoworkaround.sh -f```

### -n
Experimental arg to treat normal online video links like a youtube link for cases, not tested, example usage:

```./onlinevideoworkaround.sh -n```

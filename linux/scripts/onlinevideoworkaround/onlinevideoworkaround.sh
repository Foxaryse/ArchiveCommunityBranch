# Yummy vars
inputfolder=""
online=""
length=30
skipcheck=false
fullvideo=false
notlive=false

while getopts "p:o:l:sfnh" opt; do
    case $opt in
        p) inputfolder="$OPTARG" ;;
        o) online="$OPTARG" ;;
        l) length="$OPTARG" ;;
        s) skipcheck=true ;;
        f) fullvideo=true ;;
        n) notlive=true ;;
        h)
            echo "Usage: $0 -p <path/to/assets/tv> -o <https:example.com/video.mp4> -l ## -f -s -n"
            echo "  -p, the path to the assets/tv folder"
            echo "  -o, the online link you want to stream from"
            echo "  -l, how long the snippets the script cuts videos into are"
            echo "  -s, skips the 'press any key to continue' screen"
            echo "  -f, downloads the video fully instead of in snippets"
            echo "  -n, use timed snippets instead of treating the video as live"
            exit 0
            ;;
        *)
            exit 1
            ;;
    esac
done

# Make sure we have ffmpeg ofcourse
if ! command -v ffmpeg >/dev/null 2>&1; then
    echo "Error: this script requires ffmpeg and it can't find it, do you have it installed?"
    exit 1
fi
# And yt-dlp!
if ! command -v yt-dlp >/dev/null 2>&1; then
    echo "Error: this script requires yt-dlp and it can't find it, do you have it installed?"
    exit 1
fi


echo "Script started!"

if [ -z "$length" ]; then
  length=30
fi

if ! [[ "$length" =~ ^[0-9]+$ ]]; then
    echo "Error: snippet length must be a number"
    exit 1
fi

tv=""

# Make sure the path it setup correctly and all that.
check_path() {
    local path="$1"

    local tvpath="${path%/}"
    local tvfolder="tv"
    local assetsfolder="Assets"

    if [ "$(basename "$tvpath")" = "$tvfolder" ]; then
      echo "TV Folder properly set, everything looks good..."
      return 0
    else
      if [ "$(basename "$tvpath")" = "$assetsfolder" ]; then
        addedpath="${tvpath}/tv"
        properpath="${addedpath%/}"
        if [ "$(basename "$properpath")" = "$tvfolder" ]; then
          echo "You uh, entered just the assets folder location"
          echo "... close enough I suppose"
          echo "Found and set the TV Folder, despite a minor hiccup"
          return 2
        else
          echo "Couldn't find tv folder, did you provide the right folder path?"
        fi
      else
      echo "Couldn't find tv folder, did you provide the right folder path?"
      fi
    fi

    return 1
}

# Make sure we have a path setup
if [ -z "$inputfolder" ]; then
  echo ""
  echo "----------------------------------------------------------------------------"
  echo "Please input the location of your assets/tv"
  echo "An example for the location for proton would be:"
  echo "/home/USER/.steam/steam/steamapps/compatdata/4294897876/pfx/drive_c/users/steamuser/AppData/Local/VotV/Assets/tv/"
  echo "----------------------------------------------------------------------------"
  echo ""

  while true; do
    read -p "Enter the path to your tv folder: " inputfolder

    check_path "$inputfolder"
    result=$?

    case $result in
      0)
        tv="${inputfolder%/}"
        break
        ;;
      2)
        tvpath="${inputfolder%/}"
        addedpath="${tvpath}/tv"
        tv="${addedpath%/}"
        break
        ;;
      *)
        echo "Please try again..."
        ;;
    esac

  done
else
  # Have to do another check here for people who use the flag
  check_path "$inputfolder"
  result=$?

  case $result in
    0)
      tv="${inputfolder%/}"
      ;;
    2)
      tvpath="${inputfolder%/}"
      addedpath="${tvpath}/tv"
      tv="${addedpath%/}"
      ;;
    *)
      exit 1
      ;;
  esac
fi

echo "$inputfolder $online $length"

# Take over the tv folder now that we've found it!

mkdir -p ${tv}/holder
holder="${tv}/holder"

# Toss all the user's TV data into a closet, I'm sure it will be fine
echo "Moving all data in /tv to holder folder..."
find "$tv" -mindepth 1 -maxdepth 1 ! -name holder -exec mv -t "$holder" -- {} +
echo "Moved data!"

mkdir -p ${tv}/working
working="${tv}/working"

# Add ourselves to a new online.txt we make
echo "Online Video Stream" > "$tv"/online.txt
echo "file://${working}/video.mp4" >> "$tv"/online.txt
echo "Created new online.txt"

# Add temp holder video.mp4 to display
ffmpeg -loglevel error -nostats -i $(yt-dlp -f 18 --quiet --no-warnings --get-url "https://youtu.be/Oac2pWMwCcA") \
      -c copy \
      "$working"/temp.mp4

mv "$working"/temp.mp4 "$working"/video.mp4

if ! $skipcheck; then
  # Tell the user to actually
  echo ""
  echo "----------------------------------------------------------------------------"
  echo "The script has successfully taken TV control!"
  echo "Please go in-game and refresh the video list, you should see 'Online Video Stream' as the only option"
  echo "Make sure the Looping is set to 'sequence' then select and play it"
  echo "If everything goes correctly you should see a screen that says 'Script Online!'"
  echo "Once you have it playing, come back here and press any key to continue."
  echo "----------------------------------------------------------------------------"
  echo ""

  echo -n "Waiting for key press..."
  IFS= read -r -n 1 -s _
  echo
else
  echo "The script has successfully taken TV control!"
fi

check_url() {
  local link="$1"

  if [[ $link =~ ^https?://[a-zA-Z0-9.-]+(:[0-9]+)?(/.*)?$  ]]; then
    if [[ "$link" =~ (youtube\.com|youtu\.be) ]]; then
      type=$(yt-dlp --dump-single-json --skip-download --quiet --no-warnings "$online" \
      | jq -r '._type')

      if [[ "$type" == "playlist" ]]; then
        echo "Youtube playlist link detected and set!"
        return 3
      else
        echo "Youtube link detected and set!"
        return 2
      fi
    else
      echo "Link detected and set!"
      return 1
    fi
  fi

  return 0
}

mediamode=0

if [ -z "$online" ]; then
  echo ""
  echo "----------------------------------------------------------------------------"
  echo "Now, please input the link you want to stream from"
  echo "An example would be the community broadcaster:"
  echo "https://tv.votvbroadcast.com/votv.mp4"
  echo "Or a youtube link (including playlists) such as:"
  echo "https://www.youtube.com/watch?v=p8WU7zWqsWA"
  echo "----------------------------------------------------------------------------"
  echo ""

  while true; do
    read -p "Please enter the desired link: " online

    check_url "$online"
    result=$?

    case $result in
      0)
        echo "This doesn't seem like a proper link, please try again."
        ;;
      1)
        mediamode=1
        break
        ;;
      2)
        mediamode=2
        break
        ;;
      2)
        mediamode=3
        break
        ;;
    esac

  done

else
  echo "Checking url..."
  check_url "$online"
    result=$?

    case $result in
      0)
        echo "This doesn't seem like a proper link, please try again."
        ;;
      1)
        mediamode=1
        ;;
      2)
        mediamode=2
        ;;
      3)
        mediamode=3
        ;;
    esac
fi


is_valid_video() {
    yt-dlp --quiet --no-warnings --simulate "$1" >/dev/null 2>&1
}

echo "Processing playlist..."

valid_playlist=()
if (($mediamode == 3)); then
  mapfile -t playlist < <(
      yt-dlp --quiet --no-warnings --flat-playlist --print "%(url)s" "$online"
  )

  for video in "${playlist[@]}"; do
    if is_valid_video "$video"; then
        valid_playlist+=("$video")
    fi
  done
fi

echo "Processing complete"

# Remember to make this download from a online source later
cp /home/slepdepriv/Videos/loading.mp4 ${working}
mv "$working"/loading.mp4 "$working"/video.mp4

ffmpeg -loglevel error -nostats -i $(yt-dlp -f 18 --quiet --no-warnings --get-url "https://www.youtube.com/watch?v=JUSVCW1nYO8") \
      -c copy \
      "$working"/temp.mp4

mv "$working"/temp.mp4 "$working"/video.mp4

echo ""
echo "----------------------------------------------------------------------------"
echo "Everything is now up and running, your stream should begin shortly!"
echo "Press [q] to stop the script and set everything back to normal"
echo "Press [p] to pause the script"
echo "(You may need to press the keys multiple times or wait abit for them to work)"
echo "----------------------------------------------------------------------------"
echo ""

lengthstart=0
lengthend=$length
duration=-1
active=true
running=true
queuedvideo=0

quit_script() {
  rm "${tv}/online.txt"
  rm -r "${working}"
  find "$holder" -mindepth 1 -maxdepth 1 -exec mv -t "$tv" -- {} +
  rmdir "$holder"
}

default_stream() {

  if $fullvideo; then
    ffmpeg -loglevel error -nostats -y -i "$online" \
        -c copy \
        "$working"/video.mp4
  else
    if $notlive; then
        ffmpeg -loglevel error -nostats -y -i "$online" \
            -ss ${lengthstart} \
            -to ${lengthend} \
            -c copy \
            "$working"/temp.mp4

        mv "$working"/temp.mp4 "$working"/video.mp4

        lengthstart=$((${lengthstart} + ${length}))
        lengthend=$((${lengthend} + ${length}))

        sleep $((${length}*80/100))
      else
        ffmpeg -loglevel error -nostats -y -i "$online" \
            -t ${length} \
            -c copy \
            "$working"/temp.mp4

        mv "$working"/temp.mp4 "$working"/video.mp4
    fi
  fi
}

youtube_stream() {
  if (($duration == -1)); then
    duration=$(yt-dlp --quiet --no-warnings --print "%(duration)s" "$online")
    if [ -z "$duration" ]; then
      echo "Something seems to have gone wrong, perhaps a invalid video?"
      quit_script
      echo "Script stopped."
      exit 1
    fi
  fi

  if $fullvideo; then
    lengthstart=0
    lengthend=$duration
  fi

  ffmpeg -loglevel error -nostats -i $(yt-dlp -f 18 --quiet --no-warnings --get-url "$online") \
      -ss ${lengthstart} \
      -to ${lengthend} \
      -c copy \
      "$working"/temp.mp4

  mv "$working"/temp.mp4 "$working"/video.mp4

  if (($lengthend >= $duration)); then
    local waittime=$(($duration-$lengthstart))
    sleep ${waittime}
    echo "No more video found, quiting..."
    quit_script
    echo "Script stopped, that's all folks!"
    active=false
  else
    lengthstart=$((${lengthstart} + ${length}))
    lengthend=$((${lengthend} + ${length}))

    sleep $((${length}*80/100))
  fi
}

playlist_stream() {
  local link="${valid_playlist[${queuedvideo}]}"

  if (($duration == -1)); then
    duration=$(yt-dlp --quiet --simulate --print "%(duration)s" "$link")
    echo "Duration set to $duration"
    if [ -z "$duration" ]; then
      echo "Something seems to have gone wrong, perhaps a invalid video in the playlist?"
      quit_script
      echo "Script stopped."
      exit 1
    fi
  fi

  if $fullvideo; then
    lengthstart=0
    lengthend=$duration
  fi

  ffmpeg -loglevel error -nostats -i $(yt-dlp -f 18 --quiet --no-warnings --get-url "$link") \
      -ss ${lengthstart} \
      -to ${lengthend} \
      -c copy \
      "$working"/temp.mp4

  mv "$working"/temp.mp4 "$working"/video.mp4

  if (($lengthend >= $duration)); then
    local waittime=$(($duration-$lengthstart))
    sleep ${waittime}

    if ((${queuedvideo} <= ${#valid_playlist[@]})); then
      queuedvideo=$((${queuedvideo}+1))
      lengthstart=0
      lengthend=$length
      duration=-1
    else
      echo "Playlist empty, quiting..."
      quit_script
      echo "Script stopped, that's all folks!"
      active=false
    fi
  else
    lengthstart=$((${lengthstart} + ${length}))
    lengthend=$((${lengthend} + ${length}))

    if $fullvideo; then
      sleep $((${duration}*80/100))
    else
      sleep $((${length}*80/100))
    fi
  fi
}

while $active; do
  read -t 0.1 -n 1 key
  case $key in
    "q")
      echo "Quiting..."
      quit_script
      echo "Script stopped!"
      active=false
      break
      ;;
    "p")
      running=false
      echo "Paused..."
      echo "Press [p] again to resume!"
      ;;
  esac

  if $running; then
    case $mediamode in
      1)
        default_stream
        ;;
      2)
        youtube_stream
        ;;
      3)
        playlist_stream
        ;;
    esac
  fi

done

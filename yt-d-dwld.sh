#!/bin/sh

# CLI-YouTube - Find and watch or download YouTube videos
# Usage: ./cli-yt.sh [search query]

# Set up variables
SEARCH_TERM="$(echo "$*" | sed 's/ /+/g')"
BASE_URL="https://www.youtube.com"
RESULTS_URL="$BASE_URL/results?search_query=$SEARCH_TERM"
VIDEO_ID="$(curl -s $RESULTS_URL | grep -o 'watch?v=[^"]*' | head -n 1 | sed 's/watch?v=//')"
VIDEO_URL="$BASE_URL/watch?v=$VIDEO_ID"

# Play video with mpv
mpv $VIDEO_URL

# Download video with youtube-dl
read -p "Do you want to download the video? (y/n): " DOWNLOAD
if [ $DOWNLOAD = "y" ]
then
  youtube-dl $VIDEO_URL
fi


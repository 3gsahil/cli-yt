#!/bin/bash

# Display a GUI dialog to prompt the user to enter a YouTube video URL
url=$(zenity --entry --text "Enter the URL of the YouTube video you want to watch:")

# Extract the video ID from the URL
video_id=$(echo $url | sed 's/.*v=\([a-zA-Z0-9_-]*\).*/\1/')

# Display a GUI dialog to prompt the user to choose whether to play or download the video
choice=$(zenity --list --radiolist --text "Do you want to play or download the video?" --column "" --column "Option" TRUE "Play" FALSE "Download")

# Process the user's choice
case $choice in
  "Play")
    # Play the video using mpv
    mpv "https://www.youtube.com/watch?v=$video_id"
    ;;
  "Download")
    # Download the video using yt-dlp
    yt-dlp -o "%(title)s.%(ext)s" "https://www.youtube.com/watch?v=$video_id"
    ;;
  *)
    # The user clicked the "Cancel" button or closed the dialog window
    echo "Operation cancelled."
    ;;
esac


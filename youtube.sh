#!/bin/bash

# Prompt the user to enter a YouTube video URL
echo "Enter the URL of the YouTube video you want to watch:"
read url

# Extract the video ID from the URL
video_id=$(echo $url | sed 's/.*v=\([a-zA-Z0-9_-]*\).*/\1/')

# Prompt the user to choose whether to play or download the video
echo "Do you want to play or download the video?"
select choice in "Play" "Download"; do
  case $choice in
    Play)
      # Play the video using mpv
      mpv "https://www.youtube.com/watch?v=$video_id"
      break
      ;;
    Download)
      # Download the video using yt-dlp
      yt-dlp -o "%(title)s.%(ext)s" "https://www.youtube.com/watch?v=$video_id"
      break
      ;;
    *)
      echo "Invalid choice. Please choose again."
      ;;
  esac
done


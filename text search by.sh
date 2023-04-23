#!/bin/bash

# Parse command line options
while getopts "d" opt; do
  case $opt in
    d)
      download=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

# Ask for search terms if not provided
if [ $# -eq 0 ]; then
    echo -n "Enter search terms: "
    read search_terms
else
    search_terms=$@
fi

# Ask if user wants to stream or download video
echo "Search terms: $search_terms"
echo "Do you want to stream or download the video?"
select action in stream download; do
    case $action in
        stream )
            break
            ;;
        download )
            break
            ;;
        * )
            echo "Invalid option: $REPLY"
            ;;
    esac
done

# Search for video with ytfzf
video_url=$(ytfzf "$search_terms")

if $download; then
    # Download video with youtube-dl
    echo "Select video quality for download:"
    select quality in low medium high; do
        case $quality in
            low )
                youtube-dl -f 'bestvideo[height<=480]+bestaudio/best[height<=480]' -o "%(title)s.%(ext)s" "$video_url"
                break
                ;;
            medium )
                youtube-dl -f 'bestvideo[height<=720]+bestaudio/best[height<=720]' -o "%(title)s.%(ext)s" "$video_url"
                break
                ;;
            high )
                youtube-dl -f 'bestvideo[height<=1080]+bestaudio/best[height<=1080]' -o "%(title)s.%(ext)s" "$video_url"
                break
                ;;
            * )
                echo "Invalid option: $REPLY"
                ;;
        esac
    done
else
    # Stream video with mpv
    echo "Select video quality for streaming:"
    select quality in low medium high; do
        case $quality in
            low )
                mpv --ytdl-format='bestvideo[height<=480]+bestaudio/best[height<=480]' "$video_url"
                break
                ;;
            medium )
                mpv --ytdl-format='bestvideo[height<=720]+bestaudio/best[height<=720]' "$video_url"
                break
                ;;
            high )
                mpv --ytdl-format='bestvideo[height<=1080]+bestaudio/best[height<=1080]' "$video_url"
                break
                ;;
            * )
                echo "Invalid option: $REPLY"
                ;;
        esac
    done
fi


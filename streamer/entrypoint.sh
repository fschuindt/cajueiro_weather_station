#!/usr/bin/env bash

operation=$1
argument=$2

function start {
    ffmpeg \
        -f video4linux2 -framerate 25 -video_size 1280x720 -i /dev/video0 \
        -c:v libx264 -b:v 1600k -preset ultrafast \
        -x264opts keyint=50 -g 25 -pix_fmt yuv420p \
        -c:a aac -b:a 128k \
        -vf "drawtext=fontfile=/home/streamer/DejaVuSans-Bold.ttf: \
textfile=/home/streamer/sensor_data/drawfile.txt: \
reload=1: \
expansion=none: \
line_spacing=15: \
fontcolor=white@0.8: fontsize=16: x=10: y=10: box=1: boxcolor=black: boxborderw=6" \
        -f flv "rtmp:syrinx-stream.722.network:4935/live/cam1?streamkey=your-key-here"
}

case "$operation" in
    "--start")
        start $argument

        ;;
    *)
        echo "No operation provided."
        exit 1
esac

# Cajueiro Weather Station

A set of programs to run the [Cajueiro Weather Station](https://fschuindt.github.io/blog/weather), which is a PoC experiment to monitor the sky temperature based on infrared radiation with an infrared sensor and its visual conditions with a budget all-sky camera to evaluate the possibility of later building an infrared-radiation-based cloud detection system to be used at amateur astronomy observatories.

The weather station is live [here](https://fschuindt.github.io/blog/weather).

Check this [blog post](https://fschuindt.github.io/blog//2022/04/30/infrared-sky-temperature-monitoring-mlx90614-sensor-and-all-sky-camera-ar0130-sensor-for-a-cloud-detection-poc.html) for more information about the station.

## Broadcaster

Uses my ["NGINX RTMP/RTMPS to HLS and MPEG-Dash media stream broadcaster"](https://github.com/fschuindt/nginx_rtmp_hls_dash) repository to be able to intake the video streaming data at a given AWS EC2 server and broadcast it to all the web-based clients visiting my webpage.

There's also a [post on my blog](https://fschuindt.github.io/blog/2020/12/31/streaming-video-and-audio-of-an-usb-webcam-to-multiple-users-of-a-website-with-ssl-basic-authentication-and-invideo-timestamps-ffmpeg-rtmp-nginx-hls-mpeg-dash.html) about this "RTMP -> Dash" repository.

## Streamer

A small Shell script that instructs [FFmpeg](https://ffmpeg.org/) on how to gather the camera video feed and stream it to the broadcaster.

## Cajueiro Weather Station (CWS) Ruby gem

A Ruby program that gathers serial data from the MLX90614 infrared sensor at the Arduino board, stores it as a `.csv` and plots the graph for the visual analysis resulting in a `.png` file. This file is periodically uploaded to a AWS S3 bucket and displayed at the station webpage.

## Note on encryption and security

The "streaming" (Camera->Broadcaster) is done in plain text. However the "watching" (Broadcaster->Client) can be done using TLS provided by the Cloudflare reverse-proxy at: [https://syrinx-watch.722.network/dash/cam1.mpd](https://syrinx-watch.722.network/dash/cam1.mpd) (use a Dash client to watch this stream).

The "streaming" is protected by a secret-key parameter, the "watching" is open to the world.

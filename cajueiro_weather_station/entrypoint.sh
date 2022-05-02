#!/usr/bin/env bash

operation=$1

case "$operation" in
    "--start")
        cajueiro_weather_station /dev/ttyACM0 /home/cajueiro/sensor_data/temperature_data.csv /home/cajueiro/sensor_data/drawfile.txt

        ;;
    *)
        echo "No operation provided."
        exit 1
esac

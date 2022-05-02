#!/usr/bin/env bash

operation=$1
argument=$2

case "$operation" in
    "--start")
        nginx && tail -f /home/broadcaster/log/access.log

        ;;
    *)
        echo "No operation provided."
        exit 1
esac

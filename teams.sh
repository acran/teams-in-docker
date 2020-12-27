#!/bin/bash

# ensure xdg socket is setup correctly
rm -f ~/x11docker/teams/.xdg.sock
mkfifo ~/x11docker/teams/.xdg.sock

# read loop for opening urls with xdg
while true; do read url < ~/x11docker/teams/.xdg.sock; xdg-open "$url"; done &

x11docker --pulseaudio --webcam --hostdisplay --clipboard --gpu --env LANG --home --name teams -- --privileged teams /usr/share/teams/teams "$@"

# cleanup xdg socket
kill %1 # kill xdg-open loop
rm -f ~/x11docker/teams/.xdg.sock

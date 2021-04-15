#!/bin/bash

# check if teams container is running and use existing container if so
if docker exec teams true > /dev/null 2>&1; then
	docker exec teams teams "$@"
	exit $?
fi

# ensure xdg socket is setup correctly
rm -f ~/x11docker/teams/.xdg.sock
mkfifo ~/x11docker/teams/.xdg.sock

# read loop for opening urls with xdg
while true; do read url < ~/x11docker/teams/.xdg.sock; xdg-open "$url"; done &

x11docker --pulseaudio --webcam --hostdisplay --clipboard --gpu --env LANG --home --name teams -- --cap-add=CAP_SYS_ADMIN --cap-add=CAP_SYS_CHROOT teams /usr/share/teams/teams "$@"

# cleanup xdg socket
kill %1 # kill xdg-open loop
rm -f ~/x11docker/teams/.xdg.sock

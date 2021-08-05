#!/bin/bash

CONTAINER_HOME=~/.local/share/x11docker/teams

# check if teams container is running and use existing container if so
if docker exec teams true > /dev/null 2>&1; then
	docker exec teams teams "$@"
	exit $?
fi

# ensure xdg socket is setup correctly
rm -f "$CONTAINER_HOME/.xdg.sock"
mkdir -p "$CONTAINER_HOME"
if ! mkfifo "$CONTAINER_HOME/.xdg.sock"; then
	echo "Failed to create $CONTAINER_HOME/.xdg.sock for xdg-open integration" >&2
	exit 1
fi

# read loop for opening urls with xdg
while [ -p "$CONTAINER_HOME/.xdg.sock" ]; do read url < "$CONTAINER_HOME/.xdg.sock"; xdg-open "$url"; done &

x11docker --pulseaudio --webcam --hostdisplay --clipboard --gpu --env LANG --home --name teams -- --cap-add=CAP_SYS_ADMIN --cap-add=CAP_SYS_CHROOT teams /usr/share/teams/teams "$@"

# cleanup xdg socket
kill %1 # kill xdg-open loop
rm -f "$CONTAINER_HOME/.xdg.sock"

#!/bin/bash

x11docker --pulseaudio --webcam --hostdisplay --clipboard --gpu --env LANG --home --name teams -- --privileged teams /usr/share/teams/teams "$@"

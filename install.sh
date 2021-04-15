#!/bin/bash

set -e

PROJECT_DIR="$(dirname "$0")"

echo "building teams image..."
docker build -t teams "$PROJECT_DIR"

echo "copy teams to ~/bin/"
cp "$PROJECT_DIR/teams.sh" ~/bin/teams


echo "copy teams.desktop and teams.png from image..."
mkdir -p ~/.local/share/applications/ ~/.local/share/icons/
docker create --name teams teams
docker cp teams:/usr/share/applications/teams.desktop ~/.local/share/applications/teams.desktop
docker cp teams:/usr/share/pixmaps/teams.png ~/.local/share/icons/teams.png
docker container rm teams

# remove absolute paths in teams.desktop to use PATH instead
sed 's#/usr/bin/teams#teams#' -i ~/.local/share/applications/teams.desktop
update-desktop-database ~/.local/share/applications/


echo "checking for x11docker"
if ! which x11docker &> /dev/null; then
	echo "x11docker not found! Download x11docker and place it in your PATH:" >&2
	echo "https://github.com/mviereck/x11docker" >&2
fi

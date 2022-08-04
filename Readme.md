# Teams in Docker

This is a small wrapper to run the official Microsoft Teams for Linux client in
a `docker` container on your Linux desktop using
[`x11docker`](https://github.com/mviereck/x11docker).

## Features

This wrapper should provide a seemless desktop integration and work (mostly) as
good as running Teams natively on the Linux desktop.
The following functionality was verified to work:

* accessing audio and video (using `pulseaudio`)
* screensharing
* clipboard access / copy & paste of (rich-)text and images
* opening meetings/deeplinks in Teams (using `xdg-open`)
* opening URLs from Teams in the host browser/application (using `xdg-open`)
* systray integration
* start menu integration
* downloading files (see [Limitations](#limitations) though)

## Install

1. download [`x11docker`](https://github.com/mviereck/x11docker) and place it
   in your `PATH`.
2. `git clone https://github.com/acran/teams-in-docker.git`
3. run the [`./install.sh`](./install.sh) script or manually execute its
  contents as you see fit. It will:
    * build the `docker` image for Teams
    * copy the start script [`teams.sh`](./teams.sh) to your `~/bin/`
    * install `teams.desktop` and the icon locally for desktop integration

### Updating

You should regularly rebuild the `docker` image to get the latest version.
You can rebuild it with:

~~~sh
docker build --pull -t teams .
~~~

## Limitations

Since the container has its own filesystem it can not access all files on your
disk. But for sharing/downloading files you can use the container's `HOME`
directory which is located at `~/x11docker/teams/` on the host.

Additionally this client will lack many features available in the Windows and
macOS clients since Microsoft does not update and support their Linux version
of Teams with comparable commitment...

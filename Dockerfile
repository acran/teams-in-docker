FROM ubuntu

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
	&& apt-get update \
	&& apt-get upgrade -y

RUN apt-get install -y \
		curl \
		fonts-noto-color-emoji \
		libsecret-1-0 \
		pulseaudio \
	&& curl -L "https://teams.microsoft.com/downloads/desktopurl?env=production&plat=linux&arch=x64&download=true&linuxArchiveType=deb" > /tmp/teams.deb \
	&& apt-get install -y /tmp/teams.deb \
	&& rm /tmp/teams.deb

COPY xdg-open /usr/local/bin/

CMD /usr/share/teams/teams

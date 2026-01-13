FROM mirror.gcr.io/library/debian:13-slim


RUN apt-get update -y && apt-get install -y --no-install-recommends \
curl \
ca-certificates \
xterm \
xvfb \
x11vnc \
xfce4 \
xfce4-goodies \
dbus-x11 \
novnc \
websockify \
x11-apps \
libegl1 \
git \
ffmpeg \
mkvtoolnix \
pipx \
libxcb-cursor0 \
libxcb-cursor-dev \
libxcb-icccm4 \
libxcb-image0 \
libxcb-keysyms1 \
libxcb-randr0 \
libxcb-render-util0 \
libxcb-render0 \
libxcb-shape0 \
libxcb-shm0 \
libxcb-sync1 \
libxcb-xfixes0 \
libxcb-xinerama0 \
libxcb-xinput0 \
libxcb-xkb1 \
libxcb1 \
libx11-xcb1 \
libfontconfig1 \
libfreetype6 \
libxi6 \
libxkbcommon0 \
wget \
unzip \
tar \
aria2 \
libgl1 \
libglib2.0-0 \
libsm6 \
libxext6 \
libxrender1 \
libgomp1 \
libxkbcommon-x11-0 \
libdbus-1-3 \
mediainfo
    
RUN pipx install uv

WORKDIR /app

COPY entrypoint.sh /app/entrypoint.sh

EXPOSE 5900

RUN cp /usr/share/novnc/vnc_lite.html /usr/share/novnc/index.html
RUN sed -i 's/rfb.scaleViewport = readQueryVariable.*$/rfb.scaleViewport = true;/' /usr/share/novnc/index.html
EXPOSE 3001

ENTRYPOINT ["/app/entrypoint.sh"]

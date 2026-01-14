FROM mirror.gcr.io/library/debian:13-slim

RUN sed -i '5s/$/ contrib non-free non-free-firmware/;12s/$/ contrib non-free non-free-firmware/'  /etc/apt/sources.list.d/debian.sources

RUN apt-get update -y && apt-get install -y --no-install-recommends \
curl \
ca-certificates \
kitty \
xvfb \
x11vnc \
xfce4 \
xfce4-goodies \
dbus-x11 \
novnc \
websockify \
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
mediainfo \
vainfo \
libmfx-gen-dev \
intel-media-va-driver-non-free

RUN pipx install uv && pipx ensurepath

RUN wget https://www.bok.net/Bento4/binaries/Bento4-SDK-1-6-0-641.x86_64-unknown-linux.zip && \
    unzip -j Bento4-SDK-1-6-0-641.x86_64-unknown-linux.zip \
    'Bento4-SDK-1-6-0-641.x86_64-unknown-linux/bin/*' -d /root/.local/bin/ && \
    rm Bento4-SDK-1-6-0-641.x86_64-unknown-linux.zip && \
    chmod +x /root/.local/bin/*

RUN wget https://github.com/nilaoda/N_m3u8DL-RE/releases/download/v0.5.1-beta/N_m3u8DL-RE_v0.5.1-beta_linux-x64_20251029.tar.gz && \
    tar -xzf N_m3u8DL-RE_v0.5.1-beta_linux-x64_20251029.tar.gz -C /root/.local/bin/ && \
    rm N_m3u8DL-RE_v0.5.1-beta_linux-x64_20251029.tar.gz && \
    chmod +x /root/.local/bin/*

RUN wget https://github.com/shaka-project/shaka-packager/releases/download/v3.4.2/packager-linux-x64 && \
    mv packager-linux-x64 /root/.local/bin/shaka-packager && \
    chmod +x /root/.local/bin/*

WORKDIR /app

COPY entrypoint.sh /app/entrypoint.sh

EXPOSE 5900

RUN cp /usr/share/novnc/vnc_lite.html /usr/share/novnc/index.html
RUN sed -i 's/rfb.scaleViewport = readQueryVariable.*$/rfb.scaleViewport = true;/' /usr/share/novnc/index.html
EXPOSE 3001

ENTRYPOINT ["/app/entrypoint.sh"]

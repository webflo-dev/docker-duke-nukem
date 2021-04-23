FROM debian:stretch
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -y curl apt-transport-https x11vnc xvfb gnupg && \
    dpkg --add-architecture i386 && \
    curl https://dl.winehq.org/wine-builds/Release.key | apt-key add - && \
    echo "deb https://dl.winehq.org/wine-builds/debian/ stretch main" > /etc/apt/sources.list.d/wine.list && \
    apt-get update && \
    apt-get install -y --allow-unauthenticated --install-recommends winehq-devel && \
    curl -o /usr/bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && \
    chmod +x /usr/bin/winetricks
ENV DISPLAY :1

WORKDIR /eduke3d
RUN apt-get install -y wget p7zip && \
    wget https://dukeworld.com/eduke32/synthesis/latest/eduke32_win32_20210404-9321-7225643e3.7z && \
    7zr x eduke32_win32_*.7z && \
    wget https://github.com/zear/eduke32/raw/master/polymer/eduke32/duke3d.grp && \
    rm -f eduke32_win32_*.7z && \
    curl -sSfL lach.dev/eduke32.sh > /eduke32.sh

CMD ["bash", "/eduke32.sh"]
VOLUME /root/.wine
EXPOSE 5900/tcp
ENV WINEDLLOVERRIDES="mscoree,mshtml="
WORKDIR /


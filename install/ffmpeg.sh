#! /bin/bash

set -e

# Install FFMPEG
wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz

#RUN md5sum -c ffmpeg-release-amd64-static.tar.xz.md5
tar xvf ffmpeg-release-amd64-static.tar.xz
mv ffmpeg-*-amd64-static/ffmpeg /usr/local/bin
mv ffmpeg-*-amd64-static/ffprobe /usr/local/bin
rm -rf ffmpeg-release-amd64-static.tar.xz ffmpeg-*-amd64-static
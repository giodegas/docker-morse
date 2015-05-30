FROM quantumobject/docker-baseimage:latest

MAINTAINER Giovanni De Gasperis @giodegas

# System update and basic tools
RUN apt-get update && apt-get -y upgrade && apt-get -y install curl build-essential vim nano p7zip p7zip-plugins
ENV TERM vt100

# VirtualBox Guest Additions
ENV VBOX_VERSION 4.3.24
RUN mkdir -p /vboxguest && \
    cd /vboxguest && \
    \
    curl -L -o vboxguest.iso http://download.virtualbox.org/virtualbox/${VBOX_VERSION}/VBoxGuestAdditions_${VBOX_VERSION}.iso && \
    7z x vboxguest.iso -ir'!VBoxLinuxAdditions.run' && \
    \
    sh VBoxLinuxAdditions.run --noexec --target . && \
    mkdir -p amd64 && tar -C amd64 -xjf VBoxGuestAdditions-amd64.tar.bz2 && \
    \
    KERN_DIR=/usr/src/linux make -C amd64/src/vboxguest-${VBOX_VERSION}

ADD installer /installer
CMD /installer

# 3D Mesa libraries and xterm to run X apps, VNC server, Python3
RUN apt-get -y install libglu1-mesa-dev freeglut3-dev mesa-common-dev x11-apps mesa-utils apt-utils wget git libfreetype6 libxi-dev pkg-config cmake
RUN apt-get -y install python3-morse-simulator python3-dev

ENV LANG C.UTF-8

ENV PYTHON_VERSION 3.4.2
ENV CMAKE_LIBRARY_ARCHITECTURE x86_64-linux-gnu

# get Blender executable
RUN mkdir /opt/blender
WORKDIR /opt/blender

RUN wget -q http://mirror.cs.umn.edu/blender.org/release/Blender2.73/blender-2.73-linux-glibc211-x86_64.tar.bz2 -O /opt/blender/blender-2.73.tar.bz2 
RUN tar jxf blender-2.73.tar.bz2 
RUN rm blender-2.73.tar.bz2

# Install Morse Robotic simulator, stable release
WORKDIR /usr/src
RUN git clone https://github.com/morse-simulator/morse -b master

WORKDIR /usr/src/morse

RUN mkdir build
WORKDIR /usr/src/morse/build
ENV MORSE_BLENDER /opt/blender/blender-2.73-linux-glibc211-x86_64/blender

RUN cmake .. 
RUN make install 
RUN make clean
WORKDIR /
RUN rm -fr /usr/src/morse
RUN morse --noaudio check 
RUN apt-get -y remove build-essential pkg-config cmake
RUN apt-get -y autoremove


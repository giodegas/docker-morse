FROM quantumobject/docker-baseimage:latest

MAINTAINER Giovanni De Gasperis @giodegas

# System update and basic tools
RUN apt-get update && apt-get -y upgrade && apt-get -y install curl build-essential vim nano
ENV TERM vt100

# 3D Mesa libraries and xterm to run X apps, VNC server, Python3
RUN apt-get -y install libglu1-mesa-dev freeglut3-dev mesa-common-dev x11-apps mesa-utils apt-utils wget git libfreetype6 libxi-dev pkg-config cmake python3-blender

# TODO: ENV LD_LIBRARY_PATH 
# Python 3.4.2 setup - taken from http://github.com/docker-library/python/blob/master/3.4/Dockerfile

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

ENV PYTHON_VERSION 3.4.2

# get Blender executable
RUN mkdir /opt/blender
WORKDIR /opt/blender

RUN wget -q http://mirror.cs.umn.edu/blender.org/release/Blender2.73/blender-2.73-linux-glibc211-x86_64.tar.bz2 -O /opt/blender/blender-2.73.tar.bz2 & tar jxf blender-2.73.tar.bz2 & rm blender-2.73.tar.bz2

# Install Morse Robotic simulator, stable release
WORKDIR /usr/src
RUN git clone https://github.com/morse-simulator/morse -b master

WORKDIR /usr/src/morse

RUN mkdir build
WORKDIR /usr/src/morse/build
ENV MORSE_BLENDER /opt/blender/blender-2.73-linux-glibc211-x86_64/blender

RUN cmake .. & make install & make clean
WORKDIR /
RUN rm -fr /usr/src/morse
RUN morse --noaudio check 
RUN apt-get -y remove build-essential pkg-config cmake
RUN apt-get -y autoremove & rm -v /var/cache/alt/*

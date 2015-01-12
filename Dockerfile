FROM tutum/debian:wheezy

MAINTAINER Giovanni De Gasperis <giovanni@giodegas.it>

RUN apt-get update && apt-get -y install apt-utils wget git libfreetype6 libgl1-mesa-dev build-essential python3.2-dev pkg-config cmake 

# get Blender executable
RUN mkdir /opt/blender
RUN wget -q http://mirror.cs.umn.edu/blender.org/release/Blender2.73/blender-2.73-linux-glibc211-x86_64.tar.bz2 -O /opt/blender/blender-2.73.tar.bz2
WORKDIR /opt/blender
RUN tar jxf blender-2.73.tar.bz2

# Install Morse Robotic simulator, stable release
RUN git clone https://github.com/morse-simulator/morse -b 1.2_STABLE /usr/src/morse

WORKDIR /usr/src/morse

RUN mkdir build
WORKDIR /usr/src/morse/build
ENV MORSE_BLENDER /opt/blender/blender-2.73-linux-glibc211-x86_64/blender

RUN cmake ..
RUN make install
RUN morse check


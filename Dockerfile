FROM tutum/debian:wheezy

MAINTAINER Giovanni De Gasperis <giovanni@giodegas.it>

RUN apt-get update && apt-get -y install apt-utils wget git build-essential python3.2-dev pkg-config cmake 

# get Blender executable
RUN mkdir /opt/blender
wget http://mirror.cs.umn.edu/blender.org/release/Blender2.73/blender-2.73-linux-glibc211-x86_64.tar.bz2 /opt/blender

# Install Morse Robotic simulator, stable release
RUN git clone https://github.com/morse-simulator/morse -b 1.2_STABLE /usr/src/morse

WORKDIR /usr/src/morse

RUN mkdir build
WORKDIR /usr/src/morse/build

RUN cmake ..
RUN make install
RUN morse check


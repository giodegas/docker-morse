FROM tutum/debian:wheezy

MAINTAINER Giovanni De Gasperis <giovanni@giodegas.it>

RUN apt-get update && apt-get -y install git cmake

# Install Morse Robotic simulator, stable release
RUN git clone https://github.com/morse-simulator/morse -b 1.2_STABLE /usr/src/morse

WORKDIR /usr/src/opensim

RUN mkdir build && cd build
RUN cmake ..

RUN morse check


# docker-morse-vbox
[Morse](https://github.com/morse-simulator/morse) robotic simulator in a docker container

VirtualBox release - testing runtime case studies..

to use it in your [docker](http://docker.com) setup:

    $ docker pull giodegas/morse-vbox
    $ docker run -it -e DISPLAY=$DISPLAY giodegas/morse-vbox morse --noaudio check
    
you should get this output log:

    * Checking up your environment...
    * Running on Linux. Alright.
    * Found MORSE libraries in '/usr/local/lib/python3.4/site-packages/morse/blender'. Alright.
    * Trying to figure out a prefix from the script location...
    * Default scene found. The prefix seems ok. Using it.
    * Setting $MORSE_ROOT environment variable to default prefix [/usr/local/]
    * Checking version of /opt/blender/blender-2.73-linux-glibc211-x86_64/blender... Found v.2.73.0
    * Blender found from $MORSE_BLENDER. Using it (Blender v.2.73.0)
    * Checking version of Python within Blender /opt/blender/blender-2.73-linux-glibc211-x86_64/blender... Found v.3.4.2
    * Blender emitted errors during launch:
    AL lib: (EE) ALCplaybackOSS_open: Could not open /dev/dsp: No such file or directory
    * Blender and Morse are using Python 3.4.2. Alright.
    * Your environment is correctly setup to run MORSE.

then you can interact with morse:

    $ docker start <container>
    $ docker exec -it <container> /bin/bash
    # morse --noaudio create <your_scene>
    # morse --noaudio run <your_scene> -noaudio

if you have problem running under X, debug trying to make x11-apps to launch

    $ docker start <container>
    $ docker exec -it <container> /bin/bash
    # xeyes &
    
## Fastmode graphics

As described in the [morse installation documentation](http://www.openrobots.org/morse/doc/1.2/user/installation.html), using the 

    fastmode=True

in your scene contructors, morse will render you scene in wireframe mode, but some camera sensors will not be available.


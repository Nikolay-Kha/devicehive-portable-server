Portable version of devicehive server which can be run on armhf or x86_64 machine.
Doesn't require anything to install on target machine. Just run ./start.sh in _build dir and have fun!

#Dependencies:
sudo apt-get install libc6-dev-armhf-cross cpp-arm-linux-gnueabihf gcc-arm-linux-gnueabihf zlib1g-dev zlib1g-dev:armhf

#Building
Install dependencies and run build.sh

#Usage
After start server will be aviable at http://127.0.0.1:8080/dh/rest you can check info data here - http://127.0.0.1:8080/dh/rest/info  
Admin console aviable at - TODO

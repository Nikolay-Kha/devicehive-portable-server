Portable version of devicehive server which can be run on armhf or x86_64 machine.
Doesn't require anything to install on target machine. Just run ./start.sh in _build dir and have fun!

#Dependencies:
sudo apt-get install libc6-dev-armhf-cross cpp-arm-linux-gnueabihf gcc-arm-linux-gnueabihf zlib1g-dev zlib1g-dev:armhf

There is might be a need to install zlib1g-dev:armhf manually if you need armhf support. To do it, type:
```bash
wget http://zlib.net/zlib-1.2.8.tar.gz
tar xzf zlib-1.2.8.tar.gz
cd zlib-1.2.8
./configure --prefix=/usr/arm-linux-gnueabihf
sed -e "s/CC=gcc/CC=arm-linux-gnueabihf-gcc/" Makefile > tmp.mkf
sed -e "s/CPP=gcc/CPP=arm-linux-gnueabihf-gcc/" tmp.mkf >  Makefile
sed -e "s/LDSHARED=gcc/LDSHARED=arm-linux-gnueabihf-gcc/" Makefile > tmp.mkf
sed -e "s/AR=ar/AR=arm-linux-gnueabihf-ar/" tmp.mkf > Makefile
sed -e "s/RANLIB=ranlib/RANLIB=arm-linux-gnueabihf-ranlib/" Makefile > tmp.mkf
cp tmp.mkf Makefile -f
make -j 8 && make install
```

#Building
Install dependencies and run:  
./build.sh  
If you don't need armhf support:  
./build.sh --noarm  

#Usage
After server start, REST endpoint will be aviable at http://127.0.0.1:8080/dh/rest  
You can check info here - http://127.0.0.1:8080/dh/rest/info  
Admin console aviable at - http://127.0.0.1:8000  
Login: dhadmin  
Password: dhadmin_#911

#Terminated server
killall python java postgres -9
Hope nothing started on your system with the same names :)

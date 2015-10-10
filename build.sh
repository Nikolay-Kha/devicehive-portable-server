#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CACHEDIR=$DIR/_cache
BUILDDIR=$DIR/_build
POSTGREVER="9.4.4"
DEVIVEHIVEVER="2.0.7"
DEVICEHIVEADMINCPVER="2.0.2"

if [ "$1" = "--noarm" ]; then
  NOARM="1"
  echo armhf is disabled
fi

function download() {
  mkdir -p $CACHEDIR
  (cd $CACHEDIR && wget -nc $1)
}

function unpack() {
  (cd $CACHEDIR && tar xf $1)
}

function build_postgre() {
  cp $CACHEDIR/postgresql-$POSTGREVER $CACHEDIR/postgresql-$POSTGREVER-$1 -rn
  if [ ! -f $CACHEDIR/postgresql-$POSTGREVER-$1/config.status ]; then
    (cd $CACHEDIR/postgresql-$POSTGREVER-$1 && ./configure --disable-float8-byval --without-openssl --without-pam --without-perl --without-python --without-readline --without-tcl --host=$2 --prefix=$BUILDDIR/psql-$1)
  fi
  (cd $CACHEDIR/postgresql-$POSTGREVER-$1 && make -j 8 && make install)
}

function mk_postgre() {
  download https://ftp.postgresql.org/pub/source/v$POSTGREVER/postgresql-$POSTGREVER.tar.gz
  unpack postgresql-$POSTGREVER.tar.gz
  (cd $CACHEDIR/postgresql-$POSTGREVER && patch -Np0 -i $DIR/psql-disable-security.patch)
  if [ -z $NOARM ]; then
    build_postgre armv7l arm-linux-gnueabihf
  fi
  build_postgre x86_64 x86_64-linux-gnu
}

function mk_java() {
  download http://http.us.debian.org/debian/pool/main/o/openjdk-8/openjdk-8-jre_8u66-b01-4_$1.deb
  download http://http.us.debian.org/debian/pool/main/o/openjdk-8/openjdk-8-jre-jamvm_8u66-b01-4_$1.deb
  download http://http.us.debian.org/debian/pool/main/o/openjdk-8/openjdk-8-jre-headless_8u66-b01-4_$1.deb
  dpkg -x $CACHEDIR/openjdk-8-jre_8u66-b01-4_$1.deb $CACHEDIR/java-$2
  dpkg -x $CACHEDIR/openjdk-8-jre-jamvm_8u66-b01-4_$1.deb $CACHEDIR/java-$2
  dpkg -x $CACHEDIR/openjdk-8-jre-headless_8u66-b01-4_$1.deb $CACHEDIR/java-$2
  cp $CACHEDIR/java-$2/etc/java-8-openjdk/* $CACHEDIR/java-$2/usr/lib/jvm/java-8-openjdk-$1/jre/lib/ -r --remove-destination
  cp $CACHEDIR/java-$2/etc/java-8-openjdk/jvm-$1.cfg $CACHEDIR/java-$2/usr/lib/jvm/java-8-openjdk-$1/jre/lib/$3/jvm.cfg --remove-destination
  mkdir -p $BUILDDIR/java-$2
  cp $CACHEDIR/java-$2/usr/lib/jvm/java-8-openjdk-$1/jre/* $BUILDDIR/java-$2 -rn
}

# Build PostreSQL
mk_postgre

# Build Java
if [ -z $NOARM ]; then
  mk_java armhf armv7l arm
fi
mk_java amd64 x86_64 amd64

# Kafka
download http://www.us.apache.org/dist/kafka/0.8.2.0/kafka_2.10-0.8.2.0.tgz
mkdir -p $BUILDDIR/kafka
tar xf $CACHEDIR/kafka_2.10-0.8.2.0.tgz -C $BUILDDIR/kafka --strip-components=1

# DeviceHive
download https://github.com/devicehive/devicehive-java-server/releases/download/$DEVIVEHIVEVER/devicehive-$DEVIVEHIVEVER.jar
download https://github.com/devicehive/devicehive-java-server/releases/download/$DEVIVEHIVEVER/devicehive-$DEVIVEHIVEVER-boot.jar
mkdir -p $BUILDDIR/devicehive-server
cp $CACHEDIR/devicehive-$DEVIVEHIVEVER.jar $BUILDDIR/devicehive-server/devicehive.jar -n
cp $CACHEDIR/devicehive-$DEVIVEHIVEVER-boot.jar $BUILDDIR/devicehive-server/devicehive-boot.jar -n

# Copy scripts
cp $DIR/scripts/* $BUILDDIR -rf

#Admin control panel
download https://github.com/devicehive/devicehive-admin-console/archive/$DEVICEHIVEADMINCPVER.tar.gz
mkdir -p $BUILDDIR/admincp
tar xf $CACHEDIR/$DEVICEHIVEADMINCPVER.tar.gz -C $BUILDDIR/admincp --strip-components=1
cp $DIR/config.js $BUILDDIR/admincp/scripts -rf

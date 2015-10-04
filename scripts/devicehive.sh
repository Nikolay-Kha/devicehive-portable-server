#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export PATH=$PATH:$DIR/java-$(uname -i)/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$DIR/java-$(uname -i)/lib

java -server -Xmx256m -XX:MaxRAMFraction=1 -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=70 -XX:+ScavengeBeforeFullGC -XX:+CMSScavengeBeforeRemark -jar $DIR/devicehive-server/devicehive-2.0.6-boot.jar


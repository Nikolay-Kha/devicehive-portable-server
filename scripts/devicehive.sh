#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export PATH=$PATH:$DIR/java-$(uname -i)/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$DIR/java-$(uname -i)/lib

java -Xms128m -Xmx128m -jar $DIR/devicehive-server/devicehive-boot.jar


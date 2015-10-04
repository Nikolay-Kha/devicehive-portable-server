#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export PATH=$PATH:$DIR/java-$(uname -i)/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$DIR/java-$(uname -i)/lib

(cd $DIR/kafka && bin/zookeeper-server-start.sh config/zookeeper.properties)


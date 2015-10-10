#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export PATH=$PATH:$DIR/java-$(uname -i)/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$DIR/java-$(uname -i)/lib
export KAFKA_HEAP_OPTS="-Xmx32M -Xms32M"

(cd $DIR/kafka && bin/kafka-server-start.sh config/server.properties)


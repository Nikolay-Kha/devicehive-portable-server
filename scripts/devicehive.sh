#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export PATH=$PATH:$DIR/java-$(uname -i)/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$DIR/java-$(uname -i)/lib

$DIR/java-$(uname -i)/bin/java -Xms128m -Xmx128m -jar $DIR/devicehive-server/devicehive-boot.jar \
	-Dspring.datasource.url=jdbc:postgresql://127.0.0.1:5432/devicehive \
	-Dspring.datasource.username="postgres" \
	-Dspring.datasource.password="12345" \
	-Dmetadata.broker.list=127.0.0.1:9092 \
	-Dzookeeper.connect=127.0.0.1:2181 \
	-Dserver.context-path=dh/rest \
	-Dserver.port=8080


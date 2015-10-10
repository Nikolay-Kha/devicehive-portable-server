#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

while ! netstat -tulnp 2> /dev/null | grep -q :8080; do
  sleep 1
done
(cd $DIR/admincp && python -m SimpleHTTPServer 8000)

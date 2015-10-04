#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

while ! netstat -tulnp 2> /dev/null | grep -q :5432; do
  sleep 1
done

sleep 1
$DIR/psql-$(uname -i)/bin/psql --username=postgres -c "CREATE DATABASE devicehive;"

#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function check_port() {
  netstat -tulnp 2> /dev/null | grep -q :$1
}

function wait_sevice() {
  while check_port $1; do
    sleep 1
  done
}

function service() {
  if ! check_port $2; then
    ./$1.sh &
    wait_sevice $2
  fi
}

service psql 5432
service zookeeper 2181
service kafka 9092
./devicehive.sh



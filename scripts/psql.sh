#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DBDIR=$DIR/db-$(uname -i)

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$DIR/psql-$(uname -i)/lib

if [ ! -d $DBDIR ]; then
  $DIR/psql-$(uname -i)/bin/initdb -D $DBDIR --username=postgres --no-locale
  $DIR/mkdb.sh &
fi

$DIR/psql-$(uname -i)/bin/postgres -D $DBDIR

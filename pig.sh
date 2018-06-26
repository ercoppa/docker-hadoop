#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
$DIR/pig.orig -4 $DIR/../conf/nolog.conf $@

exit 0

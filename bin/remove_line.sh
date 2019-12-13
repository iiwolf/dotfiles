#!/bin/bash
# remove_line.sh : remove line containing $1 in $2
replace.sh ".*$1.*" "" $2

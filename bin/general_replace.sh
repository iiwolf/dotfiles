#!/bin/bash
# replace $1 with $2 recursivel in directory $3

# for each file in the results of "fd Makefile in flites API dir"
for file in $(rg -l "$1" "$3")
do
    echo $file
    replace.sh "$1" "$2" "$file"
done

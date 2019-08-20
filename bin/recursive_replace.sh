#!/bin/bash
# 'recursive_replace' : replace $1 with $2 recursively in directory $3

# for each file that contains $1 in directory $3 (by way of ripgrep)
for file in $(rg -l "$1" "$3")
do
    echo $file
    replace.sh "$1" "$2" "$file"
done

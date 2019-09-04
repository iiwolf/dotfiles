#!/bin/bash
# dirdiff : diffs directories
dir1=$1
dir2=$2
ext=$3

for file in $(fd "$ext" "$dir1")
do
    echo $file
    echo $dir2/$(basename $file)
    colordiff $file $dir2/$(basename $file)
done
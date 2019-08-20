#!/bin/bash
# Given a text file with paths, lists paths that DNE

paths_file=$1

while IFS= read -r line
do
line="$(echo -e "${line}" | sed -e 's/^[[:space:]]*//')"
ls "$line"
done < "$paths_file"
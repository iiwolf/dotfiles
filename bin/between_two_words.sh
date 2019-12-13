#!/bin/bash
# between_to_words.sh : get lines between two words in a file
# sed -e "s/$1\(.*\)$2/\1/" $3
sed -n "/$1/,/$2/p" $3

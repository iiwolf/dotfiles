#!/bin/bash
# remove_between_two_words : remove all text between $1 and $2 in file $3
sed -i "/$1/,/$2/d" $3
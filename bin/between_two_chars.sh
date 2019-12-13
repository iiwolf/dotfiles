#!/bin/bash
# between_two_chars : gets string between two characters in a line
input_string=$1
char1=$2
char2=$3

echo "$input_string" | cut -d "$char1" -f2 | cut -d "$char2" -f1
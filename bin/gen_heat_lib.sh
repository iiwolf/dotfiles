#!/bin/bash
# Generates single heat lib with all files

for file in $(fd CMakeLists.txt $HEATPATH/src)
do 
    echo "$file"
    echo "("

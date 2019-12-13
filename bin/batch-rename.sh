#!/bin/bash
# batch-rename : rename files with similar structure
find=$1
replace=$2
dir=$3
#right now just simple append
for filename in $dir/$1;
    mv $filename $filename.result
done
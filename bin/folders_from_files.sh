#!/bin/bash
# folders_from_files : creates folders of same name
# as given files and moves them in there
folder=$1
ext=$2
for file in $folder/*"$ext"*; do
    newfolder=$folder/$(basename $file | cut -d '.' -f1)
    echo $newfolder
    mkdir $newfolder
    mv $file $newfolder
done

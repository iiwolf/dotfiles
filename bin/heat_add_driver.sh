#!/bin/bash
# heat_add_driver.sh : driver to add object libs to all heat CMakeLists

for file in $(fd CMakeLists.txt $HEATPATH/src)
do
    echo $file
    cat $file > temp.txt
    general_replace.sh "^# target_link_libraries" "add_dependencies" $dir
    general_replace.sh "^# \s\s" "" $dir
    general_replace.sh "PRIVATE" "" $dir
done


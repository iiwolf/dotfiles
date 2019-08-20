#!/bin/bash
# driver for replacing cmake code in head

dir=/home/ijw/projects/heat/src
general_replace.sh "^# target_link_libraries" "add_dependencies" $dir
general_replace.sh "^# \s\s" "" $dir
general_replace.sh "PRIVATE" "" $dir
#!/bin/bash
# fix FLITES makefiles

# for each file in the results of "fd Makefile in flites API dir"
for file in $(fd Makefile $FLT2_DIR/test/API)
do
    find_and_add.sh "OBJ.*= main.o" "CCFLAGS  = -D_GLIBCXX_USE_CXX11_ABI=0" $file
done

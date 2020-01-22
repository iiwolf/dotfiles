#!/bin/bash
# fly : run heat-flites and move output to ouput dir
testcase=$1
trap "mv *.tiff output" INT
$PROJECTS"/heat-flites/build/heat-flites" $testcase
mv *.tiff output/
trap - INT
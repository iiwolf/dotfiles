#!/bin/bash
# fly : run heat-flites and move output to ouput dir
testcase=$1
rm $PROJECTS/heat-flites/output/*
trap "mv *.tiff output" INT
$PROJECTS"/heat-flites/build/heat-flites" $testcase
# mv *.tiff output/
trap - INT
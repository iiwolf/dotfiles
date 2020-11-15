#!/bin/bash
# save_case : save cadac case under name $1
mkdir $1
cp *.asc $1
cp *.csv $1
cp all_test.png $1
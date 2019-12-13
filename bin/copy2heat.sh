#!/bin/bash
# copy2heat : 
file=$(basename $1)
mv $PREHEATPATH/src/gridgen/$file $HEATPATH/src/core/class-vars/$file
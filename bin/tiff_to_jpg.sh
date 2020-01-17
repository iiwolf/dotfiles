#!/bin/bash
# tiff_to_jpg : converts tiff to jpg and rotates by 180 deg using imagej macros

# Default source and conversion directory @todo make input
HEAT_FLITES=$PROJECTS/heat-flites
source_dir=$HEAT_FLITES/output
buffer_dir=$HEAT_FLITES/results/buffer

# Clear buffer directory before use
rm $buffer_dir/*

# for each tiff in source dir
for file in $source_dir/*.tiff; do
    echo $file

    # Get basename without extension
    bn=$(basename $file)
    filename="${bn%.*}"

    # Call imagej conversion macro (outputs temp.jpg)
    imagej -b BatchMacro -i $file

    # Move temp.jpg to buffer location with correct name
    mv $HEAT_FLITES/results/temp.jpg  $HEAT_FLITES/results/buffer/$filename.jpg
done

#!/bin/bash
# hf_pipeline : runs full heat-flites pipeline to generate images from scratch

# Make sure directories are empty
rm $PROJECTS/heat-flites/output/*

# run heat-flites
fly.sh $1

# Convert all images to jpg
tiff_to_jpg.sh

# Convert directory of jpgs to gif
cd results/buffer
images_to_gif.sh 2 jpg observer_view.gif
cd -
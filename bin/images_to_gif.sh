#!/bin/bash
# images_to_gif : converts group of images to gif using imagemagick
#   - delay     : how long to delay (ms) between each frame
#   - extension : what type of files to look for (i.e. .jpg, .png). Will look for all
#                 files matching *.$extension in the directory you called it from
#   - gif_name  : output gif name

delay=$1
extension=$2
gif_name=$3
convert -delay $delay -loop 0 *.$extension $gif_name
#!/bin/bash
# images_to_gif : 

delay=$1
images=$2
gif_name=$3
convert -delay $delay -loop 0 *.jpg $gif_name
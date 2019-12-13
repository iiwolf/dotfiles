#!/bin/bash
# replace 
echo "Replacing $1 with $2 in $3"
sed -i "s?$1?$2?g" $3

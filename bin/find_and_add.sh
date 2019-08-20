#!/bin/bash
# Find $1 and add $2 after it for file $3

echo "Adding $2 after $1 in $3"
sed -i "/^$1.*/a $2" $3

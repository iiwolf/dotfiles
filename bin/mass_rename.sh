#!/bin/bash
# mass_rename : renames multiple files with regex
for file in *$1*; do
    ext=
    echo "Changing " $file " to " $
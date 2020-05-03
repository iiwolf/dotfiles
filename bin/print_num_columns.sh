#!/bin/bash
# print_num_columns : prints number of columns in csv file
head -$2 $1 | sed 's/[^,]//g' | wc -c
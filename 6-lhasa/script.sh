#!/bin/bash

file_name='scores.txt'

count=$(wc -l $file_name | awk '{print $1}')

sum=0

sum=$(awk '{sum += $2} END {print sum}' "$file_name")
echo "$sum"

mean=$(echo "scale=2; $sum / $count" | bc)
echo "$mean" > solution
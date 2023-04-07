#!/bin/bash
read -p "read string seperated by spaces" str
IFS=''
read -ra addr <<<"$str"
for i in "${addr[@]}";
do
echo "$i"
done

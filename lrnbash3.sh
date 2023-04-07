#!/bin/bash -i
echo 'script name = $0 = ' $0
echo $1 $2 $3 $4 $5 $6 $7 $8 $9 ' > $1 $2 $3 $4 $5 $6 $7 $8 $9 '
args=("$@")
echo ${args[1]} ${args[2]} ${args[3]} ${args[4]}

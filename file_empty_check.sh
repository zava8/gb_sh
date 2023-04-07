#!/bin/bash
printf "ye skript file khali h ya nhi check krTi h. \n"
if [[ -s ~/mg/gb_sh/khali_file ]]
then
   printf "file khali nhi h\n"
else # nhi Toh
   printf "file khali h\n"
fi


#!/bin/bash
select name in raju kumar abcd ; do printf "${name}\n";break ; done
select name ; do printf "${name}\n";break ; done
select fname in *;
do
   printf "yumne ${fname} cuni h\n"
   break;
done
select fname in a{d,c,b}e;
do
   printf "yumne ${fname} cuni h\n"
   break;
done
printf a{d,c,b}e
mkdir ~/mg/gb_sh/{a,b,c,d,e}

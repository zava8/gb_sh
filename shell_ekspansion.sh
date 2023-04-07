#!/bin/bash
# iss time v unset/undefine h
# v=  # v defined h lekin zero str h
# :-(undefined/empty) -(undefined) := =
#v=123
#v2=${v:-DusrvAlue} # v2=${v} Agr v define or khali nhi h.
#printf "v is ${v}\n"
#printf "v2 is ${v2}\n"
#v=
#v2=${v:-DusrvAlue} # v2=${v} Agr v define or khali nhi h.
#printf "v is ${v}\n"
#printf "v2 is ${v2}\n"
v=
unset v
v2=${v-DusrvAlue} # v2=${v} Agr v define or khali nhi h.
printf "v is ${v}\n"
printf "v2 is ${v2}\n"

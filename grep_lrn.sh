#!/bin/bash -xv
grep root /etc/passwd
grep -n root /etc/passwd # -n line nmbr print krTa h
grep -v /bash /etc/passwd | grep -v nologin
grep -c false /etc/passwd
grep -i ps ~/.bash* | grep -v history
grep ^root /etc/passwd
grep :$ /etc/passwd # $ se line ke last me match krTa h
grep export ~/.bashrc | grep '\<PATH'
grep -w / /etc/fstab
grep [yf] /etc/group
grep '\<c...h\>' /usr/share/dict/words
grep '\<c.*h\>' /usr/share/dict/words
grep '*' /etc/profile
ls -ld [a-cx-z]*
# "alnum", "alpha", "ascii", "blank", "cntrl", "digit", "graph", "lower", "print", "punct", "space", "upper", "word" "xdigit"
ls -ld [[:digit:]]*
ls -ld [[:upper:]]*


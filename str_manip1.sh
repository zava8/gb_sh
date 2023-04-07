#!/bin/bash
# assignment = 
# remove # ## % %% 
# replacement / // /# /%
#
var1="_dHi_dhlla_dhokla_chat_cat_"
var2=${var1/#_*_/_bhlla_}
printf "var2 is ${var2}\n"
var2=${var1/%_*_/bhlla_}
printf "var2 is ${var2}\n"

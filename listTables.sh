#!/bin/bash
export LC_COLLATE=C       #To sort ascii character
shopt -s extglob          #import Advanced Regex

# check if command list returns zero
if [ -z "$(ls -F)" ]
then
echo "No Tables Found"
. ../../tableMenu.sh
else
	echo "Tables List"
	ls -F ./ | sed -n '/meta_/!p'
	. ../../tableMenu.sh
fi	

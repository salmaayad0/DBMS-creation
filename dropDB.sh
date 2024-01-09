#!/bin/bash
export LC_COLLATE=C             #To sort ascii character
shopt -s extglob                #import Advanced Regex

echo "The Databases are:"
ls ./DBMS
echo -n "Enter the Database name You want to Drop: "
read db_name

if [ -d ./DBMS/$db_name ]
then
	echo "Are You Sure You Want to Drop $db_name Database:"
	select dropOption in "Yes" "No"
	do
		case $dropOption in
			"Yes" ) 
			rm -r ./DBMS/$db_name
			echo "$db_name is Dropped Successfully"
			. ./mainmenu.sh
;;
"No" ) 
	echo "Drop $db_name was cancelled"
	. ./mainmenu.sh
;;
* ) 
echo "Please Enter Valid Numbers"
;;
			esac
			done
	
else
	echo "$db_name doesn't exist to drop"
	. ./dropDB.sh
fi


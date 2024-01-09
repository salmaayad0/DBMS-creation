#!/bin/bash
export LC_COLLATE=C  #To sort ascii character
shopt -s extglob     #import Advanced RegEx

echo -n "Enter Your Database Name: "
read db_name

#name check
if [[ $db_name == *[!a-zA-Z0-9_]* ]]
then
	echo "Invalid Database Name it can't start with numbers or speacial character"
	. ./createDB.sh

elif [[ $db_name == [0-9]* ]]
then 
	echo "Database name can't start with number"
 	. ./createDB.sh
elif [[ $db_name == "" ]]
then 
	echo "Database name can't be empty"
	. ./createDB.sh
fi

#dir check
if [ -d ./DBMS/$db_name ]
then
	echo -e "Sorry cannot add $db_name as it  already exists, choose again from the main menu"
	. ./createDB.sh
else
	mkdir ./DBMS/$db_name
	echo -e "$db_name is created successfully"
	. ./mainmenu.sh
fi


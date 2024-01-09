#!/bin/bash 
export LC_COLLATE=C  #To sort ascii character
shopt -s extglob     #import extended pattern matching RegEx

echo -e "\n Choose from Databases To Connect on "
ls -F ./DBMS | grep / 
echo -e "Please Enter your Database Name: "
read database

	if [ -d ./DBMS/$database ]
	then
		echo -e "You are connected on $database now"
		cd ./DBMS/$database
		. ../../tableMenu.sh
	else
		echo -e "$database doesn't exist, try to conect again"
		. ./connectDB.sh
fi



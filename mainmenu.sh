#!/bin/bash 
export LC_COLLATE=C  #To sort ascii character
shopt -s extglob     #import extended pattern matching RegEx

if [ ! -d DBMS ]
then
	mkdir ./DBMS
fi

echo -e "\n Hello WELCOME TO DBMS MAIN MENU :) \n"
echo "1) Create Database"
echo "2) List Databases"
echo "3) Connect to Database"
echo "4) Drop Database"
echo "5) Exit"
echo -e "Enter your choice: \c"
read choice

case $choice in 
	1) 
	source ./createDB.sh
		;;
	2) 
	ls ./DBMS ; source ./mainmenu.sh
		;;
	3) 
	source ./connectDB.sh
		;;
	4) 
	source ./dropDB.sh
		;;
	5) 
	exit
		;;
	*) 
	echo "Please choose number from 1 to 5"; source ./mainmenu.sh ;
esac

#!/bin/bash
export LC_COLLATE=C             #To sort ascii character
shopt -s extglob                #import Advanced Regex

echo "Tables To Select From"
ls -F ./ | sed -n '/meta_/!p' | column -t

echo "Please Enter Table Name: "
read tableName
while [ true ]
do
	if [ -f ./$tableName ]
	then
		select choice in "Select All Columns" "Select Specific Column" "Back To Table Menu" "Back to Main Menu" "Exit"
	do
		case $choice in
			"Select All Columns" ) 
				echo "$tableName Table Content is"
				column -t -s "|" $tableName 
				. ../../tableMenu.sh
				;;
			"Select Specific Column" )
				echo "`head -1 $tableName | column -t -s "|"`" 
				echo -n "Please Enter Column Name:"
				read col_name
				col_num=`awk -F"|" -v col="$col_name" 'NR==1{for (i=1;i<=NF; i++) if ($i==col) {print i;exit}}' $tableName`
				awk -F"|" -v val="$col_num" '{print $val}' $tableName | column -t -s "|"
				. ../../tableMenu.sh
				;;
			"Back To Table Menu" )
				clear
				. ../../tableMenu.sh
				;;
			"Back to Main Menu" )
				cd ../..
				clear
				. ./mainmenu.sh
				exit
				;;
			"Exit" )
				exit 
				;;
			* ) 
				echo "Sorry, Please Select a correct number"
		esac
	done
	else
		echo "Table not found"
		echo "Please Enter Table Name:"
		read tableName
	fi
done

#!/bin/bash
export LC_COLLATE=C       #To sort ascii character
shopt -s extglob          #import Advanced Regex

echo "Please Select 1 Or 2: "
select dropOption in "Drop Table" "Back"
	do
		case $dropOption in
		"Drop Table" )
			echo "Tables List"
			ls -F ./ | sed -n '/meta_/!p'
			echo "Please Enter the table name you want to drop: "
			read tableName
			if [[ -f $tableName ]]
			then
				echo "Please Select 1 If You Are Sure and 2 To Cancel"
				select s_op in "Yes" "Cancel"
				do
				case $s_op in
				"Yes" ) 
				rm -rf $tableName meta_$tableName
				echo "Table was dropped successfully"
				. ../../tableMenu.sh
;;
"Cancel" ) 
	echo "Drop Table was cancelled"
	. ../../tableMenu.sh
;;
* ) 
echo "Please Enter Valid Numbers"
;;
			esac
			done
else
	echo "Table $tableName not found or invalid"
	. ../../dropTable.sh
fi
;;
"Back" ) 
	echo "Backed To Table Menu"
	. ../../tableMenu.sh
;;
* ) 
	echo "Please Enter Valid Numbers"
;;
		esac
done

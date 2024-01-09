#!/bin/bash
export LC_COLLATE=C             #To sort ascii character
shopt -s extglob                #import Advanced Regex

echo -e "\nTable Main Menu"
select choice in "Create Table" "List Table" "Drop Table" "Insert Into Table" "Select From Table" "Delete From Table" "Update Table" "Back To Main Menu" "exit"
do
case $REPLY in 
1) ../../createTable.sh
;;
2) ../../listTables.sh
;;
3) ../../dropTable.sh
;;
4) ../../insertIntoTable.sh
../../tableMenu.sh
;;
5) ../../selectFromTable.sh
;;
6) ../../updateTable.sh
../../tableMenu.sh
;;
7) ../../deleteFromTable.sh
;;
8) 
cd ../../
. ./mainmenu.sh
;;
9) exit
;;
*) echo $REPLY is not one of the options 
echo "try again"
esac
done

#!/bin/bash
export LC_COLLATE=C         #To sort ascii character
shopt -s extglob            #import Advanced Regex

select Op in "Create Table" "Back"
	do
		case $Op in
			"Create Table")
				echo -n "Enter the Table Name: "
				read tableName
				break
				;;
			"Back")
				../../tableMenu.sh
				break
				;;
			*)
				echo "Invalid type please choose again"
				;;
		esac
	done

if [[ $tableName == *[!a-zA-Z0-9_]* ]]
then
	echo "Invalid Table Name"
	. ../../createTable.sh
elif [[ $tableName == [0-9]* ]]
then 
	echo "Table name can't start with number"
 	. ../../createTable.sh
elif [[ $tableName == "" ]]
then 
	echo "Table name can't be empty"
	. ../../createTable.sh
fi

if [[ -f $tableName ]]
then
	echo "Sorry but $tableName already exists, try again with another name"
	. ../../createTable.sh
fi

echo -n "Enter Number of fields: "
read fieldNum
while ! [[ $fieldNum =~ ^[0-9]+$ ]]
do
	echo -n "Please Enter a valid Number"
	read fieldNum
done

pk=""
i=1
while (( $fieldNum >= $i ))
do
	#Fields Names From User
	echo  "Enter the Name of field no $i : "
	read fieldName
	while ! [[ $fieldName = +([A-Za-z_]) ]]
	do
		echo "Field Name must be a String"
		echo "Enter the Name of field no $i"
	        read fieldName
	done
	#Fields Types From User
	echo "Choose the type of $fieldName"
	select ftype in "Integer" "String"
	do
		case $ftype in
			Integer)
				fieldType="int"
				break
				;;
			String)
				fieldType="string"
				break
				;;
			*)
				echo "Invalid type please choose again"
				;;
		esac
	done
	#Check if it is a PK or not
	echo "Is this field is the Primary Key? "
	select opt in "yes" "no"
	do
		case $opt in
			yes )
				pk="PK";
				break
				;;
			no )
				pk=""
				break
				;;
			* )
				echo "Please choose Yes or No!"
				;;
		esac
	
	done
	
	sep="|"
	metaValues[$i]=$fieldName$sep$fieldType$sep$pk
	
	(( i++ ))
done
#Create meta file and append its content to it.
touch meta_$tableName
echo -e "FieldName | FieldType | PrimaryKey " >> meta_$tableName
for j in ${metaValues[*]}
do
	echo -e $j >> meta_$tableName
done
touch $tableName
#From meta file remove first line and append data to the table file
awk 'NR>1' meta_$tableName | cut -d "|" -f 1 | awk '{printf "%s|",$1}' > $tableName
	    sed -i 's/\(.*\)|$/\1/' $tableName
            echo -e "\n" >> $tableName

echo "$tableName is created successfully"
. ../../tableMenu.sh




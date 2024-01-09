#!/bin/bash
export LC_COLLATE=C       #To sort ascii character
shopt -s extglob          #import Advanced Regex

select Op in "Insert Into Table" "Back"
	do
		case $Op in
			"Insert Into Table")
				echo "Tables To Insert Into "
				ls -F ./ |  sed -n '/meta_/!p' | column -t
				echo -n "Please Enter Table Name: "
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

if [[ -f $tableName ]]
then
	 # return the number of columns in the table
	 fieldNum=`awk -F "|" '{if(NR==1) print NF}' $tableName`
	 i=2  
    	 while (( $i-1 <= $fieldNum ))
	 do
    	 fieldName=$(awk 'BEGIN{FS="|"}{ if(NR=='$i') print $1}' meta_$tableName)
    	 fieldType=$( awk 'BEGIN{FS="|"}{if(NR=='$i') print $2}' meta_$tableName)
    	 pk=$( awk 'BEGIN{FS="|"}{if(NR=='$i') print $3}' meta_$tableName)
    	 echo "Enter The Value of Field $fieldName:"
    	 read value
    	 if [[ "$fieldType" = "int" ]]   
         then
            # check if entered value not empty and not a number
            while ! [[ "$value" =~ ^[0-9]+$ && -n "$value" ]]  
            do
            	echo "Invalid Data Type, Please Enter integers only"
                echo "Enter The Value of Field $fieldName: "
                read value
            done
            elif [ "$fieldType" = "string" ]
        then
	    # check if entered value not empty and not a string
            while ! [[ "$value" =~ ^[a-zA-Z_] && -n "$value" ]]
            do
            	echo "Invalid Data Type, Please Enter strings only"
		echo "Enter The Value of Field $fieldName: "
                read value          
            done
        fi
        if [[ "$pk" = "PK" ]]
        then
		while [[ $value =~ ^[`awk 'BEGIN{FS="|"}{if(NR != 1)print $(('$i'-1))}' $tableName`]$ ]]
		do
			echo "Sorry, This Primary Key already Exists"
		        echo "Enter The Value of Field $fieldName: "
		        read value 
		done
        fi
	new_line="\n"
	seperator="|"
        if (( $i-1 == $fieldNum ))
        then
            new_row=$value$new_line
        else
            new_row=$value$seperator
        fi
        echo -e $new_row"\c" >> $tableName
        ((i++))
    done
    echo "Your Data is inserted Successfully"
   else
   	echo "Table Name doesn't exist"
   	. ../../insertIntoTable.sh
   fi	 


	 



	 

#!/bin/bash
export LC_COLLATE=C             #To sort ascii character
shopt -s extglob                #import Advanced Regex

echo -e "Delete From Table \n"
select deleteOption in "Delete All table Data" "Delete Specific Row" "Back"
do
    case $deleteOption in

      "Delete All table Data")

            echo -e "Tables To Delete From: \n"
            ls -F ./ |  sed -n '/meta_/!p' | column -t
            echo -n "Please Enter Table Name: "
            read tableName
            if [[ -f $tableName ]] 
	        then
                echo "$tableName Table Content is: "
		        column -t -s "|" $tableName
                sed -i '2,$d' $tableName
                echo "Table Data is deleted Successfully " 
                . ../../tableMenu.sh 
            else
                    echo "Table Name is Invalid Or Not Found."
                    echo ""
                    . ../../deleteFromTable.sh
            fi
            ;;  
      
      "Delete Specific Row")
      
        echo "Tables To Delete"
        ls -F ./ |  sed -n '/meta_/!p' | column -t
        echo -n "Please Enter Table Name: "
        read tableName
      
        if [[ -f $tableName ]] 
        then
            echo "$tableName Table Content is"
            column -t -s "|" $tableName
            echo  -n "Please Enter Column Name You Want To Delete From: "
            read fieldName
            while ! [[ $fieldName = +([A-Za-z_]) ]] 
                do
                    
                    echo "Invalid Column Name"
                    echo -n "Please Enter Column Name You Want To Delete From: " 
		    read fieldName
                done
            colId=$(awk '                                  
                    BEGIN{FS="|"} 
                    {
                        if(NR==1)
                        {
                            for(i=1;i<=NF;i++)
                            {
                                if($i=="'$fieldName'") 
                                    print i
                            }
                        }
                    } ' $tableName) 

            if [[ $colId == "" ]]
            then
                echo "Column $fieldName does not exist"
                . ../../tableMenu.sh
            else
		echo -n "Enter any value in the column you entered to delete this row:"
                read val

                res=$(awk '
                    BEGIN{FS="|"}
                    {
                        if ($'$colId'=="'$val'") 
                            print $'$colId'
                    } ' $tableName )    
                if [[ $res == "" ]]
                then
                    echo -e "$val Not Found At The Column $fieldName you Enterd Before"
                    source ../../tableMenu.sh
                else
                    NR=$(awk '
                        BEGIN{FS="|"}
                        {
                            if ($'$colId'=="'$val'") 
                                print NR
                        } ' $tableName ) 
                    sed -i ''$NR'd' $tableName 
		    echo "Row Deleted Successfully"
                    source ../../tableMenu.sh
                fi
            fi
        else
        	echo "Table Name is Invalid Or Not Found."
                source ../../tableMenu.sh
        fi
        ;;        
        "Back" )
            source ../../tableMenu.sh
        ;;
        * )
            echo " Sorry, please select a number."
        ;;
    esac

done

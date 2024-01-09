#!/bin/bash
export LC_COLLATE=C       #To sort ascii character
shopt -s extglob          #import Advanced Regex

echo "Tables to Update "
ls -F ./ |  sed -n '/meta_/!p' | column -t

echo -n "Please Enter the Name of the Table You Want to Update: "
read tableName

while [ true ]
do
    if [ -f ./$tableName ]
    then
    	echo "The $tableName Table has this Columns "
    	echo "`head -1 $tableName | column -t -s "|"`" 
        echo -n "Please Choose the Name of the Column You Want to Update in: "
        read fieldName
        col_num=`awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$fieldName'") print i}}}' $tableName 2>>/dev/null`  
        if [[ $col_num == "" ]]
        then
            echo "There is No Column with this Name!"
            continue
	else
            echo "$tableName Table Content is: "
            column -t -s "|" $tableName
            echo -n "Enter the Value You Want to Update: "
            read value           
            col_val=`awk 'BEGIN{FS="|"}{if ($'$col_num'=="'$value'") print $'$col_num'}' $tableName 2>>/dev/null` 
            if [[ $col_val != "" ]]
            then
                echo "The Row You Want to Update is: "
                # create old value file temporary
                head -1 $tableName >> oldvalue
                grep -w "$value" $tableName >> oldvalue
                column -t -s "|" oldvalue
                # Enter New Value
                echo -n "Please Enter the new value: "
		    read newvalue
		    NR=`awk 'BEGIN{FS="|"}{if ($'$col_num' == "'$value'") print NR}' $tableName 2>>/dev/null` 
		    oldvalue=`awk 'BEGIN{FS="|"}{if(NR=='$NR'){for(i=1;i<=NF;i++){if(i=='$col_num') print $i}}}' $tableName 2>> /dev/null` 
		    sed -i ''$NR's/'$oldvalue'/'$newvalue'/g' $tableName 2>>/dev/null
		    echo "The Table After Update: "
		    head -1 $tableName >> newval
		    grep -w "$newvalue" $tableName >> newval
		    column -t -s "|" newval
		    echo ""
		    echo "The Table Before Update: "
		    column -t -s "|" oldvalue
		    echo ""
		    echo "The Table is Updated Successfully"
		    rm -rf oldvalue newval
		    break
            fi
        fi
    else
        echo "Sorry This Table Does Not Exist"
        echo -n "Please Enter the Name of the Table You Want to Update: "
	read tableName
    fi
done

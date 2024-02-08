#!/bin/bash

function updateRecord {
    read -p "Enter Table Name: " tableName
    script_dir="DBMS"
    table_dir="./databases/$1"
    table_file="$table_dir/$tableName"
    meta_file="$table_dir/${tableName}_meta"

    if [[ ! -f "$table_file" ]]; then
        echo "Error: Table $tableName does not exist."
    else
        read -p "Enter primary key value: " primaryKeyValue

        columnName=$(grep ":pk" "$meta_file" | cut -d: -f1)
        colLineNumber=$(grep -n "^$columnName:" "$table_file" | cut -d: -f1)
        found=false

        while read -r record; do
            if [[ "$primaryKeyValue" == $(echo "$record" | cut -d: -f$colLineNumber) ]]; then
                found=true
                break
            fi
        done < "$table_file"

        if $found; then
            read -p "Enter column to update: " columnToUpdate
            colLineNumber=$(grep -n "^$columnToUpdate:" "$table_file" | cut -d: -f1)
            dataType=$(grep "^$columnToUpdate:" "$meta_file" | cut -d: -f2)

            if [[ -n "$colLineNumber" ]]; then
                read -p "Enter new value for $columnToUpdate: " newValue

                if [[ -z "$newValue" ]]; then
                    echo "Error: $columnToUpdate cannot be empty."
                elif [[ "$dataType" == "integer" && ! "$newValue" =~ ^[0-9]+$ ]]; then
                    echo "Error: $columnToUpdate must be an integer."
                else
                    sed -i "${colLineNumber}s/^.*$/${colLineNumber}:${newValue}/" "$table_file"
                    echo "Record updated successfully."
                fi
            else
                echo "Error: Column $columnToUpdate not found in the table file."
            fi
        else
            echo "Error: Primary key not found."
        fi
    fi
}

# Call the function to update data
updateRecord


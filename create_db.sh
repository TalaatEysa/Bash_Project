#!/bin/bash

function createDb {
read -p "Enter the name of your database: " db_name

if [[ $db_name =~ ^[0-9] ]]; then
echo "The database name should not start with a number,Please enter a valid name."
return
fi

if [[ $db_name == *" "* ]]
then
echo "The name of database should not contain spaces,please enter again."
return
fi

if [[ ! $db_name =~ ^[a-zA-Z][a-zA-Z0-9_]*$ ]]
then
echo "The database name should only contain letters, numbers, or underscores,please enter again your name."
return
fi

data_folder="./databases"

if [ ! -d "$data_folder" ]; then
	mkdir "$data_folder"
	echo "Created 'database' folder."
fi

if [ -d "$db_name" ]
then
echo "Database $db_name already existed,pleaze Enter another name"
else
mkdir "$data_folder/$db_name"
echo "Database $db_name created successfully"
source ./main.sh
fi

}

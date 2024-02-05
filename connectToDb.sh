#! /usr/bin/bash

source ./createTable.sh
function connectToDb {

	databases="./databases"

# Check if the "data" folder exists
if [ ! -d "$databases" ]; then
	echo "the databases folder is not found ..."
	./main.sh
fi

	databasesfound=$(ls ./databases| wc -l)

	if (($databasesfound == 0)); then
		echo "the database folder is empty!"

	else

		echo "What Database do you want to connect to ?"

		# Check if the "data" folder exists
		if [ ! -d "$databases" ]; then
			echo "No databases yet. 'database' folder does not exist."
		else
			echo "Already existing databases:"

			# List existing databases in the "data" folder
			if [ "$(ls -A "$databases")" ]; then
				ls -F "$databases" | grep / | tr / " "

			else
				echo "No databases yet. 'data' folder is empty."
			fi
		fi

		read name

		if [ -d databases/$name ]; then
			#cd database/$name
			echo "successfully connected to $name database"

			select choice in "create table" "drop table" "list tables" "select from table" "insert into table" "update from table" "delete from table" "connect to another database" "return to main"; do
				case $REPLY in
				1)
					createTable $name
					break
					;;
				2)
					./drop_tabel $name
					break
					;;
				3)
					./list_tabel.sh $name
					break
					;;
				4)
					./selectFromTable $name
					break
					;;
				5)
					./InsertTabel.sh $name
					break
					;;
				6)
					./updateTable $name
					break
					;;
				7)
					./deleteFromTable $name
					break
					;;
				8)
					connect
					break
					;;
				9)
					./main
					break
					;;

				*)
					echo "Invalid Input."
					;;
				esac

			done
		else
			echo "database $name does not exist."
			connectToDb

		fi
	fi	
}

connectToDb

#!/bin/bash
options=({1..5})
exit=0


while [[ exit -ne 1 ]]; do
	clear;
	echo -e "-----------"
	echo "1. Add User"
	echo -e "\e[31m2. Remove User\e[0m"
	echo "3. Update password"
	echo "4. List users"
	echo "5. Exit"
	echo "-----------"

	read -p "Choose an option [q to quit]: " choice

	case ${choice} in 
		"${options[0]}") 
		read -p "Enter the name of the user: " newUser
		if (sudo useradd "${newUser}"); then 
			echo "User created  successfully!"
		else
			echo "Error: Unable to create user."
		fi
		sleep 2
		;;

		"${options[1]}")

			echo -e  "-----------------\n"
	                awk -F ':' '{ if ( $3 > 999 && $3 != 65534) {print $1 } }'  '/etc/passwd'
			echo -e  "-----------------\n"

			read -p "Enter the name of the user you want to delete: " delUser
			if (sudo userdel -r  "${delUser}"); then 
				echo -e "User deleted  successfully!\n"
			else
				echo -e "Error: Unable to delete user.\n"
			fi
			sleep 2
			;;


		"${options[2]}") 
			read -p "Enter the name of the user you want to update its password: " userpass
			if (passwd   "${userpass}"); then 
				echo -e "User's password changed successfully!\n"
			else
				echo -e "Error: Unable to change user's password.\n"
			fi
			sleep 2
			;;



		"${options[3]}")

			echo -e  "-----------------\n"
	                awk -F ':' '{ if ( $3 > 999 && $3 != 65534) {print ++count, $1 } } END { print "Total number of users: ", count}' '/etc/passwd'
			echo -e  "-----------------\n"

			sleep 2

			;;


		"${options[4]}"|'q'|'Q') 
		break
		;;
		*)
		echo "INVALID OPTION! Please choose a number from 1 to 5 or q to quit."
		sleep 2;;
	esac

done

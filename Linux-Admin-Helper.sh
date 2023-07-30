#!/bin/bash
#Run this script by using sudo bash "script name"(sudo comand help you to get root access)
#MOALE BOGDAN

echo "Please select your option:"
select script in Adduser Ssh_server Route Processes IP Change_Ip Change_Netmask Change_Gateway Exit Credits
do
	case $script in	
		Adduser)
		if [ $(id -u) -eq 0 ]; then
	          read -p "Enter username : " username
	          read -s -p "Enter password : " password
	          egrep "^$username" /etc/passwd >/dev/null
	          if [ $? -eq 0 ]; then
		    echo "$username exists!"
		    exit 1
	          else
		     pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		     useradd -m -p $pass $username
		     [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
	         fi
                 else
	             echo "Only root may add a user to the system.I will execute the script with root acces!"
		     sudo bash script.sh
	             exit 2
               fi
		;;
		Ssh_server)
			sudo apt-get update
                        sudo apt-get install openssh-server
			echo "Ssh server was instaled.Enjoy!"
		;;
		Route)
			sudo route -n
                        route
			echo "DONE!"
		;;
		Processes)
			ps
                        ps -f
                        ps -n
			echo "DONE!"
		;;
		IP)
			ifconfig
			echo "DONE!"
		;;
		Exit)
			break
			clear
		;;
		Change_Ip)
			echo "Enter your ip:"
			echo "Ip="
			read Ip
			sudo ifconfig eth0 $Ip
			echo "Your ip has been changed."
		;;
		Change_Netmask)
			echo "Enter your netmask"
			echo "netmask="
			read netmask
			sudo ifconfig eth0 netmask $netmask
			echo "Your netmask has been changed."
		;;
		Change_Gateway)
			echo "Enter your gateway :"
			echo "gateway="
			read gateway
			sudo route add default gw $gateway
			echo "Your gateway has been changed."	
		;;
		Credits)
			echo "This script was made by Moale Bogdan"
		;;
		*)
			echo "You do not entered a valid option."	
			sudo bash script.sh
	esac
done


			

			

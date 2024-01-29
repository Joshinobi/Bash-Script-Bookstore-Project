#!/bin/bash

#This script is for the register option
#Joshua C. Gonzales

tput clear

figlet Hello there! | lolcat
cat register_guide.txt | lolcat

read -p "Enter your full name: " First MI Last

n=0
while [ $n -eq 0 ]
do 
	read -p "Enter your delivery address: " home_address
	if [ ${#home_address} -ge 100 ]
	then	
	       echo Maximum of 100 characters only
	else
		n=1
	fi
done

n=0
while [ $n -eq 0 ]
do
	read -p "Enter your email address: " email_address
	if [[ $email_address != *"@"*".com" ]]
	then
		echo Invalid email address
	else
		n=1
	fi
done

n=0
while [ $n -eq 0 ]
do
	read -p "Enter your username: " user
	if [[ ${#user} -lt 8 ]] || [[ $user != [a-zA-Z]* ]] || [[ $(cat users.txt | cut -d: -f1 | grep -w $user) ]]
	then
		echo Invalid Username!
		echo -Must be at least 8 characters
		echo -Must begin with an alphabetical letter
		echo -Must be unique
	else
		n=1
	fi
done

n=0
while [ $n -eq 0 ]
do
	read -s -p "Enter your password: " passwd
	echo 
	if [ ${#passwd} -ge 8 ] && ([[ $passwd =~ [[:lower:]] ]] && [[ $passwd =~ [[:upper:]] ]]) && [[ $passwd =~ [[:digit:]] ]] && [[ $passwd =~ [[:punct:]] ]] && [[ $passwd != $user ]]
	then
		n=1
	else
		echo Weak Password!
		echo -Must be at least 8 characters
		echo -Must contain at least 1 lower case letter, 
		echo  1 upper case letter, 1 digit, and 
		echo  1 punctuation mark
		echo -Must not be similar with the username	
	fi
done

n=0
while [ $n -eq 0 ]
do
	read -s -p "Confirm your password: " cpasswd
	echo
	if [[ $cpasswd != $passwd ]]
	then
		echo Not similar to your password!
	else
		epasswd=$(echo $cpasswd | openssl enc -base64 -e -aes-256-cbc -nosalt -pass pass:garbageKey 2> /dev/null)
		n=1
	fi
done

n=0
while [ $n -eq 0 ]
do
	read -p "Type 'yes' if you wish to sign up or 'no' to cancel: " ans
	case $ans in
		"yes")
			current_uid=$(cut -d: -f2 users.txt | tail -1)
			new_uid=$(($current_uid+1))
			echo $user:`printf "%04d" $new_uid`:$epasswd:$First $MI $Last:$home_address:$email_address:`date +%d/%m/%y` >> users.txt
			
			echo $user:`printf "%04d" $new_uid`:$epasswd:$First $MI $Last:$home_address:$email_address:`date +%d/%m/%y` > loggeduser.txt
			
			touch cart_tmp1.txt cart_tmp2.txt cart_tmp3.txt cart_tmp4.txt cart_tmp5.txt
			bash mainMenu.bash
			;;
		"no")
			bash start.bash
			;;
		*)
			echo Incorrect input
			;;
	esac
done

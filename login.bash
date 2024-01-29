#!/bin/bash

#This script is for the login option
#Joshua C. Gonzales

tput clear

figlet Welcome Back! | lolcat

n=0
while [ $n -eq 0 ]
do
	read -p "Enter username: " iuser
	if [[ $iuser == $(cat users.txt | cut -d: -f1 | grep -w $iuser) ]]
	then
		fpasswd=$(grep -w $iuser users.txt | cut -d: -f3)
		dpasswd=$(echo $fpasswd | openssl enc -base64 -d -aes-256-cbc -nosalt -pass pass:garbageKey 2> /dev/null)
		n=1
	else
		echo This username is unavailable. You must register to create an account!
	fi
done 

n=0
while [ $n -eq 0 ]
do
	read -s -p "Enter password: " ipasswd
	echo 
	if [[ $ipasswd == $dpasswd ]]
	then
		grep -w $iuser users.txt > loggeduser.txt
		touch cart_tmp1.txt cart_tmp2.txt cart_tmp3.txt cart_tmp4.txt cart_tmp5.txt
		bash mainMenu.bash
	else
		echo Incorrect password!
	fi
done

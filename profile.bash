#!/bin/bash

#This is the script for the profile option
#Joshua C. Gonzales

tput clear

figlet Your Profile | lolcat

xuser=$(cut -d: -f1 loggeduser.txt)
xname=$(cut -d: -f4 loggeduser.txt)
xdadd=$(cut -d: -f5 loggeduser.txt)
xeadd=$(cut -d: -f6 loggeduser.txt)
xdate=$(cut -d: -f7 loggeduser.txt)

tput setaf 2
echo "Username"
tput sgr0
echo $xuser
echo

tput setaf 2
echo "Full Name"
tput sgr0
echo $xname
echo

tput setaf 2
echo "Delivery Address"
tput sgr0
echo $xdadd
echo

tput setaf 2
echo "E-mail Address"
tput sgr0
echo $xeadd
echo

tput setaf 2
echo "Date Created"
tput sgr0
echo $xdate
echo

echo "A) Edit profile information"
echo "G) Go back to main menu"

n=0
while [ $n -eq 0 ]
do
	read -p "Enter an option: " i
	case $i in
		[Aa])
			bash profileEdit.bash
			;;
		[Gg])
			bash mainMenu.bash
			;;
		*)
			echo Invalid input
			;;
	esac
done

#!/bin/bash

#This script is for the customer care option
#Joshua C. Gonzales

tput clear

figlet Contact Information | lolcat

tput setaf 2
echo "Website"
tput sgr0
echo "www.BookRUs.com.ph"
echo

tput setaf 2
echo "E-mail"
tput sgr0
echo "BookRUs@gmail.com"
echo

tput setaf 2
echo "Social Media"
tput sgr0
echo "@booksrusph"
echo

echo "(4) Go back"
echo "(G) Main menu"

n=0
while [ $n -eq 0 ]
do
	read -p "Enter an option: " i
	case $i in
		4)
			bash page2.bash
			;;
		[Gg])
			bash mainMenu.bash
			;;
		*)
			echo Invalid input
			;;
	esac
done

			


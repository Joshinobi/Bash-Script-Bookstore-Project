#!/bin/bash

#This script is for the customer care option
#Joshua C. Gonzales

tput clear

figlet FAQs | lolcat

tput setaf 2
echo "How do How do I return or exchange books I purchased by mistake?"
tput sgr0
echo "You can return or exchange these books by contacting us within a week only."
echo

tput setaf 2
echo "Do you deliver outside Metro Manila?"
tput sgr0
echo "Yes, we deliver outside of Metro Manila."
echo

tput setaf 2
echo "Are your books brand new or previously owned?"
tput sgr0
echo "Our books are brand new and previously owned."
echo

tput setaf 2
echo "Do you have books in Chinese?"
tput sgr0
echo "No, we do not have Chinese books as of the moment."
echo

echo "(2) Proceed to second page"
echo "(3) Contact Details"
echo "(4) Go back"
echo "(G) Main menu"

n=0
while [ $n -eq 0 ]
do
	read -p "Enter an option: " i
	case $i in
		2)
			bash page2.bash
			;;
		3)
			bash contact.bash
			;;
		4)
			bash care.bash
			;;
		[Gg])
			bash mainMenu.bash
			;;
		*)
			echo Invalid input
			;;
	esac
done

			


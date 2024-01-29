#!/bin/bash

#This script is for the customer care option
#Joshua C. Gonzales

tput clear

figlet FAQs | lolcat

tput setaf 2
echo "Do you have books in foreign languages?"
tput sgr0
echo "No, we do not have books in foreign languages as of the moment."
echo

tput setaf 2
echo "How do we contact you personally?"
tput sgr0
echo "You can contact us personally through our website," 
echo "e-mail, Instagram, twitter, or facebook page."
echo "These information can be viewed in the contact details page."
echo

tput setaf 2
echo "Where do you get your books?"
tput sgr0
echo "We get our books from different local and international sources"
echo

tput setaf 2
echo "Do you buy used books?"
tput sgr0
echo "Yes, we buy used books."
echo

echo "(3) Contact Details"
echo "(4) Go back"
echo "(G) Main menu"

n=0
while [ $n -eq 0 ]
do
	read -p "Enter an option: " i
	case $i in
		3)
			bash contact.bash
			;;
		4)
			bash page1.bash
			;;
		[Gg])
			bash mainMenu.bash
			;;
		*)
			echo Invalid input
			;;
	esac
done

			


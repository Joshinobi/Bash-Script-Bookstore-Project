#!/bin/bash

#This script is for the payment option
#Joshua C. Gonzales

tput clear

figlet Payment | lolcat

echo "A) Credit card"
echo "B) Debit card"
echo "C) Cancel payment"
echo "G) Go back to main menu"

n=0
while [ $n -eq 0 ]
do
	read -p "Enter an option: " i
	case $i in
		[ABab])
			echo
			x=0
			while [ $x -eq 0 ]
			do
				read -p "Enter your card number: " cardnum
				if [[ ${#cardnum} -eq 16 ]] && [[ $(echo $cardnum | grep -E "^[0-9]{1,}$") ]]
				then
					x=1
				else
					echo Invalid input
				fi
			done
			
			y=0
			while [ $y -eq 0 ]
			do
				read -p "Enter card expiration date (DD/YY): " expdate
				if [[ $expdate == [0-3][1-9]/[0-9][0-9] ]]
				then
					y=1
				else
					echo Invalid input
				fi
			done
			
			z=0
			while [ $z -eq 0 ]
			do
				read -s -p "Enter card verification value (CVV): " cvv
				echo
				if [[ ${#cvv} -eq 3 ]] && [[ $(echo $cvv | grep -E "^[0-9]{1,}$") ]]
				then
					rm cart_tmp5.txt
					tput clear
					cowsay -f dragon Thank you for purchasing from us. Have a mystical day! | lolcat
					sleep 3
					
					bash mainMenu.bash
				else
					echo Invalid input
				fi
			done
			;;
		[Cc])
			bash cart.bash
			;;
		[Gg])
			bash mainMenu.bash
			;;
		*)
			echo Invalid input
			;;
	esac
done

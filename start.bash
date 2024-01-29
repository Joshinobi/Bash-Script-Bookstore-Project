#!/bin/bash

#This script is for the homepage
#Joshua C. Gonzales

tput clear

figlet BOOKS R US | lolcat
cowsay -f dragon Welcome to the most mystical bookstore "in" Linux! | lolcat

echo "A.) Login"
echo "B.) Register"
echo "C.) Exit"

n=0
while [ $n -eq 0 ]
do
	read -p "Select an option: " ans
	case $ans in
		[Aa])
			bash login.bash
			;;
		[Bb])
			bash register.bash
			;;
		[Cc])
			clear
			;;
		*)
			echo Invalid input
			;;
	esac
done

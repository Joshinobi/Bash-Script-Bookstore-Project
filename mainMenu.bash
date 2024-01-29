#!/bin/bash

#This script is for the main menu for the ordinary users
#Joshua C. Gonzales

tput clear
figlet Main Menu | lolcat

cat menuOpt.txt | lolcat

echo

n=0
while [ $n -eq 0 ]
do
	read -p "Select an option: " ans
	case $ans in
		[1])
			bash search.bash
			;;
		[2])
			bash highlights.bash
			;;
		[3])
			bash new.bash
			;;
		[4])
			bash cart.bash
			;;
		[5])
			bash profile.bash
			;;
		[6])
			bash about.bash
			;;
		[7])
			bash care.bash
			;;
		[8])
			rm loggeduser.txt cart_tmp1.txt cart_tmp2.txt cart_tmp3.txt cart_tmp4.txt cart_tmp5.txt 2> /dev/null
			bash start.bash
			;;
		*)
			echo Invalid input
			;;
	esac
done

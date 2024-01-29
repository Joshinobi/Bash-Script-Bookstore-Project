#!/bin/bash

#This script is for the new option
#Joshua C. Gonzales

tput clear

figlet New Release! | lolcat

day=$(date +"%d")
dayago=$(($day-7))
date=$(date +"$dayago/%m/%y")

grep $date db1.txt > new1.txt

join -t: -1 1 -2 1 new1.txt db2.txt | cut -d: -f1,2,6 > new2.txt

rm new1.txt

tput setaf 2
echo -e "Item #\t\t" "Item Name\t\t" "Description"
tput sgr0

awk '{print NR ":" $S}' new2.txt | cut -d: -f1,3,4 | sed 's/:/ \t\t/g'

echo
echo "select an item no. to choose an item"
echo "(G) Go back to main menu"

n=0
while [ $n -eq 0 ]
do
	read -p "Enter an option: " i
	case $i in
		[[:digit:]])
			item1=$(cat new2.txt | cut -d: -f2)
			item2=$(cat cart_tmp5.txt | grep $item1)
					
			if [ $item1 == $item2 ]
			then
				echo That is already in your cart!
			else
				cat new2.txt | sed "${i}q;d" >> cart_tmp1.txt
				rm new2.txt
			fi
			bash cart.bash
			;;
		[Gg])
			rm new2.txt
			bash mainMenu.bash
			;;
		*)
			echo Invalid input
			;;
	esac
done

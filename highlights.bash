#!/bin/bash

#This script is for the highlights option
#Joshua C. Gonzales

tput clear

figlet Highlights | lolcat

tput setaf 2
echo Check out our highly acclaimed books
echo and bestsellers for this week!
tput sgr0

n=0
while [ $n -eq 0 ]
do
	read -p "Search: " str1
	if [[ $str1 == "acclaimed" ]] || [[ $str1 == "highly acclaimed" ]]
	then
		grep '0003\|0004\|0008' db1.txt > highlights1.txt
		join -t: -1 1 -2 1 highlights1.txt db2.txt | cut -d: -f1,2,6 > highlights2.txt
		
		rm highlights1.txt
		
		tput setaf 2
		echo -e "Item #\t\t" "Item Name\t\t" "Description"
		tput sgr0
		
		awk '{print NR ":" $S}' highlights2.txt | cut -d: -f1,3,4 | sed 's/:/ \t\t/g'
		n=1
		
	elif [[ $str1 == "bestseller" ]] || [[ $str1 == "bestsellers" ]]
	then
		grep '0001\|0002\|0007\|0009\|0011' db1.txt > highlights1.txt
		join -t: -1 1 -2 1 highlights1.txt db2.txt | cut -d: -f1,2,6 > highlights2.txt
		
		rm highlights1.txt
		
		tput setaf 2
		echo -e "Item #\t\t" "Item Name\t\t" "Description"
		tput sgr0
		
		awk '{print NR ":" $S}' highlights2.txt | cut -d: -f1,3,4 | sed 's/:/ \t\t/g'
		n=1
	else
		echo Sorry, there are no results.
	fi
done

echo
echo "select an item no. to choose an item"
echo "(G) Go back to main menu"

n=0
while [ $n -eq 0 ]
do
	read -p "Enter an option: " i
	case $i in
		[[:digit:]])
			item1=$(cat highlights2.txt | cut -d: -f2)
			item2=$(cat cart_tmp5.txt | grep $item1)
					
			if [ $item1 == $item2 ]
			then
				echo That is already in your cart!
			else
				cat highlights2.txt | sed "${i}q;d" >> cart_tmp1.txt
				rm highlights2.txt
			fi
			bash cart.bash
			;;
		[Gg])
			rm highlights2.txt
			bash mainMenu.bash
			;;
		*)
			echo Invalid input
			;;
	esac
done

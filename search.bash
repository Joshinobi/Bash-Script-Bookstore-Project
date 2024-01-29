#!/bin/bash

#This script is for the search option
#Joshua C. Gonzales

tput clear

cat search_guide.txt | lolcat

function1 () {
	(grep -i -e $string1 -e $string2 -e $string3 -e $string4 || grep -i -e $string1 -e $string2 -e $string3 || grep -i -e $string1 -e $string2 || grep -i $string1) 2> /dev/null
}

n=0
while [ $n -eq 0 ]
do
	read -p "Search: " string1 string2 string3 string4
	if [[ $(cat db1.txt | function1 | cut -d: -f2) ]] 	
	then
		cat db1.txt | function1 | cut -d: -f1,2 > tmp1.txt
		join -t: -1 1 -2 1 tmp1.txt db2.txt > tmp2.txt

		tput setaf 2
		echo -e "Search #\t" "Item Name\t\t" "Description"
		tput sgr0
		
		awk '{print NR ":" $S}' tmp2.txt | cut -d: -f1,3,4 | sed 's/:/ \t\t/g'
		
		echo " "
		echo "Select a search no. to choose an item"
		echo "(G) Go back to main menu"
		
		n=0
		while [ $n -eq 0 ]
		do
			read -p "Enter an option: " i
			
			case $i in
				[[:digit:]])
					item1=$(cat tmp2.txt | cut -d: -f2)
					item2=$(cat cart_tmp5.txt | grep $item1)
					
					if [ $item1 == $item2 ]
					then
						echo That is already in your cart!
					else
						cat tmp2.txt | sed "${i}q;d" >> cart_tmp1.txt
						rm tmp1.txt tmp2.txt
						bash cart.bash
					fi
					;;
				[Gg])
					rm tmp1.txt tmp2.txt #tmp3.txt
					bash mainMenu.bash
					;;
				*)
					echo Invalid input
					;;
			esac
		done

		n=1	
	else
		echo Sorry, the item you are looking for is unavailable.
	fi
done

#!/bin/bash

#This script is for the cart option
#Joshua C. Gonzales

tput clear

figlet Your Cart | lolcat

sort -t: -k2n cart_tmp1.txt >> cart_tmp2.txt 2> /dev/null

join -t: -1 1 -2 1 cart_tmp2.txt db1.txt | cut -d: -f1,2,5,6,7 >> cart_tmp3.txt

join -t: -1 1 -2 1 cart_tmp3.txt db3.txt >> cart_tmp4.txt

rm cart_tmp1.txt cart_tmp2.txt cart_tmp3.txt 2> /dev/null

tput setaf 2
echo -e "Item #\t" "Name\t\t" "Qty\t" "Price\t" "Total"
tput sgr0

cut -d: -f1,2,6,7,8 cart_tmp4.txt >> cart_tmp5.txt

rm cart_tmp4.txt

cut -d: -f2,3,4,5 cart_tmp5.txt | awk '{print NR ":" $S}' | sed 's/:/ \t/g' 2> /dev/null

total=$(cut -d: -f5 cart_tmp5.txt | awk '{sum+=$1} END{printf("%d\n",sum)}')

echo
tput setaf 2
echo "Total Amount: Php $total"
tput sgr0
echo 
echo Select an item number to modify or remove
echo "(C) Check Out"
echo "(G) Go back to Main Menu"

n=0
while [ $n -eq 0 ]
do
	read -p "Enter an option: " i
	name=$(sed "${i}q;d" cart_tmp5.txt | cut -d: -f2)
	#itemnum=$(sed "${i}q;d" cart_tmp5.txt | cut -d: -f1)
	
	case $i in
		[[:digit:]])
			x=0
			while [ $x -eq 0 ]
			do
				echo
				echo "What would you like to do with the item?"
				echo "(M) Modify quantity"
				echo "(R) Remove item"
				read -p "Enter an option: " int
				case $int in
					[Mm])
						cat cart_tmp5.txt | sed "${i}q;d" > modify1.txt #old info
						
						itemid=$(cut -d: -f1 modify1.txt)
						qty=$(grep $itemid db1.txt | cut -d: -f3)
						
						z=0
						while [ $z -eq 0 ]
						do
							echo
							read -p "Enter quantity: " num
							if [ $num -gt $qty ]
							then
								echo Not enough stock
							else
								itemname=$(cut -d: -f2 modify1.txt)
								price=$(cut -d: -f4 modify1.txt)
								newtotal=$(($num * $price))
								
								echo "$itemid:$itemname:$num:$price:$newtotal" > modify2.txt #new info
								
								sed "/$itemid/d" cart_tmp5.txt > cart_tmp6.txt
								cat modify2.txt >> cart_tmp6.txt
								cat cart_tmp6.txt > cart_tmp5.txt
								
								rm modify1.txt modify2.txt cart_tmp6.txt
								
								tput clear
						
								figlet Your Cart | lolcat
						
								tput setaf 2
								echo -e "Item #\t" "Name\t\t" "Qty\t" "Price\t" "Total"
								tput sgr0
						
								cut -d: -f2,3,4,5 cart_tmp5.txt | awk '{print NR ":" $S}' | sed 's/:/ \t/g' 2> /dev/null
								total=$(cut -d: -f5 cart_tmp5.txt | awk '{sum+=$1} END{printf("%d\n",sum)}')
						
								echo
								tput setaf 2
								echo "Total Amount: Php $total"
								tput sgr0
								echo 
								echo Select an item number to modify or remove
								echo "(C) Check Out"
								echo "(G) Go back to Main Menu"
								z=1
								x=1
								
							fi
						done
						;;
					[Rr])
						sed -i "/$name/d" cart_tmp5.txt
						
						tput clear
						
						figlet Your Cart | lolcat
						
						tput setaf 2
						echo -e "Item #\t" "Name\t\t" "Qty\t" "Price\t" "Total"
						tput sgr0
						
						cut -d: -f2,3,4,5 cart_tmp5.txt | awk '{print NR ":" $S}' | sed 's/:/ \t/g' 2> /dev/null
						total=$(cut -d: -f5 cart_tmp5.txt | awk '{sum+=$1} END{printf("%d\n",sum)}')
						
						echo
						tput setaf 2
						echo "Total Amount: Php $total"
						tput sgr0
						echo 
						echo Select an item number to modify or remove
						echo "(C) Check Out"
						echo "(G) Go back to Main Menu"
						x=1
						;;
					*)
						echo Invalid input
						;;
				esac
			done
			;;
		[Cc])
			bash payment.bash
			;;
		[Gg])
			bash mainMenu.bash
			;;
		*)
			echo Invalid input
			;;
	esac
done

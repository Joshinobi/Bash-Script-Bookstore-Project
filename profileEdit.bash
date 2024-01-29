#!/bin/bash

#This script is for the profile editor
#Joshua C. Gonzales

tput clear

figlet Edit Profile | lolcat

xuser=$(cut -d: -f1 loggeduser.txt)
xuid=$(cut -d: -f2 loggeduser.txt)
xpasswd=$(cut -d: -f3 loggeduser.txt | openssl enc -base64 -d -aes-256-cbc -nosalt -pass pass:garbageKey 2> /dev/null)
ypasswd=$(cut -d: -f3 loggeduser.txt)
xname=$(cut -d: -f4 loggeduser.txt)
xdadd=$(cut -d: -f5 loggeduser.txt)
xeadd=$(cut -d: -f6 loggeduser.txt)
xdate=$(cut -d: -f7 loggeduser.txt)

tput setaf 2
echo "Which information would you like to edit?"
tput sgr0

echo "1.) Password"
echo "2.) Full Name"
echo "3.) Delivery Address"
echo "4.) E-mail Address"
echo
echo "A) Return to your profile"

n=0
while [ $n = 0 ]
do
	read -p "Select an option: " var
	case $var in
		1)
			tput clear
			
			figlet Edit Profile | lolcat
			
			i=0
			while [ $i -eq 0 ]
			do
				read -s -p "Enter your old password: " opasswd
				echo
				if [[ $opasswd != $xpasswd ]]
				then
					echo Incorrect password
				else
					x=0
					while [ $x -eq 0 ]
					do
						
						read -s -p "Enter your new password: " npasswd
						echo
						if [[ $npasswd != $xpasswd ]] && [ ${#npasswd} -ge 8 ] && ([[ $npasswd =~ [[:lower:]] ]] && [[ $npasswd =~ [[:upper:]] ]]) && [[ $npasswd =~ [[:digit:]] ]] && [[ $npasswd =~ [[:punct:]] ]] && [[ $npasswd != $xuser ]]
						then
							passwd=$(echo $npasswd | openssl enc -base64 -e -aes-256-cbc -nosalt -pass pass:garbageKey 2> /dev/null)
					
							grep $xuser users.txt | sed "s/$ypasswd/$passwd/g" > tmpUser1.txt 
							cat tmpUser1.txt >> users.txt
							sed "/$ypasswd/d" users.txt > tmpUser2.txt
							cat tmpUser2.txt | sort -t: -k2n > users.txt
							rm tmpUser1.txt tmpUser2.txt
							
							echo "$xuser:$xuid:$passwd:$xname:$xdadd:$xeadd:$xdate" > loggeduser.txt
							echo "Your password has been changed"
							
							sleep 2
							bash profile.bash
						else
							echo Weak Password!
							echo -Must be at least 8 characters
							echo -Must contain at least 1 lower case letter, 
							echo  1 upper case letter, 1 digit, and 
							echo  1 punctuation mark
							echo -Must not be similar with the username
							echo -Must not be similar with the old password
						fi
					done
				fi
			done
			;;
		2)
			tput clear
			
			figlet Edit Profile | lolcat

			i=0
			while [ $i -eq 0 ]
			do
				read -p "Enter your new full name (FN MI SN): " name
				if [[ $name == $(cut -d: -f4 loggeduser.txt) ]]
				then
					echo Invalid! Similar to your old full name.
				else
					grep -w $xuser users.txt | sed "s/$xname/$name/g" > tmpUser1.txt
					cat tmpUser1.txt >> users.txt
					sed "/$xname/d" users.txt > tmpUser2.txt
					cat tmpUser2.txt | sort -t: -k2n > users.txt
					rm tmpUser1.txt tmpUser2.txt
					
					echo "$xuser:$xuid:$xpasswd:$name:$xdadd:$xeadd:$xdate" > loggeduser.txt
					echo "Your full name has been changed"
					sleep 2
					bash profile.bash
				fi
			done
			;;
		3)
			tput clear
			
			figlet Edit Profile | lolcat
			
			i=0
			while [ $i -eq 0 ]
			do
				read -p "Enter your new delivery address: " dadd
				if [[ $dadd == $(cut -d: -f5 loggeduser.txt) ]] #|| [[ $dadd == $(grep $dadd users.txt | cut -d: -f5) ]]
				then
					echo Invalid! Similar to your old delivery address.
				else
					grep -w $xuser users.txt | sed "s/$xdadd/$dadd/g" > tmpUser1.txt
					cat tmpUser1.txt >> users.txt
					sed "/$xdadd/d" users.txt > tmpUser2.txt
					cat tmpUser2.txt | sort -t: -k2n > users.txt
					rm tmpUser1.txt tmpUser2.txt
					
					echo "$xuser:$xuid:$xpasswd:$xname:$dadd:$xeadd:$xdate" > loggeduser.txt
					echo "Your delivery address has been changed"
					sleep 2
					bash profile.bash
				fi
			done
			;;
		4)
			tput clear
			
			figlet Edit Profile | lolcat
			
			i=0
			while [ $i -eq 0 ]
			do
				read -p "Enter your new e-mail address: " eadd
				if [[ $eadd == $(cut -d: -f6 loggeduser.txt) ]] || [[ $eadd != *"@"*".com" ]]
				then
					echo Invalid! Similar to your e-mail address.
				else
					grep -w $xuser users.txt | sed "s/$xeadd/$eadd/g" > tmpUser1.txt
					cat tmpUser1.txt >> users.txt
					sed "/$xeadd/d" users.txt > tmpUser2.txt
					cat tmpUser2.txt | sort -t: -k2n > users.txt
					rm tmpUser1.txt tmpUser2.txt
					
					echo "$xuser:$xuid:$xpasswd:$xname:$xdadd:$eadd:$xdate" > loggeduser.txt
					echo "Your e-mail address has been changed"
					sleep 2
					bash profile.bash
				fi
			done
			;;
		[Aa])
			bash profile.bash
			;;
		*)
			echo Invalid input
			;;
	esac
done

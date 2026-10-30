#!/bin/bash

echo "Computer Information"

if [[ -n "$1"  ]] ; then 
	val=$1
	echo "Using First Argument: $val"	
else
	read -p "Please provide an input number to view the uname options (1-10): " val
	echo "Selected Value $val"
fi

#False = 0
invalid=0

case $val in
	0) echo $(uname -s) ;;
	1) echo $(uname -n) ;;
        2) echo $(uname -r) ;;
        3) echo $(uname -m) ;;
        4) echo $(uname -p) ;;
        5) echo $(uname -i) ;;
        6) echo $(uname -o) ;;
        7) echo $(uname --version) ;;
	*) echo -e "Invalid Input\n" && echo $(uname -a) && invalid=1 ;;
esac


if (( invalid )) ; then
	echo "Exit Code: 1"
	exit 1
else
	echo "Exit Code: 0"
	exit 0
fi

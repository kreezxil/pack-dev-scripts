#!/bin/bash

declare -a pids
declare -a names

build_arrays() {
	IDX=0
	pids=()
	names=()

	for f in $(screen -ls); do 
  		if [[ $f = *"MASTER"* ]]; then 
			IFS="." read -r -a data <<< "$f"
			pids[IDX]="${data[0]}"
			IFS="_" read -r -a name <<< "${data[1]}"
			names[IDX]="${name[0]}"
			((++IDX))
		fi
  	done
}

declare -p

while true; do
	build_arrays

	size=${#pids[@]}

	clear
	printf '\nSCREEN\tPID\tNAME\n'

	for (( i=0; i<${size}; i++ )); do
		printf '%s\t%s\t%s\n' ${i} ${pids[i]}  ${names[i]}
	done

	printf '\nWhich screen # would you like to resume?\nEnter to q to quit or exit\n'
	read n

	if [ $n == 'q' ]; then
		exit
	fi

	if [ $n -lt 0 || $n -gt $size ]; then
		read -p "Invalid Option: Press [Enter] to try again" readEnterkey
		continue
	fi

	screen -r ${pids[$n]}
done

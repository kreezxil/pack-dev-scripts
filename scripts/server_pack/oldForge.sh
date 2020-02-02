#!/bin/bash
if [ "$#" -lt 1 ]; then
  echo "Usage: ./newForge.sh <old forge file> | -g <pattern>"
  exit
fi

source settings.sh
        if [ $# -eq 2 ]; then
                if [ "${1}" == "-g" ]; then
                        #grep mode, generates a menu too!
                        forge=( $( ls --color=auto "forge" | grep "${2}") )
                        forge+=('exit')
                        PS3="Enable which one? "
                        select enableForge in "${forge[@]}"; do
                                [[ $enableForge == exit ]] && exit
                                forge=$enableForge && break
                        done
                fi
        else
                forge="${1}"
        fi
        if [[ $forge = *[!\ ]* ]]; then
                #the value is sane, let's do the copy
                cp "forge/${forge}" "${FORGE}"
        else
                echo "I don't know what you mean!"
        fi



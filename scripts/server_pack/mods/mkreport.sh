#!/bin/bash

#set optional gist create argument
#uncomment the line that applies to you

#Python Gist
#gArg="create"

#Rubygems Gist has no create argument
gArg=""


if [ "${1}" == "-no-log" ]
   then
     echo "Issue: {$2}"
     echo
     gist "../logs/latest.log"
     echo
     exit
fi
report=${1}
report=${report/0\~/}
report=${report/1\~/}
if [ "${2}" == "-l" ]
   then
     less "${report}"
   exit
fi
if [ "${2}" == "-gen" ]
   then

     read -p "What failed? " whatFailed

     whichTier=$(<tier.dat)
     read -p "Which Forge Tier? [${whichTier}] " Tier
     if [ "${Tier}" != "" ]; then
       whichTier="${Tier}"
     fi
     echo "${whichTier}" > tier.dat

     forgeBuild=$(<build.dat)
     read -p "Which Forge Build? [${forgeBuild}] " Build
     if [ "${Build}" != "" ]; then
       forgeBuild="${Build}"
     fi
     echo "${forgeBuild}" > build.dat

     read -p "Optional Information? " optionalInfo

fi

echo
ISSUE="Issue: "
if [ "${2}" == "-gen" ]
  then
    ISSUE="${ISSUE} ${whatFailed} crashes dedicated server Forge ${whichTier} build ${forgeBuild}\n\nNotes:\n     ${optionalInfo}"
else
    ISSUE="${ISSUE} ${2}"
fi
printf "${ISSUE}\n"
echo

   echo "crash report: "
   pastebinit "${report}"
   echo
   echo "fml server latest: "
   pastebinit "../logs/latest.log"




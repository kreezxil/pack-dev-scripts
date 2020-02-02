#!/bin/bash
INCREMENT=0
if [ "$#" -ne 1 ]; then
    if [ -e "dat.version" ]; then
       VERSION=$(<"dat.version")
       INCREMENT=1
    else
	echo "Version file is empty so you'll need to specify a version on the command line"
 	echo "Example: ./versionit.sh 1.2.3"
	exit
    fi
else
    VERSION="${1}"
fi

if [ $INCREMENT -eq 1 ]; then
    IFS='.' read -r -a PARTS <<< "$VERSION"
    echo "Previous version: ${VERSION}"
    PARTS[1]=$((PARTS[1]+1))
    PARTS[2]=$((PARTS[2]+1))
    IFS=$'.'
    VERSION="${PARTS[*]}"
    echo "New version: ${VERSION}"
fi

cat source.properties > server.properties

if [ ! -f "motd.frnt" ]; then
    echo "motd front missing, please type stuff before version number and hit enter"
    read FRONT
    echo "motd=${FRONT}" > motd.frnt
fi

if [ ! -f "motd.rear" ]; then
    echo "motd rear missing, please type stuff to appear after the version and hit enter"
    read REAR
    echo "${REAR}\u00A7r" > motd.rear
fi

echo "$(<motd.frnt)${VERSION}$(<motd.rear)" >> server.properties

echo "${VERSION}" > dat.version

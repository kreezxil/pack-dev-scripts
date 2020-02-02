#!/bin/bash

#read -r -p "Refresh the World? (y/N)" response
#response=${response,,}
#  if [[ $response =~ ^(yes|y)$ ]]; then
#	cd world
#	unzip -o world.zip
#	cd ..
#  else
#    echo "Using old world"
#    echo "please wait ..."
#  fi
source settings.sh
screen -S "${FORGE}" java -Xmx2G -Dfml.doNotBackup=true -Dfml.debugClassPatchManager=true -Dfml.debugRegistryEntries=true -Djava.net.preferIPv4Stack=true -Dfml.queryResult=confirm -jar "${FORGE}" nogui


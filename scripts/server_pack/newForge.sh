#!/bin/bash
if [ "$#" -ne 1 ]; then
  echo "Usage: ./newForge.sh <forge-url>"
  exit
fi
source settings.sh
mkdir -p ./forge
cd ./forge
wget "${1}" 
cd ..
NEWFORGE=$(basename "${1}")
cp -v "./forge/${NEWFORGE}" "${FORGE}"

echo "${1}" > CURRENT_INSTALLER
sed -i 's/universal/installer/g' CURRENT_INSTALLER



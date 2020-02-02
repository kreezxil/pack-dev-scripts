#!/bin/bash

source settings.sh

wget "${INSTALLER}"

FORGE_INSTALLER=$(basename "${INSTALLER}")

java -jar "${FORGE_INSTALLER}" --installServer

rm "${FORGE_INSTALLER}"

mv -v forge*jar "${FORGE}"

echo "Now either do ./start_Linux_Master.sh"
echo
echo "or"
echo
echo "java -jar ${FORGE} nogui [<optional arguments>]"


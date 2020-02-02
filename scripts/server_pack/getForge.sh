#!/bin/bash
source settings.sh

INSTALLER="https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.15.2-31.0.${1}/forge-1.15.2-31.0.${1}-installer.jar"

echo "${INSTALLER}" > CURRENT_INSTALLER

FORGE_INSTALLER=$(basename "${INSTALLER}")

wget "${INSTALLER}"

java -jar "${FORGE_INSTALLER}" --installServer

rm "${FORGE_INSTALLER}"

mv -v forge*jar "${FORGE}"



#!/bin/bash

CONFIGDIR="$HOME/.mc_server"

function youFail {
  echo "Your ${INSTALLDIR} doesn't exists or there are perm issues, please fix and try again"
  exit
}

function isYn {
  if [ ${#1} -gt 1 ]; then
    echo "I only need one character!"
    echo "y or n"
    echo "Exiting ..."
    echo
    exit
  fi
  ISYN=${1}
  CONFIRM=$(echo "${ISYN}" | tr '[:upper:]' '[:lower:]')
  #echo "[${ISYN}] [${CONFIRM}]"
  if [ "${CONFIRM}" == 'y' ] || [ "${CONFIRM}" == 'n' ]; then
    true # do nothing
  else
   echo "Can't follow directions can we?"
   exit
  fi
}

function exitIfNull {
  if [ "${1}" == "" ]; then
    echo "Null response detected."
    echo "Exiting ..."
    echo
    exit
  fi
}

if [ "$(dirname "$0")" != '.' ]; then
  echo "You need to execute this script from the same directory in which it resides."
  echo "Otherwise things can fail hard!"
  exit
fi

echo "Kreezcraft Server Pack Installer/Upgrader"
echo
echo "1. Fresh Install"
echo
echo "2. Server Upgrade"
echo
read -rp "CHOICE: " CHOICE
if [[ $CHOICE -lt 1 || $CHOICE -gt 2 ]]; then
  echo "Invalid Choice!"
  echo "Please choose 1 or 2"
  echo "Exiting ..."
fi

if [[ $CHOICE -eq 1 ]]; then
  CHOICE="FRESH"
else
  CHOICE="UPGRADE"
fi

echo "You have chosen the ${CHOICE} installation method."
read -rp "Do you wish to continue? (y/n) " CONTINUE
isYn "${CONTINUE}"
if [ "${CONFIRM}" == 'n' ]; then
  echo "Dratz! Ok, try again when youa re ready!"
  exit
fi

if [ -d "${CONFIGDIR}" ]; then
  PreviousInstallDir=$(<"${CONFIGDIR}/installdir")
else
  mkdir -p "${CONFIGDIR}"
fi

echo "We will now continue with your ${CHOICE} installation method."
if [ ${CHOICE} == "FRESH" ]; then
  read -rp "What do you want to name the server? " SERVERNAME
  exitIfNull "${SERVERNAME}"

  echo "Sanitizing your SERVER NAME"
  SERVERNAME="${SERVERNAME//[^a-zA-Z0-9]/}"
  echo "Your server name is now [${SERVERNAME}], "
  read -rp "Is this acceptable to you? (y/n)" CONFIRM
  isYn "${CONFIRM}"
  if [ "${CONFIRM}" == 'n' ]; then
   echo "Ok, run the script again and provide something that is acceptable to you."
   exit
  fi

  echo "${SERVERNAME}" > "${CONFIGDIR}/server"

  echo "Where do you want to install the server?"
  echo "example: /home/buddy/ will put the server in /home/buddy/servername/"
  echo "A good place you would likely be /$(whoami)/"
  read -rp ": [${PreviousInstallDir}]" INSTALLDIR

  if [ "${INSTALLDIR}" != "" ]; then
    echo "${INSTALLDIR%/}/${SERVERNAME}" > "${CONFIGDIR}/installdir"
  else
    INSTALLDIR="${PreviousInstallDir}"
  fi

  temp="$(basename ${INSTALLDIR})"
  if [ "${temp}" != "${SERVERNAME}" ]; then
    INSTALLDIR="${INSTALLDIR%/}/${SERVERNAME}"
    # because what was saved previously is right
  fi

  mkdir -p "${INSTALLDIR}"

  if [ -d "${INSTALLDIR}" ]; then
   echo "The directory was created successfully."
  else
   echo "I couldn't create the directory for you, please make sure you have rights to the location and try again."
   exit
  fi


  echo "Now copying everything over ..."
  cp -R . "${INSTALLDIR}"

  source config.sh

  echo "Building your config.sh file"
  cd "${INSTALLDIR}" || youFail
  echo "# Global variables needed by the server scripts" > config.sh
  echo "USER=$(whoami)"
  echo "FORGE=${FORGE}" >> config.sh
  echo "THISPATH=${INSTALLDIR}" >> config.sh

  echo "Fresh install complete."

  echo "Now edit your server.properties file"
  echo "and the start the server with ./gameStart.sh start"
  echo "make sure you do this from the ${INSTALLDIR}/"
else
  echo "Welcome to the ${CHOICE} installation method"
  echo
  echo "What is the full path to your server?"
  echo "For Example: [/home/minebuddies/awesome server/] "

  read -rp ": [${PreviousInstallDir}]" INSTALLDIR

  if [ "${INSTALLDIR}" != "" ]; then
    echo "${INSTALLDIR}" > "${CONFIGDIR}/installdir"
  else
    INSTALLDIR="${PreviousInstallDir}"
  fi


  INSTALLDIR="${INSTALLDIR%/}"
  if [ -d "${INSTALLDIR}" ]; then
    true #it exists, therefore do nothing special
  else
    echo "${INSTALLDIR} doesn't exist!"
    exit
  fi

  read -rp "Copy over the config folder? (y/n) " CONFIRM
  isYn "${CONFIRM}"
  if [ "${CONFIRM}" == 'y' ]; then
   echo "backing up your configs"
   tar czf "${INSTALLDIR}/config.tgz" "${INSTALLDIR}/config/"
   echo "removing your old configs"
   rm -rf "${INSTALLDIR}/config/"
   echo "Copying over the new configs"
   cp -R config/ "${INSTALLDIR}/"
   echo "config copy complete"
  fi

  source config.sh

  echo "copying over the server"
  cp -f "${FORGE}" "${INSTALLDIR}/${FORGE}"

  echo "backing up your libraries just in case"
  tar czf "${INSTALLDIR}/libraries.tgz" "${INSTALLDIR}/libraries"
  echo "removing your libraries"
  rm -rf "${INSTALLDIR}/libraries"
  echo "copying the libraries"
  cp -R libraries "${INSTALLDIR}/"
  echo "library copy complete"

  echo "backing up your mods because it's the right thing to do"
  tar czf "${INSTALLDIR}/mods.tgz" "${INSTALLDIR}/mods"
  echo "removing your old mods"
  rm -rf "${INSTALLDIR}/mods"
  echo "copying over the new mods"
  cp -R mods "${INSTALLDIR}/"
  echo "Upgrade install complete!"
  echo
  echo "Please restart your server and enjoy!"
fi



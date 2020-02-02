#!/bin/bash
source settings.sh
if [[ $(ps aux | grep "${SESSION_NAME}_MASTER" | wc -l) -lt 2 ]]; then
   screen -S "${SESSION_NAME}_MASTER" ./make_sandwich.sh
else
   echo "Master Process already running, try instead"
   echo
   echo "screen -x " . "${SESSION_NAME}_MASTER"
fi


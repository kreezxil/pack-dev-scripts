#!/bin/bash
source settings.sh

#the following if block performs dark magic
#to install forge if it is not installed

if [ ! -e "${FORGE}" ]; then
   wget "${INSTALLER}"
   java -jar "${INSTALLER}" --installServer
   mv *universal.jar "${FORGE}"
fi
 
SERVICE="${FORGE}"
 OPTIONS='nogui'
 USERNAME="${USER}"
 WORLD='world'
 MCPATH="${THISPATH}"
 BACKUPPATH='${MCPATH}/backup/${SERVICE}_19.backup'
 MINHEAP=2G
 MAXHEAP=3G
 MAXPERMSIZE=512M
 THREADSTACK=1M
 HISTORY=1024
 CPU_COUNT=6
 INVOCATION="java -XX:-UseGCOverheadLimit -Dfml.debugClassPatchManager=true -Dfml.debugRegistryEntries=true \
 -XX:+UseConcMarkSweepGC -XX:+CMSIncrementalMode -XX:-UseAdaptiveSizePolicy \
 -Xmn128M -Xms${MINHEAP} -Xmx${MAXHEAP} -Xss${THREADSTACK} -XX:MaxPermSize=${MAXPERMSIZE} \
 -Dfml.doNotBackup=true \
 -Djava.net.preferIPv4Stack=true -Dfml.queryResult=confirm \
 -jar $SERVICE $OPTIONS"

${INVOCATION}

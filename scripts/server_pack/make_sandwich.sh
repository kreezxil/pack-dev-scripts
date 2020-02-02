#!/bin/bash
source settings.sh

#the following if block performs dark magic
#to install forge if it is not installed

if [ ! -e "${FORGE}" ]; then
   wget "${INSTALLER}"
   java -jar "${INSTALLER}" --installServer
   mv *universal.jar "${FORGE}"
fi
 
 OPTIONS='nogui'
 HEAP="${MAXHEAP}"

 INVOCATION="java \
 -Xms${HEAP} -Xmx${HEAP} \
 -Dfml.debugClassPatchManager=true -Dfml.debugRegistryEntries=true \
 -Djava.net.preferIPv4Stack=true \
 -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC -XX:+UseParNewGC \
 -XX:+UseNUMA -XX:+CMSParallelRemarkEnabled -XX:MaxTenuringThreshold=15 \
 -XX:MaxGCPauseMillis=30 -XX:GCPauseIntervalMillis=150 \
 -XX:+UseAdaptiveGCBoundary -XX:-UseGCOverheadLimit -XX:+UseBiasedLocking \
 -XX:SurvivorRatio=8 -XX:TargetSurvivorRatio=90 -XX:MaxTenuringThreshold=15 \
 -Dfml.ignorePatchDiscrepancies=true \
 -Dfml.ignoreInvalidMinecraftCertificates=true -XX:+UseFastAccessorMethods \
 -XX:+UseCompressedOops -XX:+OptimizeStringConcat -XX:+AggressiveOpts \
 -XX:ReservedCodeCacheSize=2048m -XX:+UseCodeCacheFlushing \
 -XX:SoftRefLRUPolicyMSPerMB=10000 -XX:ParallelGCThreads=2 \
 -Dfml.queryResult=confirm -Dfml.doNotBackup=true \
 -jar ${FORGE} $OPTIONS"

while true
do
	screen -S "${SESSION_NAME}_SERVER" ${INVOCATION}
	echo "If you want to completely stop the server restart process now, press Ctrl+C before the time is up!"
	echo "Rebooting in:"
	for i in 5 4 3 2 1
	do
		echo "$i..."
		sleep 1
	done
	echo "Rebooting now!"
done


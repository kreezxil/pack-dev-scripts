#just to set some globals used by the other scripts
USER="$(whoami)"
FORGE="${PWD##*/}.jar"
THISPATH="$(pwd)"
read INSTALLER < CURRENT_INSTALLER

OPTIONS='nogui'
USERNAME="${USER}"
WORLD='world'
MCPATH="${THISPATH}"
SESSION_NAME="$(basename ${THISPATH})"

# The following is used for SCREEN scroll back.
# It is not used in Windows
HISTORY=1024

# HEAP is JAVA saying MEMORY or RAM 
# valid values are a number followed by
# a letter. M = megabyte, G = gigabyte
# it is recommend to keep both values equal
# to help minimize garbage collection thrashing

MINHEAP=8G
MAXHEAP=8G


# Adjust the following based on your machine's
# capability
MAXPERMSIZE=256M
THREADSTACK=512M

# the one setting if you specify more cores or
# threads than you have it will simply use all
# of your cores/threads.
CPU_COUNT=4




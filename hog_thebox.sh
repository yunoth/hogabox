#!/bin/bash
#
# Script to hog system resources RAM, DISK and CPU
#

#
# Eating up Memory
#
# Identify the mem size in kb
MEM_SIZE=`grep MemTotal /proc/meminfo | awk '{print $2}'`

# Create tempfs folder in User Home
TMP_MOUNT=~/ramdisk
mkdir -p $TMP_MOUNT

# Mount the temp filesystem and fill it
mount -t tmpfs -o size=${MEM_SIZE}K tempfs $TMP_MOUNT
cat /dev/zero >> $TMP_MOUNT/bigfile

#
# Eating up Disk space
#
# Filling /tmp will bring the system to a grinding halt
#
dd of=/tmp/largefile bs=1G count=1000

## To Spike CPU
## endless loops, each loop is repeating the null instruction (:) on each core
for i in $(seq 1 $(nproc --all)); do while : ; do : ; done & done
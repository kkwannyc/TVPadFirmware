#!/bin/sh

#################
# LABEL version #
#################

U_ACTION=$1
U_NAME=$2

U_CMD=
U_LABEL=
U_PATH=


#
# if remove then umount
#
if [ "${U_ACTION}" = "remove" ]; then
	U_LABEL=`cat /proc/mounts | grep ${U_NAME} | awk '{print $2}'`
	U_LABEL=`expr "${U_LABEL}" : '.....\(.*\)'`
	U_CMD=/bin/umount
	$U_CMD /mnt/${U_LABEL}
	/bin/rmdir /mnt/${U_LABEL}
else

#
# else if add then detect device
#
U_PATH=`find /sys/block -name ${U_NAME}`

### if OTG
cat ${U_PATH}/uevent | grep -q 'otg'
if [ "$?" = "0" ]; then
	U_LABEL=OTG
else

### else if OHCI
cat ${U_PATH}/uevent | grep -q 'ohci'
if [ "$?" = "0" ]; then
	U_LABEL=OHCI
else

### else if MMC
cat ${U_PATH}/uevent | grep -q 'mmc'
if [ "$?" = "0" ]; then
	U_LABEL=SD
else

### else if SATA
cat ${U_PATH}/uevent | grep -q 'sata'
if [ "$?" = "0" ]; then
	U_LABEL=SATA
else

### else if IDE
cat ${U_PATH}/uevent | grep -q 'ide'
if [ "$?" = "0" ]; then
	U_LABEL=IDE

fi	### end if IDE
fi	### end if SATA
fi	### end if SD 
fi	### end if OHCI
fi	### end if OTG


#
# mount
#
#/bin/mkdir /mnt/${U_LABEL}

### get U_CMD
#	blkid /dev/${U_NAME} | grep -q 'TYPE=\"ntfs\"'
#if [ "$?" = "0" ]; then
#	U_CMD="/bin/mount -t ufsd -o force,noatime"
#else
#	U_CMD=/bin/mount
#fi
#	${U_CMD} /dev/${U_NAME} /mnt/${U_LABEL}

#fi	### end if remove



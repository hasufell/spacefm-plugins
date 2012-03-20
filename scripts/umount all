#!/bin/bash
$fm_import

# set your bustype here ('system' or 'session')
BUSTYPE="system"

# umount  images
for i in `cdemu -b $BUSTYPE device-mapping | tail -n +3 | awk '{print $2}'` ; do
	if [[ -n "`mount | grep "$i"`" ]] ; then
		umount $i || exit
	fi
done

sleep 1

# unload cdemu-devices
cdemu -b $BUSTYPE unload all

exit $?

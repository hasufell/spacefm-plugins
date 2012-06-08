#!/bin/bash
$fm_import

cdemurc=~/.config/spacefm/.cdemurc 
if [[ ! -f $cdemurc ]] ; then
	echo "No cdemurc file. Will be created first time you run 'mount'."
	exit 1
else
	. $cdemurc 
fi

# umount  images
for i in `cdemu -b $BUSTYPE device-mapping | tail -n +3 | awk '{print $2}'` ; do
	if [[ -n "`mount | grep "$i"`" ]] ; then
		umount $i || exit 1
	fi
done

sleep 1

# unload cdemu-devices
cdemu -b $BUSTYPE unload all

exit $?
#!/bin/bash
$fm_import

cdemurc=~/.config/spacefm/.cdemurc 
if [[ ! -f $cdemurc ]] ; then
	echo "No cdemurc file. Will be created first time you run 'mount'."
	exit 1
else
	. $cdemurc 
fi

# umount  image
unset i
i=`cdemu -b $BUSTYPE device-mapping | sed -n '4p' | awk '{print $2}'`
umount $i || exit 1

sleep 1

# unload cdemu-devices
cdemu -b $BUSTYPE unload 1

exit $?
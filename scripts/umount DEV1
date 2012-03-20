#!/bin/bash
$fm_import

# set your bustype here ('system' or 'session')
BUSTYPE="system"

# umount  image
unset i
i=`cdemu -b $BUSTYPE device-mapping | sed -n '4p' | awk '{print $2}'`
umount $i || exit

sleep 1

# unload cdemu-devices
cdemu -b $BUSTYPE unload 1

exit $?

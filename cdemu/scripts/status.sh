#!/bin/bash
$fm_import

cdemurc=~/.config/spacefm/.cdemurc
if [[ ! -f $cdemurc ]] ; then
	echo "No cdemurc file. Will be created first time you run 'mount'."
	exit 1
else
	. $cdemurc 
fi

cdemu -b $BUSTYPE status

exit $?

#!/bin/bash
$fm_import

cdemurc=~/.config/spacefm/.cdemurc
if [[ ! -f $cdemurc ]] ; then
	echo "No cdemurc file. Will be created first time you run 'mount'."
	exit
else
	. $cdemurc 
fi

if [[ -n `which xterm` ]] ; then
	xterm -hold -e "cdemu -b $BUSTYPE status"
else
	echo "need xterm"
fi

exit $?

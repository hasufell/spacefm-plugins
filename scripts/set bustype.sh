#!/bin/bash
$fm_import

cdemurc=~/.config/spacefm/.cdemurc
if [[ ! -f $cdemurc ]] ; then
	echo "No cdemurc file. Will be created first time you run 'mount'."
	exit
else
	. $cdemurc 
fi

sed_die() {
	echo "sed failed"
	exit
}		

set_bustype() {
sed -i -e \
	"s/^BUSTYPE.*/BUSTYPE=\"$BUSTYPE\"/" \
	$cdemurc || sed_die
}

current_BUS=$(grep BUSTYPE\= $cdemurc | sed 's/BUSTYPE\=//;s/\"//g')

if [[ -n "`which zenity`" ]] ; then
	zenity --question --ok-label "system" --cancel-label "session" \
		--text="Set D-BUS type to use (current: ${current_BUS})" \
		--title="cdemu Bus-type" \
		&& BUSTYPE="system" set_bustype \
		|| BUSTYPE="session" set_bustype

elif [[ -n "`which Xdialog`" ]] ; then
	Xdialog --title "cdemu Bus-type" --ok-label "system" --cancel-label \
		"session" --yesno "Set D-BUS type to use \
		(current: ${current_BUS})" 5 50 \
		&& BUSTYPE="system" set_bustype \
		|| BUSTYPE="session" set_bustype
else
	echo "You need either zenity or Xdialog"
fi

exit $?

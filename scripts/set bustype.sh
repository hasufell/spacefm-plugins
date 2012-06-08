#!/bin/bash
$fm_import

cdemurc=~/.config/spacefm/.cdemurc
if [[ ! -f $cdemurc ]] ; then
	echo "No cdemurc file. Will be created first time you run 'mount'."
	exit 1
else
	. $cdemurc 
fi

die() {
	echo "$@"
	exit 1
}		

set_bustype() {
sed -i -e \
	"s/^BUSTYPE.*/BUSTYPE=\"$BUSTYPE\"/" \
	$cdemurc || die "sed failed"
}

current_BUS=$(grep BUSTYPE\= $cdemurc | sed 's/BUSTYPE\=//;s/\"//g')

echo "Set D-BUS type to use (current: ${current_BUS})"
echo "0 or system"
echo "1 or session"
read _bustype

[[ ${_bustype} == 0 || ${_bustype} == system ]] && BUSTYPE=system set_bustype
[[ ${_bustype} == 1 || ${_bustype} == session ]] && BUSTYPE=session set_bustype

exit $?

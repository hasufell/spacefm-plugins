#!/bin/bash
$fm_import

if [[ ! -f ~/.config/spacefm/.cdemurc ]] ; then
	mkdir -p "$fm_cmd_data"
	echo "#D-BUS type for cdemu" > ~/.config/spacefm/.cdemurc 
	echo 'BUSTYPE="system"' >> ~/.config/spacefm/.cdemurc 
	echo "cdemurc file created, default D-BUS type set to 'system'"
	echo "you are now ready to mount images"
	exit
fi

. ~/.config/spacefm/.cdemurc 

# Seperate the filename and extension
EXT=`echo $fm_filename | sed -e 's/.*\.//'`
EXT_LOW=`echo $EXT | tr 'A-Z' 'a-z'`

# mount function
mount() {
	# Find a free CDemu device to mount
	DEV=$((`cdemu -b $BUSTYPE status | cut -f 6 -d " " | grep 0 -n -m 1 | cut -c 1`-3))
	if [[ $DEV -lt "0" ]]; then
		echo "You have reached the maximum number of virtual devices."
		exit
	fi
	
	# Finally, load the image
	cdemu -b $BUSTYPE load $DEV "$fm_filename" || echo "failed mounting the image"
}

# Check if the file is a supported image file
case $EXT_LOW in
	b5t|b6t|bin|c2d|ccd|cdi|cif|cue|daa|img|iso|mds|nrg|sub|toc|udf)
		mount ;;
	*)
		echo ".$EXT_LOW is not a supported image format" ;;
esac

exit $?
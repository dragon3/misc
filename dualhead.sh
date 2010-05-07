#!/bin/sh
# $Id: dualhead.sh 1074 2009-01-20 11:52:56Z dragon3 $

start() {
	xrandr --output VGA --auto --${TARGET}-of LVDS
}

stop() {
	xrandr --output VGA --off
}

usage() {
	echo "Usage: dualhead.sh {start|stop} {left|right}"
	exit 1;
}

if [ $# -eq 0 ]; then
	usage;
elif [ $1 = 'start' -a $# -eq 2 ]; then
	if [ $2 != 'left' -a $2 != 'right' ]; then
		usage;
	fi
fi

TARGET=${2-"left"};

case $1 in
	start)
		start;
		;;
	stop)
	    stop;
		;;
	*)
		usage;
		;;
esac

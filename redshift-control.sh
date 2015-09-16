#! /bin/bash

#redshift-control: a bash script to control redshift using hotkeys.

#    Copyright Adam Niederer 2014-2015. Licensed under GPLv3.

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

if [ ! -d ~/.config/redshift/ ]; then
	mkdir ~/.config/redshift
fi

if [ -z $(cat ~/.config/redshift/brightness) ]; then
	echo 10 > ~/.config/redshift/brightness
fi

if [ -z $(cat ~/.config/redshift/temperature) ]; then
	echo 6500 > ~/.config/redshift/temperature
fi

REDSHIFT_BRIGHTNESS=$(cat ~/.config/redshift/brightness)
REDSHIFT_TEMPERATURE=$(cat ~/.config/redshift/temperature)

if [ $1 -eq 1 ]; then #Brightness down
	if [ $REDSHIFT_BRIGHTNESS -gt 1 ]; then
		REDSHIFT_BRIGHTNESS=$(($REDSHIFT_BRIGHTNESS - 1))
	fi
fi

if [ $1 -eq 2 ]; then #Brightness up
        if [ $REDSHIFT_BRIGHTNESS -lt 10 ]; then
                REDSHIFT_BRIGHTNESS=$(($REDSHIFT_BRIGHTNESS + 1))
     	fi
fi

if [ $1 -eq 0 ]; then #Reset everything
	REDSHIFT_BRIGHTNESS=10
	REDSHIFT_TEMPERATURE=6500
	redshift -x
fi

if [ $1 -eq -1 ]; then #Lower Temperature
	if [ $REDSHIFT_TEMPERATURE -gt 1000 ]; then
		REDSHIFT_TEMPERATURE=$(($REDSHIFT_TEMPERATURE - 500))
	fi
fi

if [ $1 -eq -2 ]; then #Raise Temperature
        if [ $REDSHIFT_TEMPERATURE -lt 6500 ]; then
                REDSHIFT_TEMPERATURE=$(($REDSHIFT_TEMPERATURE + 500))
        fi
fi

if [ $REDSHIFT_BRIGHTNESS -eq 10 ]; then
	redshift -O $REDSHIFT_TEMPERATURE -b 1.0
else
        redshift -O $REDSHIFT_TEMPERATURE -b "0."$REDSHIFT_BRIGHTNESS
fi

echo "Redshift set to" $REDSHIFT_BRIGHTNESS "and" $REDSHIFT_TEMPERATURE

echo $REDSHIFT_BRIGHTNESS > ~/.config/redshift/brightness
echo $REDSHIFT_TEMPERATURE > ~/.config/redshift/temperature

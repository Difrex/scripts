#!/bin/bash

# Get current desktop
CURRENT_DESKTOP=`wmctrl -d | grep \* | awk '{print $1}'`

temp_wmctrl=`mktemp wmctrl.XXXXXX`
wmctrl -l -G | awk "{if ( \$2 == $CURRENT_DESKTOP ) { print \$1, \$5, \$6; }; }" > $temp_wmctrl

# Cascade windows!
point_x=250
point_y=50
while read w_id X Y; do
    wmctrl -i -r $w_id -e 0,$point_x,$point_y,$X,$Y
    point_x=$(( $point_x - 35 ))
    point_y=$(( $point_y + 35 ))
done < $temp_wmctrl

rm -f $temp_wmctrl

# TODO 1: calculate resolution and point step
# TODO 2: group windows

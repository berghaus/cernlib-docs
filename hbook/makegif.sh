#!/bin/sh
# makegif.sh   Transform a set of (e)ps files into gif
# Author:      M.Goossens / CN
# Last mod:    June 26th 1993

Name=`basename $0`
Usage="Usage: $Name files"

if [ $# -lt 1 ]; then          # too few parameters
     echo $Usage >&2           # display error message
     exit 1                    # abort
fi

for i in $*
   do 
#       Use sed to get part before dot in filename.
#       If no dot is present then sed prints the line unchanged
      name=`echo $i | sed -e "/\./s/\..*//"`
      echo "making $name.gif from $i"
      gs -q -sDEVICE=ppm -sOutputFile=a.ppm $i
      ppmtogif a.ppm > $name.gif
      rm a.ppm
   done


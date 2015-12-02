#!/bin/sh
# makecatalog.sh
#  Make the catalog file for GEANT
#  This uses the include files in the geantall.tex file
# parameters  none
# Author:     M.Goossens / CN
# Last mod:   March 25th 1994

Name=`basename $0`
Usage="Usage: $Name"

for i in $*
   do 
#       Use sed to get part before dot in filename.
#       If no dot is present then sed prints the line unchanged
grep include geantall.tex | sed -e 's/.include.//' -e 's/\}//' > LLL
      name=`echo $i | sed -e "/\./s/\..*//"`
      name=`basename $name`
      echo "making mini eps from $i to $name.EPS"
      echo "%!" > $name.EPS
      grep "%%BoundingBox" $i >> $name.EPS
   done

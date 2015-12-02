#!/bin/sh
PATH=.:$HOME/bin:/usr/bin
export PATH
case $# in
  0) echo " Utility to put 2 pages on one with PostScript"
     echo ""
     echo " Usage:  twoperpage.sh  filename"
     echo ""
     exit;;
esac
Name=`basename $1`
#       Use sed to get part following dot in filename.
#       If no dot is present then sed prints the line unchanged
      ext=`echo $Name | sed -e "/\./s/.*\.//"`
#       Use sed to get part preceding dot in filename.
      name=`echo $Name | sed -e "/\./s/\..*//"`
      echo "making ${name}2.$ext"

pstops '2:0@0.7L(20.3cm,0.5cm)+1@0.7L(20.3cm,14.15cm)' $1 ${name}2.$ext
exit


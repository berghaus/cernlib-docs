#!/bin/sh
for i in $*
do
  ci -l $i <<!
Initial Entry
.
!
done
exit

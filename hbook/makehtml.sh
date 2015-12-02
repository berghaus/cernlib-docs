#!/bin/sh
# makehtml.sh 
#    Run latex2html on a file to generate HTML tree
#
# parameter   Input file
# Author:     M.Goossens / IT-ASD
# Last mod:   June 25 1998

Name=`basename $0`
Usage="Usage: $Name latex-fn target-dir"

if [ $# -le 1 ]; then          # Not 1 parameter
     echo $Usage >&2           # display error message
     exit 1                    # abort
fi

DIR=/afs/cern.ch/project/cndoc/wwwasd/writeups/$2
L2H=/afs/.cern.ch/asis/src/TeX/archive/latex2html

echo "command to be executed is: "
echo "$L2H/latex2html -long_titles 3 -no_math -html_version 3.2,math -dir $DIR $1"

$L2H/latex2html -long_titles 3 -no_math -html_version 3.2,math -init_file www.perl -dir $DIR $1










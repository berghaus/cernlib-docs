#!/bin/sh
# runl2h.sh  Run short writeup files through latex2html
# Michel Goossens / CN-ASD  19 Jun 1997

Name=`basename $0`
Usage="Usage: $Name files"

if [ $# -lt 1 ]; then          # too few parameters
     echo $Usage >&2           # display error message
     exit 1                    # abort
fi

for i in $*
    do 
#       Use sed to get part preceding dot in filename.
        name=`basename $i | sed -e "/\./s/\..*//"`    # get the basename
	echo " ***** Treating $name.tex ******"       # print what we are doing
        cp L2H1.tex top.tex
        cat $name.tex L2H2.tex >> top.tex             # source file
        Fname=$name 
        rm -rf $Fname                                 # delete old directory
        echo "L2HNEW = " $L2HNEW
        $L2HNEW/latex2html -no_math -html_version 3.2,math -debug \
                           -init_file `pwd`/www.perl -dir $Fname top 
    done

#!/bin/sh
# runall.sh  Run all files given through LaTeX, then make 
# the .ps file
# Michel Goossens / CN-ASD  1 Nov 1994

Name=`basename $0`
Usage="Usage: $Name files"

if [ $# -lt 1 ]; then          # too few parameters
     echo $Usage >&2           # display error message
     exit 1                    # abort
fi

echo "<PRE>" >PRE
echo "</PRE>" >EPRE

for i in $*
    do 
#       Use sed to get part preceding dot in filename.
        name=`basename $i | sed -e "/\./s/\..*//"`    # get the basename
	echo " ***** Treating $name.tex ******"       # print what we are doing
	sed -e "s/XXXX/$name/" ONEONLYS.tex > JUNK.tex # run correct file
        cp PRE b.b
        latex2e JUNK.tex                                # run LaTeX
        dvi2tty -w132 JUNK.dvi >> b.b                 # get the ps file
        cat EPRE >> b.b
        sed '//d' < b.b > c.c
        mv -f c.c html/$name.html
   done
#rm JUNK.*                                             # clean up	

exit


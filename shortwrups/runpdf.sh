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

for i in $*
    do 
#       Use sed to get part preceding dot in filename.
        name=`basename $i | sed -e "/\./s/\..*//"`    # get the basename
	echo " ***** Treating $name.tex ******"       # print what we are doing
	sed -e "s/XXXX/$name/" pdfa-template.tex > JUNK.tex # run correct file
        pdflatex -interaction=nonstopmode  JUNK.tex   # run LaTeX
        mv -f JUNK.pdf ../PDF/shortwrups.dir/${name}.pdf 
   done
rm JUNK.*                                             # clean up	

exit

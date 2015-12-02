#!/bin/sh
# runl2h.sh  Run short writeup files through latex2html
# Michel Goossens / CN-ASD  19 Jun 1997

Name=`basename $0`
Usage="Usage: $Name files"
TOUT="/afs/cern.ch/project/writeups/Short"    # target directory
TIN="/afs/.cern.ch/project/cnas_doc/sources/shortwrups" # source directory

if [ $# -lt 1 ]; then          # too few parameters
     echo $Usage >&2           # display error message
     exit 1                    # abort
fi

for i in $*
    do 
#       Use sed to get part preceding dot in filename.
        cd $TIN
        name=`basename $i | sed -e "/\./s/\..*//"`    # get the basename
	echo " ***** Treating $name.tex ******"       # print what we are doing
        cp L2H1.tex top.tex
        cat $name.tex L2H2.tex >> top.tex             # source file
        Fname=$TOUT/$name                             # Full target name
        rm -rf $Fname                                 # delete old directory
        echo "L2HNEW = " $L2HNEW
        $L2HNEW/latex2html -no_math -html_version 3.2,math -debug \
                           -init_file `pwd`/www.perl -dir $Fname top 
        cd $Fname                                     # go to target directory
        sed -e "/<!-- KEY VALUE/s/XYXY/`cat keys`/" < top.html > a
        cp a top.html  
	rm -f a .[IO]?* *.ps *.pl TMP*  *.css images.*
    done
cd $TIN
rm top.*                                              # clean up	

exit
# number of routines ao May 16th 1996 in each category.
b :   6
c :  49
d :  29
e :  18
f :  19
g :  11
h :   2
i :   3
j :   3
l :   2
m :  31
n :   6
q :  12
t :   1
u :   5
v :  26
w :   4
y :   3
z :  21
    ---
    251


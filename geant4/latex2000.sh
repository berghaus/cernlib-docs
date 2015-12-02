#!/bin/sh 
# latex2000.sh  Run latest version (TL5) of LaTeX.
#               Can use em fonts.
# Author:       M.Goossens / IT
# Last mod:     16 May 2000
Name=`basename $0`
Usage="Usage: $Name filename"

if [ "$#" -lt 1 ]; then        # no parameters specified
     echo ""
     echo " Run LaTeX 2000 (TL5)"   
     echo ""
     echo '    type "latex2000.sh filename"'
     echo ""
     exit 1                    # abort
fi

# assumes tl5 is mounted
# mount -t iso9660 -o ro,loop /opt/texlive/Images/texlive.iso /mnt/texlive
PATH=/mnt/texlive/bin/i386-linux:$PATH
export PATH
TEXINPUTS=.:/afs/.cern.ch/asis/packages/TeXlive/update-2000.02/share/usr.local/share/texmf-updates/tex/xmltex//:/afs/cern.ch/project/tex/texcern/em//:
#TEXINPUTS=.:/opt/texlive/texmf-var//:
export TEXINPUTS
TEXFONTS=.:/usr/local/share/texmf-cern/fonts//:/afs/cern.ch/project/tex/texcern/em/fonts//:
export TEXFONTS
TEXPSHEADERS=.:/afs/cern.ch/project/tex/texcern/em/fonts/type1/bh/em/:
export TEXPSHEADERS
TEXCONFIG=.:/afs/cern.ch/project/tex/texcern/em/dvips//:
export TEXCONFIG
hugelatex $1
exit
#latex \&$ROOT/web2c/latex $1

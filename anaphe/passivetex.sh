#!/bin/sh 
# passivetex.sh  Run latest version of LaTeX
# Author:        M.Goossens / IT
# Last mod:      Nov. 3rd 2000
Name=`basename $0`
Usage="Usage: $Name filename"

if [ "$#" -lt 1 ]; then        # no parameters specified
     echo ""
     echo " Run passivetex "   
     echo ""
     echo '    type "passivetex.sh filename"'
     echo ""
     exit 1                    # abort
fi

export PATH=/afs/cern.ch/sw/XML/cdrom/bin/i386:$PATH
xt.sh $1 foplus.xsl > fotex.xml

hugelatex fotex

exit

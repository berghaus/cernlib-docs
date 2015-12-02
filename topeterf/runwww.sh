#!/bin/sh
# Script to prepare HTML files for WWW
# 1) split source file into separate files
# 2) translate AAP tags to generate anchors
# 4) extract keywords for xfind
#
# parameter   Input file
# Author:     M.Goossens / CN-AS
# Last mod:   June 15 1993

Name=`basename $0`
Usage="Usage: $Name"

if [ $# -ne 0 ]; then          # Not 1 parameter
     echo $Usage >&2           # display error message
     exit 1                    # abort
fi

makewww.sh q.q hbook

rcp HBOOKMAIN.html H*.html asis01:/asis/share/cern/doc/www.dir/hbook
rcp HBOOKINDEX.*        asis01:/asis/share/cern/doc/www.dir/INDEX










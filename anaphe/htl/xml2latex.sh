#!/bin/sh
# makelatex.sh Generate latex from xml and xsl 
# Author:     M.Goossens / IT
# Last mod:   Jan 24 1999

DIR=/afs/cern.ch/project/tex/java
CLASSPATH=$DIR/xtnew/xt.jar:$DIR/xp.jar:$DIR/xtnew/sax.jar:$CLASSPATH
export CLASSPATH
java com.jclark.xsl.sax.Driver htl.xml minilatex.xsl \
                | sed  -e 's/&gt;/>/g'\
                      -e 's/&lt;/</g'\
                      -e 's/!PERCENT!/\\%/g'\
                      -e 's/&amp;/\&/g' > htlbody.tex
echo " "
echo " Now please run LaTeX on htlmain.tex, run dvips and copy "
echo " htlmain.ps to /afs/.cern.ch/project/cndoc/wwwasd/lhc++/PS/htl.ps"
echo " "

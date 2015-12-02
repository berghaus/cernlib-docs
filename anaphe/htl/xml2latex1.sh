#!/bin/sh
# makelatex.sh Generate latex from xml and xsl 
# Author:     M.Goossens / IT
# Last mod:   Jan 24 1999

DIR=/afs/cern.ch/project/tex/java
CLASSPATH=$DIR/xt.jar:$DIR/xp.jar:$DIR/sax.jar:$CLASSPATH
export CLASSPATH
lotusxsl.sh htl.xml minilatex.xsl a.tex 
                sed  -e 's/&gt;/>/g'\
                      -e 's/&lt;/</g'\
                      -e 's/!PERCENT!/\\%/g'\
                      -e 's/&amp;/\&/g' < a.tex > htlbody1.tex

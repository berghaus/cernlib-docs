#!/bin/sh
# 	$Id: dbxhtml.sh,v 1.1 2000/04/19 15:17:55 goossens Exp $
# Script to prepare HTML files from XML file 
# 1) split source file into separate files
#
# parameter   Input file
# Author:     M.Goossens IT/API
# Last mod:   19 July 2000

Name=`basename $0`
Usage="Usage: $Name source-filename"

xtxsl $1.xml dbxhtmlchunk.xsl 
mv index.html $1.html

exit












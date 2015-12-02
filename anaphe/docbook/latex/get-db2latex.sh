#!/bin/sh
#
# (c) 2001, Ramon Casellas <casellas@aist.enst.fr>
# Obtaining a CVS snapshot
#
#
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA.
#
# The author takes no responsibility for
# the consequences of running this script.

VERSION=1.0
DATE="2001/05/01"

version () {
    echo "get-db2latex: $VERSION ($DATE)"
}

echo "###############################################################"
version
echo "###############################################################"
echo This script installs the latest DB2LaTeX XSL stylesheets 
echo by checking out the cvs repository.
echo
echo DB2LaTeX ships with no warranty whatsoever, and released
echo under the GNU license.
echo See http://db2latex.sourceforge.net for details.
echo
echo Please send any questions to rcasellas@users.sourceforge.net 
echo
echo To install, hit ENTER.
echo To cancel, hit Control-C.
echo When prompted for the anonymous cvs passwd, just press enter.
echo "###############################################################"

read foo < /dev/tty

cvs -z3 -d:pserver:anonymous@cvs.db2latex.sourceforge.net:/cvsroot/db2latex login  
cvs -z3 -d:pserver:anonymous@cvs.db2latex.sourceforge.net:/cvsroot/db2latex co docbook/latex
cvs -z3 -d:pserver:anonymous@cvs.db2latex.sourceforge.net:/cvsroot/db2latex logout 


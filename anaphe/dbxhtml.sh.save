#!/bin/sh
# 	$Id: dbxhtml.sh,v 1.1 2000/04/19 15:17:55 goossens Exp $
# Script to prepare HTML files from XML file (LHC++ manual)
# 1) split source file into separate files
#
# parameter   Input file
# Author:     M.Goossens IT/API
# Last mod:   April 18 2000

Name=`basename $0`
Usage="Usage: $Name "

xtxsl htldb.xml /usr/local/share/docbookxsl/3.1/html/docbook.xsl a.html
tidy -asxml a.html > a.xml
xtxsl a.xml addcomment.xsl aa.html

sed -e 's/!PERCENT!/%/g' < aa.html > htlbody.html
#rm aa.html

# Cut files into various other files based on comments of the
# form <!--filename=FILENAME--> and output labels to file "/tmp/ttt"
# to get later cross-references correct.

if (test -f temp.tmp)
  then
    rm temp.tmp
  fi    

gawk ' BEGIN	{ nout = 0
                }	
$0 ~  /<!--filename=/ { gsub("-->","")               # new file name
		       print $0
                       split($0,a,"=") 
		       filename=a["2"]
                       print filename
                       next 
                      }
$0 ~  /<a.*name=/    {str=$0
                      print "*** str ORIG  **** " str 
			while (match(str,"<a.*name=.*>")){
                          print "*** str **** " str   
                          sstr = substr(str,RSTART,RLENGTH)
                          ii   = index(sstr,"\">")
                          if ( ii == 0 ) ii   = index(sstr,"\"/>")
			  sstr = substr(sstr,1,ii-1)
			  print "**** sstr RSTART RLENGTH ii ***** " sstr " " RSTART " " RLENGTH " " ii
			  sub ("<a.*name=\"","",sstr)
			  label=sstr
                          str=substr(str,RSTART+ii)
                          if ( nout == 0 ) 
                            print label " " filename ".html#" label > "temp.tmp"
 		          else
			    print label " " filename ".html#" label >> "temp.tmp"
		          nout = 1
                            print " ****** label filename ****** " label " " filename "#" label 
                       } 
                          next
                       }'   htlbody.html

echo '********************************************************'

#rm htlmaster.html

cat HTLBEGIN.HTML > htlmaster.html

# First make an associative array out of labels in temp.tmp
# then cut files accorging to filename comments and correct
# cross-references thanks to temp.tmp information in ass. array.
# A main file htlmaster.html will contain top level pointers
# to the various chapters. 

gawk ' BEGIN	{ while (getline < "temp.tmp" > 0 ) 
 		  { ref[$1] = $2 }
		  nout = 0
                  masterfile="htlmaster.html"
                  outfile=masterfile
                  headtext="<!DOCTYPE HTML PUBLIC  \"-//W3C//DTD HTML 4.0//EN\">\n\
<HTML>\n\
<HEAD>\n\
<TITLE>Histogram Template Library</TITLE>\n\
<STYLE TYPE=\"text/css\">\n\
body       { background: white; color: black}\n\
P.CENTERP  { text-align: center}\n\
pre.programlisting { background: #FFFF88; color: black; white-space: pre}\n\
TD.LISTING { background: #88FFFF; color: black; white-space: pre}\n\
TD.LPROUT  { background: #FFBBFF; color: black; white-space: pre}\n\
tt         { color: red }\n\
</STYLE>\n\
<!-- Changed by: Michel Goossens, " strftime("%d-%b-%Y") " -->\n\
</HEAD>\n\
<BODY>\n"
                }

       END      { print "</BODY>\n</HTML>\n" >> outfile
                  close(masterfile)
                }

$0 ~ /<!DOCTYPE/ { # DOCTYPE --> skip
                  next
                } 

$0 ~  /<!--filename=/ { gsub("-->","")              # new file name
                       split($0,a,"=") 
		       filename=a["2"] ".html"
                       outfile  = filename 
		       nout += 1
                       
                       print headtext>filename
                       next 
                     }

$0 ~  /<!--==endfilename==/ { next
                       if (nout != 0) { print "</BODY>\n</HTML>\n" >> outfile
                                        close(outfile)
                                      }
                       outfile  = masterfile
                     }
                       
$0 ~  /<a href=\"#/  { str=$0		# Substitute the references
			while (match (str,"<a href.*\">"))
                        { sstr = substr(str,RSTART,RLENGTH)
#print $0 "\n 1 str " str  "\n sstr " sstr "\n\n"
			  ii = index(sstr,"\">")
			  sstr = substr(sstr,1,ii-1)
			  sub ("<a.*#","",sstr)
			  label=sstr
                          str=substr(str,RSTART+ii)
#print $0 "\n 2 str " str "\n ii " ii "\n sstr " sstr "\n ref[label] " ref[label] "\n\n"
			  if (ref[label] !="")
				{ sub ("#"label,ref[label])
#                                   print "\$0 " $0 "\n"
				}
			  else
				{ print "?? file " outfile "Unresolved cross-reference ***** " label
				  print $0
				}
			} # end of while
			  print >> outfile
			  next
		     }
		     { print >> outfile				 # normal line
		}
     '  htlbody.html

echo "Specify whether you want to delete the large HTML working file"

rm -f a
cat  htlmaster.html HTLEND.HTML >> a
date=`date | gawk '{print $3 "-" $2 "-" $6}'`
sed -e "s/!!DATE!!/$date/g" < a > htl.html
rm -i htlbody.html htlmaster.html

echo "Now you should copy all these HTML files to "
echo "/afs/.cern.ch/project/cndoc/wwwasd/lhc++/htlguide/"

exit












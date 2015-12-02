#!/bin/sh
# Script to prepare HTML files for WWW
# 1) split source file into separate files
# 2) translate AAP tags to generate anchors
# 4) extract keywords for xfind
#
# parameter   Input file
# Author:     M.Goossens / CN-AS
# Last mod:   May 27 1993

Name=`basename $0`
Usage="Usage: $Name input file"

if [ $# -ne 1 ]; then          # Not 1 parameter
     echo $Usage >&2           # display error message
     exit 1                    # abort
fi

if [ ! -r $1 ]; then           # Input file not readable
     echo "$1 not readable"    # display error message
     exit 1                    # abort
fi

sed  -e '/HTML/!d' -e 's/\\indexentry{HTML //' -e 's/\\//' -e 's/}{.*//'  zebrhtml.idx > ZEBRAINDEX.html

# Build the files with the labels "/tmp/ttt"

gawk ' BEGIN	{ nout = 0
                }	
$0 ~  /<FILE NAME=/  { gsub(">","")                     # new file name
			print $0
                       split($0,a,"=") 
			filename=a["2"]
                       next 
                     }
$0 ~  /<A NAME=/     {	  ii   = match ($0,"<A NAME=.*>")
                          str  = substr($0,RSTART,RLENGTH)
			  iii  = index(str,">")
			  sstr = substr(str,1,iii-1)
#			  print sstr
			  split(sstr,a,"=") 
			  label=a["2"]
                       if ( nout == 0 ) 
                           print label " " filename ".html#" label > "temp.tmp"
 		       else
			   print label " " filename ".html#" label >> "temp.tmp"
		       nout = 1
#**********                       print label " " filename "#" label
			  next 
 		     } '  $1

echo '********************************************************'

gawk ' BEGIN	{ while (getline < "temp.tmp" > 0 ) 
 		  { ref[$1] = $2 }
		  nout = 0
		  insidexmp = 0
		  insidepre = 0
                }
$0 ~  /<KEYWORD /    { next } 				# skip keyword commands 
#$0 ~  /<LABEL ID=/   { next } 				# skip label commands 
$0 ~  /<FILE NAME=/  { gsub(">","")                     # new file name
                       split($0,a,"=") 
			filename=a["2"]".html"
		       print  "<!-- " filename " -->" > filename 
                       outfile  = filename
#                       print nout
		       if (nout == 0) { masterfile = filename 
#					print "/" masterfile "/"
				       outfile1 = filename   
#					print "/" outfile1 "/"
				      }
		       nout += 1
                       next 
                     }
$1 ~ /<H1>/  	{ if (nout1 != 0) close(outfile1)       # start of chapter
		  if (nout2 != 0) close(outfile2)
                  outfile1 = filename
                  gsub("<H1>","<H1><A NAME=" filename ">") 
                  gsub("</H1>","</A></H1>")
                  print >> outfile 
                  gsub("NAME=","HREF=")
                  print >> masterfile			# also add H1 title to master page
		  nout1 += 1
                  next
                } 
$1 ~ /<H2>/  	{ if (nout2 != 0) close(outfile2)       # start of section
                  outfile2 = filename
                  gsub("<H2>","<H2><A NAME=" filename ">") 
                  gsub("</H2>","</A></H2>")
                  print >> outfile 
# 		  print $0
                  gsub("NAME=","HREF=")
                  print >> outfile1			# also add H2 title to level 1 page
		  nout2 += 1
                  next
                } 
$0 ~  /<RCIND REFID=/   { # print $0			# Substitute the routine cross-references
			  ii = match ($0,"<RCIND .*>")
                          str = substr($0,RSTART,RLENGTH)
			  iii = index(str,">")
			  sstr = substr(str,1,iii)
			  str  = sstr # original string to be replaced
			  sub ("<RCIND REFID=","",sstr)
			  sub (">","",sstr)
			  if (ref[sstr] !="")
				{ sub (str,"<A HREF="ref[sstr]"><TT>"sstr"</TT></A>")
				  print >> outfile
				}
			  else
				{ print "*****  Unresolved routine cross-reference ***** " sstr
				  print $0
                                  sub (str,"<TT>"sstr"</TT>")
				  print >> outfile
				}
			  next
			}
$0 ~  /<REF REFID=/   { # print $0			# Substitute the references
			  ii = match ($0,"<REF .*>")
                          str = substr($0,RSTART,RLENGTH)
			  iii = index(str,">")
			  sstr = substr(str,1,iii)
			  str  = sstr # original string to be replaced
			  sub ("<REF REFID=","",sstr)
			  sub (">","",sstr)
			  if (ref[sstr] !="")
				{ sub (str,"<A HREF=" ref[sstr] ">[<B>more info</B>]</A>")
				  print >> outfile
				}
			  else
				{ print "*****  Unresolved cross-reference ***** " sstr
				  print $0
				  sub (str,sstr)
				  print >> outfile
				}
			  next
			}
$0 ~  /<XMP>/        { insidexmp = 1 }			# Flag that inside <XMP>
$0 ~  /<\/XMP>/      { insidexmp = 0 }			# Flag that outside <XMP>
#$0 ~  /<PRE>/        { insidepre = 1 }			# Flag that inside <PRE>
#$0 ~  /<\/PRE>/      { insidepre = 0 }			# Flag that outside <PRE>
#/^$/		{ if (insidexmp == 0 && insidepre ==0) {print "<P>" >> outfile} next }          # empty line
/^$/		{ if (insidexmp == 0) {print "<P>" >> outfile} next }          # empty line
		     { print >> outfile				 # normal line
		}
     ' $1  

# Erase the intermediate file with the label "temp.tmp"














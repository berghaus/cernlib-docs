for i in 1 2 3 4 5 6 7 8 9
do
name=pawch$i
echo $name
sed \  
-e '/XMPt/s/\\begin{XMPt}\({.*}\)/\\subsection*\1\\begin{alltt}/' \
-e '/XMPt/s/XMPt/alltt/' \
-e '/XMP/s/XMP/alltt/' $name.tex > $name.newtex
ls -l $name.tex $name.newtex  
done
sed \  
-e '/XMPt/s/\\begin{XMPt}\({.*}\)/\\subsection*\1\\begin{alltt}/' \
-e '/XMPt/s/XMPt/alltt/' \
-e '/XMP/s/XMP/alltt/' kuipch2.tex > kuipch2.newtex
ls -l  kuipch2.tex  kuipch2.newtex
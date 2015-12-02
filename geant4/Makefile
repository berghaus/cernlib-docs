ALL= geant.xml geant.new.xml geant.new.pdf

all: $(ALL)

geant.xml: geant.tex 
	htlatex geant.tex "xhtml,tei.4ht,unicode.4ht,mathml.4ht,tei-mml.4ht,tei-mmltei.4ht" "unicode"
	rxp -V -s geant.xml

geant.new.xml: geant.xml
	saxonxsl geant.xml xml2xml.xsl >  geant.new.xml
	rxp -V -s geant.new.xml 

geant.new.pdf: geant.new.xml
	saxonxsl geant.new.xml /afs/cern.ch/project/tex/xml/tei/tei-fo/tei.xsl >  geant.new.fo
	pdfxmltex geant.new.fo
	pdfxmltex geant.new.fo


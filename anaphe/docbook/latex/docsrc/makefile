# Points to your current .../jdk/bin/java and options
# JAVA = $(shell if [ "$$JAVA2" != "" ]; then echo $$JAVA2; else echo java; fi)
JAVA = /opt/jdk1.3/bin/java
JAVACL = $(JAVA) -cp $(THECLASSPATH)
XSLT    = $(JAVA) -cp /opt/sgml/java/xp.jar:/opt/sgml/java/xt.jar com.jclark.xsl.sax.Driver

XALAN   = $(JAVA) -cp /usr/share/java/xalan.jar:/opt/sgml/xerces-1_3_0/xerces.jar:/usr/share/java/bsf.jar org.apache.xalan.xslt.Process
XALANJ  = $(JAVA) -cp /usr/share/java/xalan.jar:/opt/sgml/xerces-1_3_0/xerces.jar:/usr/share/java/bsf.jar org.apache.xalan.xslt.Process
XALANJ1 = $(JAVA) -cp /usr/share/java/xalan.jar:/opt/sgml/xerces-1_3_0/xerces.jar:/usr/share/java/bsf.jar org.apache.xalan.xslt.Process
XALANJ2 = $(JAVA) -cp /opt/sgml/java/xalan.jar:/opt/sgml/xerces-1_3_0/xerces.jar:/opt/sgml/java/bsf.jar org.apache.xalan.xslt.Process
XALANC  = /opt/bin/xalanc

SAXON   = $(JAVA) -cp /opt/sgml/saxon/saxon.jar com.icl.saxon.StyleSheet 

all:	
# 	$(subst !,autogen/,$(subst .,.xsldoc.xml,$(AUTOGENXML)))
#	$(XALANC) -IN file://./documentation.xml  -XSL file:///opt/sgml/xsl/docbook/latex/docsrc/generatehtml.xsl -OUT doc/index.html  
#	$(XSLT)  documentation.xml  generatehtml.xsl doc/index.html  
#	$(SAXON) -o doc/index.html  documentation.xml  generatehtml.xsl 
	$(XALANJ) -IN autogen/parent.xml  -XSL xsl/generatehtml.xsl 
	mv *.html ../doc



##############################################################
# Rule to extract documentation from the XSL LaTeX stylesheet

autogen/%.xsldoc.xml:../%.mod.xsl
	$(XALANC) -IN $<  -XSL xsl/generatexml.xsl -OUT $@  
#	$(XALANC) -IN $<  -XSL xsl/generatexml.xsl -OUT $@  
#	$(XALANJ) -IN $<  -XSL xsl/generatexml.xsl -OUT $@  
#	$(XSLT)  $<  xsl/generatexml.xsl $@  
#	$(SAXON) -o $@  $<  xsl/generatexml.xsl 



##############################################################
# The clean target

clean:
	rm -rf output*
	rm -rf *.log
	rm -rf autogen/*
	rm -rf doc/* 



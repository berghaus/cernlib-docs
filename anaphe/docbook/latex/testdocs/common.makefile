####################################################################
# DB2LaTeX XSL Stylesheets
# MAKEFILE for test documents
# Modify this values to reflect your local instalation


# JAVA = $(shell if [ "$$JAVA2" != "" ]; then echo $$JAVA2; else echo java; fi)
# JAVA = /opt/jdk1.3/bin/java
JAVA = java

ifndef	SGMLBASE 
SGMLBASE  := /opt/sgml
endif


# XT/XP/SAX/XALAN/SAXON/XERCES jar files...
XTJAR  	= $(SGMLBASE)/xt/xt.jar
XPJAR  	= $(SGMLBASE)/xp/xp.jar
SAXJAR 	= $(SGMLBASE)/java/sax.jar
BSF2JAR 	= $(SGMLBASE)/java/bsf.jar
XALANJ2JAR  = $(SGMLBASE)/java/xalan.jar
XERCESJAR 	= $(SGMLBASE)/java/xerces.jar
SAXONJAR 	= $(SGMLBASE)/saxon/saxon.jar

# C++ Xalan
XALANC  = /opt/bin/xalanc

# Possible options : xt, xalanc, saxon,  xalanj2
all:	xalanj2	
	@echo "LaTeX file generated!"

	
####################################################################
# Do not modigy below this line !

# Set classpaths ...
XTCLASSPATH		= $(SAXJAR):$(XTJAR):$(XPJAR)
SAXONCLASSPATH	= $(SAXONJAR)
XALANJ2CLASSPATH	= $(XALANJ2JAR):$(XERCESJAR):$(BSF2JAR):$(SAXJAR)

# Working directory
DIR  = $(shell if [ "$$PWD" != "" ]; then echo $$PWD; else pwd; fi)
XSL  	= $(DIR)/test.xsl
FILE 	= $(DIR)/test.xml

# Command line tools
XALANJ2 = $(JAVA) -cp $(XALANJ2CLASSPATH) org.apache.xalan.xslt.Process
SAXON   = $(JAVA) -cp $(SAXONCLASSPATH) 	com.icl.saxon.StyleSheet 
XT      = $(JAVA) -cp $(XTCLASSPATH) 	com.jclark.xsl.sax.Driver

# make targets
xt:	$(FILE) $(XSL)
	$(XT) $(FILE) $(XSL) $(DIR)/output.tex

saxon: $(FILE) $(XSL)
	$(SAXON) -o $(DIR)/output.tex $(FILE) $(XSL)

xalanc: $(FILE) $(XSL)
	$(XALANC) -IN file://$(FILE)  -XSL file://$(XSL) -OUT $(DIR)/output.tex

xalanj2: $(FILE) $(XSL)
	$(XALANJ2) -IN file://$(FILE)  -XSL file://$(XSL) -OUT $(DIR)/output.tex

clean:
	rm -rf $(DIR)/output*
	rm -rf $(DIR)/*.log


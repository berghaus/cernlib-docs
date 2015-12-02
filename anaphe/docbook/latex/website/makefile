###################################################################
# Makefile 
#
# These HTML Pages contain the Website of DB2LaTeX and all
# the associated documentation. 
# (c) Ramon Casellas DB2LaTeX 
# $Id: makefile,v 1.1 2001/05/01 18:59:19 rcasellas Exp $
###################################################################


####################################################################
# ENVIRONMENT
####################################################################
ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/);
CONFIG_SHELL := $(shell if [ -x "$$BASH" ];then echo $$BASH; else if [ -x /bin/bash ]; then echo /bin/bash; else echo sh; fi; fi)
TOPDIR  := $(shell if [ "$$PWD" != "" ]; then echo $$PWD; else pwd; fi)
DOCROOTDIR := $(TOPDIR)

LANGUAGE := francais
DOCNAME := $(shell basename `pwd`)

ifndef	SGMLBASE 
SGMLBASE  := /opt/sgml
endif


####################################################################
# TOOLS
####################################################################
# JAVA = /opt/jdk1.3/bin/java
JAVA 		= java
XSLT    	= $(JAVA) -cp $(SGMLBASE)/java/xp.jar:$(SGMLBASE)/java/xt.jar com.jclark.xsl.sax.Driver
XALANJ2 	= $(JAVA) -cp $(SGMLBASE)/java/xalan.jar:$(SGMLBASE)/java/xerces.jar:$(SGMLBASE)/java/bsf.jar org.apache.xalan.xslt.Process
XALANJ	= $(XALANJ2)
XALANC  	= testXSLT 


####################################################################
# Output Directories
####################################################################
PUBDIR = ${DOCROOTDIR}/htdocs
XSLHTMLDIR =${PUBDIR}
XSLXHTMLDIR =${PUBDIR}


####################################################################
# XSL STYLE SHEETS 
####################################################################
HTMLXSL  	= $(DOCROOTDIR)/xsl/html/RCASWebSite.xsl 

XML_FILES 	= $(shell find build -name "*.xml")
FIG_FILES  	= $(shell find build -name "*.fig")
XSL_FILES 	= $(shell find xsl -name "*.xsl")
DEPENDENCY	= $(XML_FILES) $(FIG_FILES) 


####################################################################
# INFORMATION DUMP 
####################################################################
dummy: 
	@echo "Dummy Target"
	@echo "Architecture: 	" $(ARCH)
	@echo "Shell:		" $(CONFIG_SHELL)
	@echo "TopDir:		" $(TOPDIR)
	



#######################################################################
# CLEAN
#######################################################################
clean:
	@echo "Deleting .bak ~ files...."	
	@find $(DOCROOTDIR)  -name "*.bak" -exec rm -rf {} \;
	@find $(DOCROOTDIR)  -name "*~" -exec rm -rf {} \;
	@rm -rf htdocs/*.html
	rm -rf build/*
	rm -rf doc/* 


web:	$(XMLFILES)	
	$(XALANJ)   -IN build/Website.xml  -XSL xsl/html/RCASWebSite.xsl -OUT ${PUBDIR}/out.html

doc:	$(XMLFILES)
# 	$(subst !,build/,$(subst .,.xsldoc.xml,$(AUTOGENXML)))
	$(XALANJ) -VALIDATE OFF  -IN build/Website.xml  -XSL xsl/html/generateAPI.xsl -OUT ${PUBDIR}/db2latex_api.html
	mv -f *.html htdocs

docpdf:	$(XMLFILES)
	$(XALANJ) -VALIDATE OFF  -IN build/Website.xml  -XSL xsl/pdf/generateAPIPDF.xsl -OUT output.tex 



##############################################################
# Rule to extract documentation from the XSL LaTeX stylesheet

build/%.xsldoc.xml:../%.mod.xsl
	$(XALANC) -IN $<  -XSL xsl/html/generatexml.xsl -OUT $@  

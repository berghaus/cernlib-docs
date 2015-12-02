<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: test.xsl,v 1.1.1.1 2001/04/13 09:59:33 rcasellas Exp $
 |- #############################################################################
 |	$Author: rcasellas $												
 |														
 + ############################################################################## -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>

<xsl:import href="../../docbook.xsl"/>
<xsl:output method="text" encoding="ISO-8859-1" indent="yes"/>
<xsl:variable name="latex.override">% ----------------------- Preamble 
\documentclass[english,a4]{article}
\usepackage{amsmath,amsthm, amsfonts, amssymb, amsxtra,amsopn}
\usepackage{graphicx}
\usepackage{float}
\usepackage{times}
\usepackage{algorithmic}
\usepackage[dvips]{hyperref}
\DeclareGraphicsExtensions{.eps}
</xsl:variable>

</xsl:stylesheet>

<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: verbatim.mod.xsl,v 1.4 2001/05/01 17:34:52 rcasellas Exp $
 |- #############################################################################
 |	$Author: rcasellas $
 |														
 |   PURPOSE:
 + ############################################################################## -->

<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
	exclude-result-prefixes="doc" version='1.0'>


<!--############################################################################# -->
<!-- DOCUMENTATION                                                                -->
<doc:reference id="verbatim" xmlns="">
<referenceinfo>
<releaseinfo role="meta">
    $Id: verbatim.mod.xsl,v 1.4 2001/05/01 17:34:52 rcasellas Exp $
</releaseinfo>
<author>
    <surname>Casellas</surname>
    <firstname>Ramon</firstname>
</author>
<copyright>
    <year>2000</year>
    <year>2001</year>
    <holder>Ramon Casellas</holder>
</copyright>
</referenceinfo>
<title>Verbatim <filename>verbatim.mod.xsl</filename></title>
<partintro>
    <section><title>Introduction</title>
    <para></para>
    </section>
</partintro>
</doc:reference>
<!--############################################################################# -->




<xsl:template match="screen|literallayout[@class='monospaced']">
<xsl:text>&#10;\begin{verbatim}&#10;</xsl:text>
<xsl:apply-templates mode="latex.verbatim"/>
<xsl:text>&#10;\end{verbatim}&#10;</xsl:text>
</xsl:template>


<!--############################################################################# -->
<!-- DOCUMENTATION                                                                -->
<doc:template name="literal" xmlns="">
<refpurpose>Template for <sgmltag>literal</sgmltag></refpurpose>
<refdescription>
Template for literal template
</refdescription>
</doc:template>
<!--############################################################################# -->

<xsl:template match="literal" mode="latex.verbatim">
<xsl:text>{\verb </xsl:text>
<xsl:apply-templates mode="latex.verbatim"/>
<xsl:text>}</xsl:text>
</xsl:template>

<xsl:template match="literallayout">
<xsl:text>&#10;\begin{verbatim}&#10;</xsl:text>
<xsl:apply-templates mode="latex.verbatim"/>
<xsl:text>&#10;\end{verbatim}&#10;</xsl:text>
</xsl:template>

<xsl:template match="address">
<xsl:text>&#10;\begin{verbatim}&#10;</xsl:text>
<xsl:apply-templates mode="latex.verbatim"/>
<xsl:text>&#10;\end{verbatim}&#10;</xsl:text>
</xsl:template>

</xsl:stylesheet>

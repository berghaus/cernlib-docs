<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: para.mod.xsl,v 1.4 2001/05/01 17:42:05 rcasellas Exp $
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
<doc:reference id="para" xmlns="">
<referenceinfo>
<releaseinfo role="meta">
    $Id: para.mod.xsl,v 1.4 2001/05/01 17:42:05 rcasellas Exp $
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
<title>Paragraphs <filename>para.mod.xsl</filename></title>
<partintro>
    <section><title>Introduction</title>
    <para></para>
    </section>
</partintro>
</doc:reference>




<xsl:template match="para">
<xsl:text>&#10;</xsl:text>
<xsl:apply-templates/>
<xsl:text>&#10;</xsl:text>
</xsl:template>

<xsl:template match="simpara">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="formalpara">
<xsl:text>&#10;{\bf </xsl:text>
<xsl:call-template name="normalize-scape"><xsl:with-param name="string" select="title"/></xsl:call-template>
<xsl:text>} </xsl:text>
<xsl:apply-templates/>
<xsl:text>&#10;</xsl:text>
<xsl:text>&#10;</xsl:text>
</xsl:template>

<xsl:template match="formalpara/title"/>

<!--========================================================================== 
 |	Especial Cases Do not add Linefeed 
 +============================================================================-->

<xsl:template match="listitem/para"> <xsl:apply-templates/> </xsl:template>
<xsl:template match="textobject/para"> <xsl:apply-templates/> </xsl:template>
<xsl:template match="step/para"> <xsl:apply-templates/> </xsl:template>
<xsl:template match="entry/para"> <xsl:apply-templates/> </xsl:template>
<xsl:template match="question/para"> <xsl:apply-templates/> </xsl:template>
<xsl:template match="answer/para"> <xsl:apply-templates/> </xsl:template>


</xsl:stylesheet>

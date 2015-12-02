<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: footnote.mod.xsl,v 1.3 2001/05/01 17:53:41 rcasellas Exp $
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
<doc:reference id="footnote" xmlns="">
<referenceinfo>
<releaseinfo role="meta">
	$Id: footnote.mod.xsl,v 1.3 2001/05/01 17:53:41 rcasellas Exp $
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
<title>FootNotes <filename>footnote.mod.xsl</filename></title>
<partintro>
	<section><title>Introduction</title>
	<para></para>
	</section>
</partintro>
</doc:reference>
<!--############################################################################# -->



<xsl:template match="footnote">
<xsl:call-template name="label.id"/>
<xsl:text> \footnote{</xsl:text>
<xsl:apply-templates/>
<xsl:text>}</xsl:text>
</xsl:template>

<xsl:template match="footnote/para">
<xsl:apply-templates/>
<xsl:text>&#10;&#10;</xsl:text>
</xsl:template>


<xsl:template match="footnoteref">
<xsl:variable name="footnote" select="id(@linkend)"/>
<xsl:value-of select="name($footnote)"/>
<xsl:text>[\ref{</xsl:text>
	<xsl:value-of select="@linkend"/>
<xsl:text>}]</xsl:text>
</xsl:template>

</xsl:stylesheet>

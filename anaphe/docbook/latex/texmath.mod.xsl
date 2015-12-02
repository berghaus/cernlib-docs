<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: texmath.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
<doc:reference id="texmath" xmlns="">
	<referenceinfo>
	<releaseinfo role="meta">
		$Id: texmath.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
	
	<title>LaTeX Only Commands <filename>texmath.mod.xsl</filename></title>
	<partintro>
		<section><title>Introduction</title>
		<para></para>
		</section>
	</partintro>
</doc:reference>




<xsl:template match="latex">
<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="tex">
<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="latex[@fileref]">
<xsl:text>\input{</xsl:text><xsl:value-of select="@fileref"/><xsl:text>}&#10;</xsl:text>
</xsl:template>

<xsl:template match="tex[@fileref]">
<xsl:text>\input{</xsl:text><xsl:value-of select="@fileref"/><xsl:text>}&#10;</xsl:text>
</xsl:template>


<xsl:template match="tm[@fileref]">
<xsl:text>\input{</xsl:text><xsl:value-of select="@fileref"/><xsl:text>}&#10;</xsl:text>
</xsl:template>

<xsl:template match="tm[@tex]">
<xsl:value-of select="@tex"/>
</xsl:template>

<xsl:template match="inlinetm[@fileref]">
<xsl:text>\input{</xsl:text><xsl:value-of select="@fileref"/><xsl:text>}&#10;</xsl:text>
</xsl:template>

<xsl:template match="inlinetm[@tex]">
<xsl:value-of select="@tex"/>
</xsl:template>
</xsl:stylesheet>

<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: component.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
<doc:reference id="component" xmlns="">
	<referenceinfo>
	<releaseinfo role="meta">
		$Id: component.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
	
	<title>Component <filename>component.mod.xsl</filename></title>
	<partintro>
		<section><title>Introduction</title>
		<para></para>
		</section>
	</partintro>
</doc:reference>






<xsl:template name="component.title">
<xsl:variable name="id">
	<xsl:call-template name="label.id"><xsl:with-param name="object" select="."/></xsl:call-template>
</xsl:variable>
<xsl:text>&#10;{\sc </xsl:text><xsl:apply-templates select="." mode="title.ref"/><xsl:text>}</xsl:text>
</xsl:template>



<xsl:template name="component.subtitle">
<xsl:variable name="subtitle"><xsl:apply-templates select="." mode="subtitle.content"/></xsl:variable>
<xsl:if test="$subtitle != ''">
	<xsl:text>&#10;{\sc </xsl:text><xsl:copy-of select="$subtitle"/><xsl:text>}</xsl:text>
</xsl:if>
</xsl:template>

<xsl:template name="component.separator">
</xsl:template>


<xsl:template match="colophon">
	<xsl:variable name="id"><xsl:call-template name="label.id"/></xsl:variable>
		<xsl:call-template name="component.separator"/>
		<xsl:call-template name="component.title"/>
		<xsl:call-template name="component.subtitle"/>
	<xsl:apply-templates/>
</xsl:template>
<xsl:template match="colophon/title"></xsl:template>



<xsl:template match="bibliography" mode="component.number">
	<xsl:param name="add.space" select="false()"/>
</xsl:template>

<xsl:template match="glossary" mode="component.number">
	<xsl:param name="add.space" select="false()"/>
</xsl:template>

<xsl:template match="index" mode="component.number">
	<xsl:param name="add.space" select="false()"/>
</xsl:template>

</xsl:stylesheet>


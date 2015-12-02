<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: formal.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
<doc:reference id="formal" xmlns="">
	<referenceinfo>
	<releaseinfo role="meta">
		$Id: formal.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
	
	<title>Formal Objects <filename>formal.mod.xsl</filename></title>
	<partintro>
		<section><title>Introduction</title>
		<para></para>
		</section>
	</partintro>
</doc:reference>




<xsl:template name="formal.object">
<xsl:call-template name="formal.object.heading">
	<xsl:with-param name="title"><xsl:apply-templates select="." mode="title.ref"/></xsl:with-param>
</xsl:call-template>
<xsl:apply-templates/>
</xsl:template>

<xsl:template name="formal.object.heading">
<xsl:param name="title"></xsl:param>
<xsl:call-template name="label.id"/>
<xsl:copy-of select="$title"/>
</xsl:template>

<xsl:template name="informal.object">
<xsl:call-template name="label.id"/>
<xsl:apply-templates/>
</xsl:template>

<xsl:template name="semiformal.object">
<xsl:choose>
	<xsl:when test="title">	<xsl:call-template name="formal.object"/>	</xsl:when>
	<xsl:otherwise> <xsl:call-template name="informal.object"/></xsl:otherwise>
</xsl:choose>
</xsl:template>


<xsl:template match="equation">
<xsl:call-template name="map.begin"/>
<xsl:apply-templates />
<xsl:call-template name="map.end"/>
</xsl:template>


<xsl:template match="informalequation">
<xsl:call-template name="informal.object"/>
</xsl:template>

<xsl:template match="equation/title"/>
</xsl:stylesheet>

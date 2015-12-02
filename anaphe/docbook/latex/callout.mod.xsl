<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: callout.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
<doc:reference id="callout" xmlns="">
	<referenceinfo>
	<releaseinfo role="meta">
		$Id: callout.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
	
	<title>Callout <filename>callout.mod.xsl</filename></title>
	<partintro>
		<section><title>Introduction</title>
		<para></para>
		</section>
	</partintro>
</doc:reference>




<xsl:template match="programlistingco|screenco">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="areaspec|areaset|area">
</xsl:template>

<xsl:template match="co">
    <xsl:apply-templates select="." mode="callout-bug"/>
</xsl:template>

<xsl:template match="co" mode="callout-bug">
  <xsl:variable name="conum">
    <xsl:number count="co" format="1"/>
  </xsl:variable>

  <xsl:text>(</xsl:text>
  <xsl:value-of select="$conum"/>
  <xsl:text>)</xsl:text>
</xsl:template>

</xsl:stylesheet>

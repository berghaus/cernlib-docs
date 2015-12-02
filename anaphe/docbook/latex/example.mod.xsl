<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: example.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
<doc:reference id="example" xmlns="">
	<referenceinfo>
	<releaseinfo role="meta">
		$Id: example.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
	
	<title>Example <filename>example.mod.xsl</filename></title>
	<partintro>
		<section><title>Introduction</title>
		<para></para>
		</section>
	</partintro>
</doc:reference>



<xsl:template match="example">
<xsl:call-template name="map.begin"/>
	<xsl:apply-templates />
<xsl:call-template name="map.end"/>
</xsl:template>

<xsl:template match="informalexample">
<xsl:call-template name="informal.object"/>
</xsl:template>

<xsl:template match="example/title"></xsl:template>
</xsl:stylesheet>

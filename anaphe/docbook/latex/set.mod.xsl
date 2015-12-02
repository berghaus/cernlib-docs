<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: set.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
<doc:reference id="set" xmlns="">
	<referenceinfo>
	<releaseinfo role="meta">
		$Id: set.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
	
	<title>Sets <filename>set.mod.xsl</filename></title>
	<partintro>
		<section><title>Introduction</title>
		<para></para>
		</section>
	</partintro>
</doc:reference>



<xsl:template match="set">
<xsl:call-template name="label.id"/>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="set/setinfo"></xsl:template>
<xsl:template match="set/title"></xsl:template>
<xsl:template match="set/subtitle"></xsl:template>

</xsl:stylesheet>


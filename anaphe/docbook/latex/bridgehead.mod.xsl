<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: bridgehead.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
<doc:reference id="bridgehead" xmlns="">
	<referenceinfo>
	<releaseinfo role="meta">
		$Id: bridgehead.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
	
	<title>BridgeHead <filename>bridgehead.mod.xsl</filename></title>
	<partintro>
		<section><title>Introduction</title>
		<para></para>
		</section>
	</partintro>
</doc:reference>



<!-- RCAS: Add bridgehead renderas support -->
<xsl:template match="bridgehead">
<xsl:text>&#10;&#10;</xsl:text>
<xsl:text>&#10;\noindent{\bf </xsl:text><xsl:apply-templates/><xsl:text>} \\ &#10;</xsl:text>
<xsl:call-template name="label.id"/>
</xsl:template>

</xsl:stylesheet>

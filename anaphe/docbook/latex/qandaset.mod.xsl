<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: qandaset.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
<doc:reference id="qandaset" xmlns="">
	<referenceinfo>
	<releaseinfo role="meta">
		$Id: qandaset.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
	
	<title>QandaSet <filename>qandaset.mod.xsl</filename></title>
	<partintro>
		<section><title>Introduction</title>
		<para>NOT IMPLEMENTED.</para>
		</section>
	</partintro>
</doc:reference>
<!--############################################################################# -->

<xsl:template match="qandaset"/>
<xsl:template match="qandaset/title"/>
<xsl:template match="qandadiv"/>
<xsl:template match="qandadiv/title"/>
<xsl:template match="qandaentry">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="question"/>
<xsl:template match="answer"/>
<xsl:template match="label"/>

</xsl:stylesheet>

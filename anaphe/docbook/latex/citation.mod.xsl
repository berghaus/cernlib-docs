<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: citation.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
<doc:reference id="citation" xmlns="">
	<referenceinfo>
	<releaseinfo role="meta">
		$Id: citation.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
	
	<title>Citation <filename>citation.mod.xsl</filename></title>
	<partintro>
		<section><title>Introduction</title>
		<para></para>
		</section>
	</partintro>
</doc:reference>


<doc:template match="citation" xmlns="">
<refpurpose> Citation XSL template.  </refpurpose>
<refdescription>
<para> Outputs a simple <literal>\cite{ }</literal> Command, 
containing the result of processing the citation's children
</para>
</refdescription>
</doc:template>



<xsl:template match="citation">
<!-- todo: biblio-citation-check -->
<xsl:text>\cite{</xsl:text>
<xsl:apply-templates/>
<xsl:text>}</xsl:text>
</xsl:template>

</xsl:stylesheet>

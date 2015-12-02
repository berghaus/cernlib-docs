<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: email.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
<doc:reference id="email" xmlns="">
	<referenceinfo>
	<releaseinfo role="meta">
		$Id: email.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
	
	<title>Email <filename>email.mod.xsl</filename></title>
	<partintro>
		<section><title>Introduction</title>
		<para></para>
		</section>
	</partintro>
</doc:reference>
<!--############################################################################# -->

 
<!--############################################################################# -->
<!-- DOCUMENTATION                                                                -->
<doc:template match="email" xmlns="">
<refpurpose> XSL template for email </refpurpose>
<refdescription>
	<para>Outputs the mail in {\tt }. Calls the normalize-scape template in order to get a 
	normalized email string. It does not process email content model.</para>
	<formalpara><title>Remarks and Bugs</title>
	</formalpara>
</refdescription>
</doc:template>
<!--############################################################################# -->


<xsl:template match="email">
<xsl:text>{\tt &lt;</xsl:text> 
<xsl:text>mailto:</xsl:text>
<xsl:call-template name="normalize-scape">
	<xsl:with-param name="string" select="."/> 
</xsl:call-template>
<xsl:text>&gt; }</xsl:text>
</xsl:template>

</xsl:stylesheet>

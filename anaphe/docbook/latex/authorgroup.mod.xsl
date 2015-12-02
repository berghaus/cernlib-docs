<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: authorgroup.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
 |- #############################################################################
 |	$Author: rcasellas $												
 |														
 |   PURPOSE: Manage Authorgroups 
 + ############################################################################## -->

<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
	exclude-result-prefixes="doc" version='1.0'>



<!--############################################################################# -->
<!-- DOCUMENTATION                                                                -->
<doc:reference id="authorgroup" xmlns="">
	<referenceinfo>
	<releaseinfo role="meta">
		$Id: authorgroup.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
	
	<title>Authorgroup <filename>authorgroup.mod.xsl</filename></title>
	<partintro>
		<section><title>Introduction</title>
		<para></para>
		</section>
	</partintro>
</doc:reference>


<doc:template match="authorgroup" xmlns="">
<refpurpose> Authorgroup XSL template.  </refpurpose>
<refdescription>
</refdescription>
</doc:template>

<xsl:template match="authorgroup">
<xsl:for-each select="author">
	<xsl:apply-templates select="."/>
        <xsl:if test="not(position()=last())">
        	<xsl:text> \and </xsl:text>
        </xsl:if>
</xsl:for-each>
</xsl:template>

<doc:template match="authorinitials" xmlns="">
<refpurpose> AuthorInitials XSL template.  </refpurpose>
<refdescription>
</refdescription>
</doc:template>

<xsl:template match="authorinitials">
<xsl:apply-templates/>
<xsl:value-of select="$biblioentry.item.separator"/>
</xsl:template>

</xsl:stylesheet>

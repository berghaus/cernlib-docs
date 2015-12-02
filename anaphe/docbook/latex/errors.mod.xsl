<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>
<!--############################################################################# 
 |	$Id: errors.mod.xsl,v 1.2 2001/05/01 17:34:52 rcasellas Exp $
 |- #############################################################################
 |	$Author: rcasellas $
 |														
 |   PURPOSE:
 + ############################################################################## -->


<xsl:template match="*">
<xsl:message>DB2LaTeX: Need to process XPath match <xsl:value-of select="name(.)"/></xsl:message>
<xsl:text> [</xsl:text><xsl:value-of select="name(.)"/><xsl:text>] &#10;</xsl:text>
<xsl:apply-templates/> 
<xsl:text> [/</xsl:text><xsl:value-of select="name(.)"/><xsl:text>] &#10;</xsl:text>
</xsl:template>
</xsl:stylesheet>

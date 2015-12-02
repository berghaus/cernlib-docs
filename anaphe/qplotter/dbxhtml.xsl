<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version="1.0">

<xsl:import href="/afs/cern.ch/sw/XML/cdrom/www.nwalsh.com/docbook/xsl/html/docbook.xsl"/>
<xsl:variable name="masterFile">qplotter</xsl:variable>
<xsl:variable name="graphic.default.extension">jpeg</xsl:variable>
<xsl:variable name="graphicsSuffix">jpeg</xsl:variable>
<xsl:variable name="html.stylesheet">docbook.css</xsl:variable>

<!-- Do not print elements labeled "printonly" -->
<xsl:template match='*[@role="printonly"]'/> 

<xsl:template match='method'>
<tt><xsl:apply-templates/></tt>
</xsl:template>

<xsl:template match="graphic[@fileref]">
  <p>
    <img align="center" src="{@fileref}.{$graphicsSuffix}"/>
  </p>
</xsl:template>

<xsl:template match="inlinegraphic[@fileref]">
  <img src="{@fileref}.{$graphicsSuffix}">
   <xsl:if test="@align">
    <xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
   </xsl:if>
  </img>
</xsl:template>

</xsl:stylesheet>

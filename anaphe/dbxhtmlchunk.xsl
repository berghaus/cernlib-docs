<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version="1.0">

<xsl:import href="/afs/cern.ch/sw/XML/cdrom/www.nwalsh.com/docbook/xsl/html/chunk.xsl"/>
<!-- Customization mg 1 Feb. 2001 -->
<xsl:param name="graphic.default.extension">jpeg</xsl:param>
<xsl:param name="html.stylesheet">docbook.css</xsl:param>
<xsl:param name="toc.section.depth">1</xsl:param>
<xsl:param name="using.chunker">1</xsl:param>
<xsl:param name="html.ext">.html</xsl:param>
<xsl:param name="root.filename">anaphe</xsl:param>
<xsl:param name="base.dir">mydir/</xsl:param>
<xsl:param name="suppress.navigation">0</xsl:param>
<xsl:param name="saxon.extensions">0</xsl:param>

<!-- Do not print elements labeled "printonly" -->
<xsl:template match='*[@role="printonly"]'/> 

<!--
<!+-+- This template only outputs figure number for an xref    +-+->
<xsl:template match="figure" mode="xref-to">
  <xsl:param name="target" select="."/>
  <xsl:param name="refelem" select="local-name($target)"/>
  <xsl:param name="xref.text">
    <xsl:call-template name="gentext.xref.text">
      <xsl:with-param name="element.name" select="$refelem"/>
<!+-+-   <xsl:with-param name="default">%g %n</xsl:with-param> +-+->
<!+-+- general case               text  ^^ ^^ number           +-+->
      <xsl:with-param name="default">%n</xsl:with-param>
<!+-+-  In reference only number       ^^ is needed            +-+->
    </xsl:call-template>
  </xsl:param>
-->
<!-- This template puts the caption below the figure -->
<xsl:template match="figure" priority="999">
  <div class="figure">
    <xsl:apply-templates/>
    <xsl:call-template name="formal.object.heading">
       <xsl:with-param name="title">
         <xsl:apply-templates select="." mode="title.ref"/>
       </xsl:with-param>
    </xsl:call-template>
  </div>
</xsl:template>

<xsl:template match='method'>
<tt><xsl:apply-templates/></tt>
</xsl:template>

<xsl:template match="graphic[@fileref]">
  <p>
    <img align="center" src="{@fileref}.{$graphic.default.extension}"/>
  </p>
</xsl:template>

<xsl:template match="inlinegraphic[@fileref]" priority="999">
  <img src="{@fileref}.{$graphic.default.extension}">
   <xsl:if test="@align">
    <xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
   </xsl:if>
  </img>
</xsl:template>

</xsl:stylesheet>

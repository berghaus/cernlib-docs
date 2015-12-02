<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:m="http://www.w3.org/1998/Math/MathML"
                version="1.0">

<xsl:import  href="/afs/cern.ch/sw/XML/cdrom/www.nwalsh.com/docbook/xsl/fo/autoidx.xsl"/>
<xsl:include href="titlepage.xsl"/>

<xsl:param name="graphic.default.extension">jpg</xsl:param>
<xsl:param name="paper.type" select="'A4'"/>
<xsl:param name="passivetex.extensions" select="1"/>
<xsl:param name="use.extensions" select="1"/>

<!-- ********************************************************************
     Michel's additions to Norm's FO Docbook Style Sheets 
     ******************************************************************** -->

<xsl:template match="programlisting" priority="4">
  <fo:block wrap-option="no-wrap" 
            whitespace-treatment="preserve"
            text-align="start" 
            font-family="monospace"
            font-size="9pt"
            space-before.optimum="4pt"
            space-after.optimum="4pt"
 >
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="variablelist">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>
  <fo:list-block id="{$id}"
                 provisional-distance-between-starts="46mm"
                 provisional-label-separation="2mm"
                 space-before.minimum="0.2em"
                 space-before.optimum="0.4em"
                 space-before.maximum="0.6em">
    <xsl:apply-templates/>
  </fo:list-block>
</xsl:template>

<xsl:template match="varlistentry">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>
  <fo:list-item id="{$id}"
                space-before.minimum="0em"
                space-before.optimum=".1em"
                space-before.maximum=".2em">
    <fo:list-item-label>
      <fo:block>
        <xsl:apply-templates select="term"/>
      </fo:block>
    </fo:list-item-label>
    <fo:list-item-body>
      <xsl:apply-templates select="listitem"/>
    </fo:list-item-body>
  </fo:list-item>
</xsl:template>

<xsl:template match="programlisting[@role='outputlisting']" priority="5">
  <fo:block wrap-option="no-wrap" 
            whitespace-treatment="preserve"
            text-align="start" 
            font-family="monospace"
            font-size="7pt"
            space-before.optimum="4pt"
            space-after.optimum="4pt"
 >
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="xref.text" priority="5">
  <xsl:text>[</xsl:text><xsl:apply-templates/><xsl:text>]</xsl:text>
</xsl:template>

<xsl:template match="method|object">
  <fo:inline font-family="monospace">
    <xsl:apply-templates/> 
  </fo:inline>
</xsl:template>

<xsl:template match="m:math">
 <xsl:copy>
  <xsl:apply-templates mode="math"/> 
 </xsl:copy>
</xsl:template>

<xsl:template match="informalequation|inlineequation">
<xsl:element name="{name(.)}">
 <xsl:apply-templates/> 
</xsl:element>
</xsl:template>

<xsl:template  mode="math"  
  match="*|@*|comment()|processing-instruction()|text()">
  <xsl:copy>
  <xsl:apply-templates    mode="math" 
   select="*|@*|processing-instruction()|text()"/>
 </xsl:copy>
</xsl:template>

</xsl:stylesheet>

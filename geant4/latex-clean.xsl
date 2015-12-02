<?xml version="1.0"?> 
<!-- 

Clean TeX4ht LaTeX-like output, adjusting ids etc

Sebastian Rahtz, 2000/03/27

sebastian.rahtz@oucs.ox.ac.uk

 This program can redistributed and/or modified under  
 the terms of the LaTeX Project Public License         
 Distributed from CTAN archives in directory           
 macros/latex/base/lppl.txt; either version 1 of the   
 License, or (at your option) any later version.       
-->

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<!-- sections search for labels in <head> children -->

 <xsl:template match="section|subsection">
  <xsl:element name="{name()}">
  <xsl:for-each select="@*">
    <xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
  </xsl:for-each>
   <xsl:if test="child::stitle/a/@name">
    <xsl:attribute name="id"><xsl:value-of select="stitle/a/@name"/></xsl:attribute>
   </xsl:if>
   <xsl:apply-templates/>
  </xsl:element>
 </xsl:template>

<!-- bibitems look for <par>/<a> grandchildren -->
 <xsl:template match="bibitem">
  <xsl:element name="{name()}">
  <xsl:for-each select="@*">
    <xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
  </xsl:for-each>
   <xsl:if test="child::par/a/@name">
    <xsl:attribute name="id"><xsl:value-of select="par/a/@name"/></xsl:attribute>
   </xsl:if>
   <xsl:apply-templates/>
  </xsl:element>
 </xsl:template>

<!-- captions look for preceding <a> siblings -->
 <xsl:template match="caption">
  <xsl:element name="{name()}">
  <xsl:for-each select="@*">
    <xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
  </xsl:for-each>
   <xsl:if test="preceding-sibling::a/@name">
    <xsl:attribute name="id"><xsl:value-of select="../a/@name"/></xsl:attribute>
   </xsl:if>
   <xsl:apply-templates/>
  </xsl:element>
 </xsl:template>

<!-- a elements are ignored  unless they have an href attribute-->
 <xsl:template match="a">
  <xsl:if test="@href">
      <ref target="{substring-after(@href,'#')}"><xsl:apply-templates select="."/></ref>
  </xsl:if>  
 </xsl:template>

</xsl:stylesheet >
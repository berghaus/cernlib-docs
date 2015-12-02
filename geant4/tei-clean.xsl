<?xml version="1.0"?> 
<!-- 

Clean TeX4ht TEI output, adjusting ids etc

Sebastian Rahtz, 2000/03/27

sebastian.rahtz@oucs.ox.ac.uk

 This program can redistributed and/or modified under  
 the terms of the LaTeX Project Public License         
 Distributed from CTAN archives in directory           
 macros/latex/base/lppl.txt; either version 1 of the   
 License, or (at your option) any later version.       
                                                       
-->


<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  version="1.0"
>


<!-- put back doctype and dtd subset, based on @Basename= comment -->



<xsl:template match="TEI.2">
<xsl:variable name="ctext" select="comment()[1]"/>
<xsl:if test="starts-with($ctext,'@entities=')">
 <xsl:value-of 
    disable-output-escaping="yes" 
    select="concat('
&lt;?xml-stylesheet type=&quot;text/css&quot; href=&quot;mathml.css&quot;?> &#10;
&lt;?xml-stylesheet type=&quot;text/css&quot; href=&quot;tei.css&quot;?> &#10;
&lt;!DOCTYPE TEI.2 SYSTEM &quot;teimml.dtd&quot;[  &#10;
',
concat(substring-after($ctext,'='),
']>&#10; '))"/> 
</xsl:if>
<TEI.2>
<xsl:apply-templates/>
</TEI.2>
</xsl:template>


<!-- sections search for labels in <head> children -->

<xsl:template match="div">
  <xsl:element name="{name()}">
  <xsl:for-each select="@*">
    <xsl:apply-templates select="."/>
  </xsl:for-each>
   <xsl:if test="child::head/ref/@id">
    <xsl:attribute name="id"><xsl:value-of select="head/ref/@id"/></xsl:attribute>
   </xsl:if>
   <xsl:apply-templates/>
  </xsl:element>
 </xsl:template>

<xsl:template match="div[@type='preamble']">
   <xsl:apply-templates/>
</xsl:template>

<!-- bibitems look for <ref> children -->
 <xsl:template match="bibl">
  <xsl:element name="{name()}">
  <xsl:for-each select="@*">
    <xsl:apply-templates select="."/>
  </xsl:for-each>
   <xsl:if test="child::ref/@id">
    <xsl:attribute name="id"><xsl:value-of select="ref/@id"/></xsl:attribute>
   </xsl:if>
   <xsl:apply-templates/>
  </xsl:element>
 </xsl:template>


<!-- paragraph figures look for <ref> children -->

<xsl:template match="p[@rend='figure']">
  <p><figure>
  <xsl:for-each select="figure">
  <xsl:for-each select="@*">
    <xsl:apply-templates select="."/>
  </xsl:for-each>
    <xsl:attribute name="entity">
         <xsl:value-of select="@entity"/>
    </xsl:attribute>
  </xsl:for-each>
  <xsl:if test="child::ref/@id">
    <xsl:attribute name="id"><xsl:value-of select="ref/@id"/></xsl:attribute>
   </xsl:if>
   <xsl:apply-templates/>
  </figure></p>
</xsl:template>

<xsl:template match="p[rend='table']">
 <xsl:apply-templates/>
</xsl:template>

<xsl:template match="table">
 <xsl:choose>
  <xsl:when test="parent::p[@rend='table']">
    <table rend="display">
      <xsl:copy-of select="@rows"/>
      <xsl:copy-of select="@cols"/>
      <xsl:apply-templates/>
    </table>
  </xsl:when>
  <xsl:otherwise>
    <table rend="inline">
      <xsl:copy-of select="@rows"/>
      <xsl:copy-of select="@cols"/>
      <xsl:apply-templates/>
    </table>
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<!-- title in a figure or table is a caption -->
<xsl:template match="p[@rend='figure']/title">
 <head><xsl:apply-templates/></head>
</xsl:template>

<xsl:template match="p[@rend='table']/title">
 <head><xsl:apply-templates/></head>
</xsl:template>

<xsl:template match="figure"/>

<!-- ref elements are ignored  unless they have a target attribute-->
<xsl:template match="ref">
 <xsl:if test="@target">
 <xsl:variable name="contents"><xsl:apply-templates/></xsl:variable>
  <xsl:choose>
  <xsl:when test="$contents">
      <ref target="{@target}"><xsl:value-of select="$contents"/></ref>
  </xsl:when>
  <xsl:otherwise>
   <ptr target="{@target}"/>
  </xsl:otherwise>
  </xsl:choose>
 </xsl:if>  
 </xsl:template>

<xsl:template match="@TEIform|@targOrder|@default|@org|@sample|@part"/>

<xsl:template match="formula">
 <xsl:copy>
    <xsl:attribute name="notation">mathml</xsl:attribute>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
 </xsl:copy>
</xsl:template>

<xsl:template match="p[@rend='equation']">
  <p><formula notation="mathml">
     <xsl:apply-templates select="formula/*"/>
  </formula></p>
</xsl:template>

<xsl:template match="p[@rend='equation']" mode="mathlabel">
     <xsl:apply-templates mode="mathlabel"/>
</xsl:template>

<xsl:template match="formula" mode="mathlabel"/>

<xsl:template match="text()" mode="mathlabel">
 <xsl:value-of select="normalize-space(.)"/>
</xsl:template>


</xsl:stylesheet>

<?xml version="1.0"?> 
<xsl:stylesheet 
  xmlns:math="http://www.w3.org/1998/Math/MathML"
  exclude-result-prefixes="math" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="xml" doctype-system="latexexa.dtd"/>

<xsl:import href="mathml-clean.xsl"/>

<xsl:template match="*|@*|processing-instruction()">
 <xsl:copy>
  <xsl:apply-templates select="*|@*|processing-instruction()|text()"/>
 </xsl:copy>
</xsl:template>

<xsl:template match="text()">
    <xsl:value-of select="normalize-space(.)"/>
</xsl:template>

<xsl:template match="TEI.2">
<document>
   <xsl:apply-templates/>
</document>
</xsl:template>

<xsl:template match="text">
   <xsl:apply-templates/>
</xsl:template>

<xsl:template match="titlePage">
   <xsl:apply-templates/>
</xsl:template>

<xsl:template match="body">
<bodymatter>
   <xsl:apply-templates/>
</bodymatter>
</xsl:template>

<xsl:template match="p">
<par>
   <xsl:apply-templates/>
</par>
</xsl:template>

<xsl:template match="div/head">
<stitle>
   <xsl:apply-templates/>
</stitle>
</xsl:template>

<xsl:template match="front">
<frontmatter>
   <xsl:apply-templates/>
</frontmatter>
</xsl:template>

<xsl:template match="docAuthor">
<author>
   <xsl:apply-templates/>
</author>
</xsl:template>

<xsl:template match="docDate">
<date>
   <xsl:apply-templates/>
</date>
</xsl:template>

<xsl:template match="docTitle">
<title>
   <xsl:apply-templates/>
</title>
</xsl:template>

<xsl:template match="titlePart">
   <xsl:apply-templates/>
</xsl:template>

<xsl:template match="hi[@rend='tt']">
   <texttt><xsl:apply-templates/></texttt>
</xsl:template>

<xsl:template match="listBibl">
   <bibliography><xsl:apply-templates/></bibliography>
</xsl:template>

<xsl:template match="xref">
   <xsl:apply-templates/>
</xsl:template>

<xsl:template match="teiHeader"/>

<xsl:template match="byline"/>

<xsl:template match="div[@type='likesection']">
 <section class="star"><xsl:apply-templates/></section>
</xsl:template>

<xsl:template match="div[@type='preamble']">
   <xsl:apply-templates/>
</xsl:template>

<xsl:template match="div">
  <xsl:element name="{@type}">
   <xsl:if test="child::head/ref/@id">
 <xsl:attribute name="id"><xsl:value-of select="head/ref/@id"/></xsl:attribute>
   </xsl:if>
   <xsl:apply-templates/>
  </xsl:element>
 </xsl:template>


<!-- bibitems look for <ref> children -->
 <xsl:template match="bibl">
  <bibitem>
  <xsl:for-each select="@*">
    <xsl:apply-templates select="."/>
  </xsl:for-each>
   <xsl:if test="child::ref/@id">
    <xsl:attribute name="id"><xsl:value-of select="ref/@id"/></xsl:attribute>
   </xsl:if>
   <xsl:apply-templates/>
  </bibitem>
 </xsl:template>


<xsl:template match="p[@rend='equation']">
  <par><equation>
     <xsl:apply-templates select="formula/*"/>
  </equation></par>
</xsl:template>

<!-- paragraph figures look for <ref> children -->

<xsl:template match="p[@rend='figure']">
  <par><figure>
   <xsl:apply-templates/>
  </figure></par>
</xsl:template>

<xsl:template match="table">
  <tabular preamble="{@rend}">
   <xsl:apply-templates/>
  </tabular>
</xsl:template>

<xsl:template match="row">
  <row>
   <xsl:apply-templates/>
  </row>
</xsl:template>

<xsl:template match="cell">
  <cell>
   <xsl:apply-templates/>
  </cell>
</xsl:template>

<!-- title in a figure is a caption -->
<xsl:template match="p[@rend='figure']/title">
 <caption>
 <xsl:if test="preceding-sibling::ref">
   <xsl:attribute name="id"><xsl:value-of select="preceding-sibling::ref/@id"/>   </xsl:attribute>
 </xsl:if>
 <xsl:apply-templates/></caption>
</xsl:template>

<xsl:template match="figure"/>

<!-- ref elements are ignored  unless they have a target attribute-->
 <xsl:template match="ref">
  <xsl:if test="@target">
      <ref refid="{@target}"><xsl:apply-templates select="."/></ref>
  </xsl:if>  
 </xsl:template>

<xsl:template match="@xlink|@xmlns|@TEIform|@targOrder|@default|@org|@sample|@part"/>

<xsl:template match="list">
 <xsl:choose>
  <xsl:when test="@display='ordered'">
   <lalist class="enumerate"><xsl:apply-templates/></lalist>
  </xsl:when>
  <xsl:otherwise>
   <lalist class="itemize"><xsl:apply-templates/></lalist>
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<xsl:template match="formula">
 <xsl:choose>
  <xsl:when test="./math:math[@display='block']">
   <displaymath><xsl:apply-templates/></displaymath>
  </xsl:when>
  <xsl:otherwise>
   <inlinemath><xsl:apply-templates/></inlinemath>
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<xsl:template match="math:math">
<math>
  <xsl:apply-templates/>
</math>
</xsl:template>

</xsl:stylesheet>



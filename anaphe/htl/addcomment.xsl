<?xml version="1.0"?> 
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://www.jclark.com/xt/java/java.util.Date"
  xmlns:xt="http://www.jclark.com/xt"
  extension-element-prefixes="xt">
<!-- 
     Include comments in large HTML file to divide into separate
     file at the chapter level, at the same time getting
     cross-references right 

     Last mod.  18 April 2000 mg 
-->

<!--default behaviours for all nodes--> 
<xsl:template match="/" priority="-100"> 
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="text()" priority="-100"> <!--text untouched--> 
<xsl:value-of select="."/> 
</xsl:template>
                                                    <!--nodes untouched--> 
<xsl:template match="processing-instruction()|comment()|*|@*" priority="-100"> 
<xsl:copy> 
<xsl:apply-templates select="text()|processing-instruction()|comment()|*|@*"/> 
</xsl:copy> 
</xsl:template>

<!-- Customization --> 

<xsl:template match="*[@class='chapter' or @class='appendix']">
<xsl:text>
</xsl:text>
<xsl:comment>filename=<xsl:value-of select="@id"/>
</xsl:comment>
<xsl:text>
</xsl:text>
<xsl:element name="div">
<xsl:attribute name="class"><xsl:value-of select="@class"/>
</xsl:attribute>
<xsl:apply-templates/>
</xsl:element>
<xsl:text>
</xsl:text>
<xsl:comment>==endfilename==</xsl:comment>
<xsl:text>
</xsl:text>
</xsl:template>

<!--
<xsl:template
match="div[@class='chapter']/h2[1] or div[@class='appendix']/h2[1]" priority="10">
<xsl:text>
</xsl:text>
<xsl:element name="h1">
<xsl:apply-templates/>
</xsl:element>
<xsl:text>
</xsl:text>
</xsl:template>
-->

<xsl:template match="html|body"> <!-- pass through -->
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="head"> <!-- ignore -->
</xsl:template>

</xsl:stylesheet>


<?xml version="1.0"?> 
<!-- 

Clean TeX4ht MathML output, merging runs of the same element

Sebastian Rahtz, 2000/03/27, from work by David Carlisle

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
  xmlns:math="http://www.w3.org/1998/Math/MathML"
  exclude-result-prefixes="math"
>
 
<xsl:template match="math:mo" >
 <xsl:copy>
   <xsl:if test="not(preceding-sibling::math:mo)">
      <xsl:attribute name="form">prefix</xsl:attribute>
   </xsl:if>
   <xsl:apply-templates/>
 </xsl:copy>
</xsl:template>

<xsl:template match="math:mi" >
 <xsl:if test="not(preceding-sibling::*[position()=1 and  self::math:mi])">
     <xsl:apply-templates mode="grab" select="."/>
 </xsl:if>
</xsl:template>

<xsl:template match="math:mn" >
 <xsl:if test="not(preceding-sibling::*[position()=1 and  
   (self::math:mn or self::math:mo[.='.']) ])">
     <xsl:apply-templates mode="grab" select="."/>
 </xsl:if>
</xsl:template>

<xsl:template match="math:mo[.='.' and preceding-sibling::math:mn]" >
</xsl:template>

<xsl:template mode="grab" match="math:mi">
<xsl:param name="x" select="''"/>
<xsl:choose>
  <xsl:when test="following-sibling::*[position()=1 and self::math:mi]">   
     <xsl:apply-templates mode="grab" select="following-sibling::*[1]">
       <xsl:with-param name="x" select="concat($x,.)"/>
     </xsl:apply-templates>
   </xsl:when>
   <xsl:otherwise>
     <mi><xsl:value-of select="concat($x,.)"/></mi>
   </xsl:otherwise>
</xsl:choose>
</xsl:template>


<xsl:template mode="grab" match="math:mn|math:mo">
<xsl:param name="x" select="''"/>
<xsl:choose>
  <xsl:when test="following-sibling::*[position()=1 and 
  (self::math:mn or self::math:mo[.='.']) ]">   
     <xsl:apply-templates mode="grab" select="following-sibling::*[1]">
       <xsl:with-param name="x" select="concat($x,.)"/>
     </xsl:apply-templates>
   </xsl:when>
   <xsl:otherwise>
     <mn><xsl:value-of select="concat($x,.)"/></mn>
   </xsl:otherwise>
</xsl:choose>
</xsl:template>
</xsl:stylesheet>

<?xml version="1.0"?> 
<!-- 

Clean TeX4ht TEI math output

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
  xmlns:math="http://www.w3.org/1998/Math/MathML"
  exclude-result-prefixes="math"
  version="1.0"
>


<xsl:template match="math:math">
<xsl:variable name="prend"><xsl:value-of select="../@rend"/></xsl:variable>
<xsl:copy>
 <xsl:copy-of select="@*"/>
 <xsl:if test="$prend">
  <xsl:choose>
   <xsl:when test="$prend='equation'">
    <mtable class="equation">
    <mlabeledtr>
     <mtd><mtext><xsl:apply-templates select="ancestor::p" mode="mathlabel"/>
        </mtext></mtd>
     <mtd><xsl:apply-templates/></mtd>
    </mlabeledtr>
   </mtable>
   </xsl:when>
   <xsl:otherwise>
  <xsl:attribute name="display"><xsl:value-of select="$prend"/></xsl:attribute>
    <xsl:apply-templates/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:if>
</xsl:copy>
</xsl:template>

<xsl:template match="math:mtext[@class='eqnarray']"/>

<xsl:template match="math:mtext[@class='eqnarray']" mode="label">
<xsl:copy>    <xsl:apply-templates/></xsl:copy>
</xsl:template>

<xsl:template match="math:mtable[@class='eqnarray']">
<xsl:copy>
  <xsl:attribute name="class">equation</xsl:attribute>
  <xsl:for-each select="math:mtr">
    <mlabeledtr>
     <mtd>
     <xsl:apply-templates select="math:mtd/math:mtext[@class='eqnarray']" mode="label"/>
     </mtd>
     <xsl:apply-templates select="math:mtd"/>
    </mlabeledtr>
  </xsl:for-each>
</xsl:copy>
</xsl:template>

<xsl:template match="math:mtable[@class='eqnarray-star']">
<xsl:copy>
  <xsl:attribute name="class">equation</xsl:attribute>
  <xsl:for-each select="math:mtr">
    <mlabeledtr>
     <mtd>
     <xsl:apply-templates select="math:mtd/math:mtext[@class='eqnarray']" mode="label"/>
     </mtd>
     <xsl:apply-templates select="math:mtd"/>
    </mlabeledtr>
  </xsl:for-each>
</xsl:copy>
</xsl:template>


</xsl:stylesheet>

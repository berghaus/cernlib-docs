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
<xsl:template match="*|@*|processing-instruction()">
 <xsl:copy>
  <xsl:apply-templates select="*|@*|processing-instruction()|text()"/>
 </xsl:copy>
</xsl:template>

<xsl:template match="text()">
    <xsl:value-of select="."/> <!-- could normalize() here -->
</xsl:template>

</xsl:stylesheet>

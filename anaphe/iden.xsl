<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  version="1.0"
>
<xsl:output  omit-xml-declaration="yes" cdata-section-elements="programlisting" 
indent="no" encoding="iso-8859-1"/>

<xsl:template match="*|@*|processing-instruction()">
 <xsl:copy>
  <xsl:apply-templates select="*|@*|processing-instruction()|comment()|text()"/>
 </xsl:copy>
</xsl:template>

<xsl:template match="text()">
    <xsl:value-of select="."/> <!-- could normalize() here -->
</xsl:template>

</xsl:stylesheet>

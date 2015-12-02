<?xml version='1.0'?>
<!-- makehtml.xsl --> 
<!DOCTYPE xsl:stylesheet [
<!ENTITY lt     "<"> 
<!ENTITY gt     ">"> 
<!ENTITY br     "\n">
<!ENTITY nbsp   "&#160;">
]>
<!-- XSL Style sheet, DTD omitted -->

<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/XSL/Transform/1.0"
	xmlns="http://www.w3.org/TR/REC-html40"
	default-space="preserve"
        result-ns="">

<xsl:template match="/">
<xsl:apply-templates/>
</xsl:template>

<!-- ===================== Header element ================= -->
<xsl:template match="header">
<TITLE><xsl:value-of select="title"/></TITLE>
<xsl:element name="META">
<xsl:attribute name="NAME">description</xsl:attribute>
<xsl:attribute name="CONTENT">
  <xsl:value-of select="title"/>
</xsl:attribute>
</xsl:element>
<xsl:element name="META">
<xsl:attribute name="NAME">keywords</xsl:attribute>
<xsl:attribute name="CONTENT">
  <xsl:value-of select="keywords"/>
</xsl:attribute>
</xsl:element>
<H2><xsl:value-of select="identifier"/>: 
    <xsl:value-of select="title"/>
</H2>
<table border="1" width="100%">
<tr>
  <td width="50%" align="left">
    <b>Author(s): </b> <xsl:value-of select="author"/>
  </td>
  <td width="50%" align="right">
    <b>Library: </b> <xsl:value-of select="library"/>
  </td>
</tr>
<tr>
  <td width="50%" align="left">
    <b>Contact: </b> 
    <xsl:choose>    
      <xsl:when test="contact/url">
        <xsl:element name="A">
         <xsl:attribute name="HREF">
          <xsl:value-of select="contact/url"/>
         </xsl:attribute>
         <xsl:value-of select="contact/name"/>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="contact/name"/>
      </xsl:otherwise>
    </xsl:choose>    
  </td>
  <td width="50%" align="right">
    <b>Version: </b> <xsl:value-of select="version"/>
  </td>
</tr>
<tr>
  <td width="50%" align="left">
    <b>Language: </b> <xsl:value-of select="language"/>
  </td>
  <td width="50%" align="right">
    <b>Last mod.: </b> <xsl:value-of select="modified"/>
  </td>
</tr>
</table>

<DL>
<DT><B>Dependencies:</B></DT> 
<DD><xsl:value-of select="dependencies"/></DD>
<DT><B>Keywords:</B></DT>
<DD><xsl:value-of select="keywords"/></DD>
</DL>
<P>
<HR />
</P>
</xsl:template>

<xsl:template match="abstract">
<H3>Abstract</H3>
<P><xsl:apply-templates/></P>
</xsl:template>

<!-- ===== Other information ===== -->
<xsl:template match="moreinfo">
<H3>More information</H3>
<UL>
<xsl:apply-templates/>
</UL>
</xsl:template>
<xsl:template match="ugurl">
<LI><B>
<xsl:element name="A">
<xsl:attribute name="HREF">
<xsl:value-of select="."/>
</xsl:attribute>
User Guide.
</xsl:element>
</B></LI>
</xsl:template>

<!-- ===== otehr bits and pieces ===== -->
<xsl:template match="par">
<P>
<xsl:apply-templates/>
</P>
</xsl:template>

<xsl:template match="q">
<xsl:text>"</xsl:text>
<xsl:apply-templates/>
<xsl:text>"</xsl:text>
</xsl:template>



</xsl:stylesheet>


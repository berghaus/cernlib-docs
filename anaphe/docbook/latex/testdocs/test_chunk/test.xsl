<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: test.xsl,v 1.2 2001/04/16 16:00:02 rcasellas Exp $
 |- #############################################################################
 |	$Author: rcasellas $												
 |														
 + ############################################################################## -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xt="http://www.jclark.com/xt"
                xmlns:saxon="http://icl.com/saxon"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:xalanredirect="org.apache.xalan.xslt.extensions.Redirect"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                extension-element-prefixes="xt" version='1.0'>

<xsl:import href="../../docbook.xsl"/>
<xsl:output method="text" encoding="ISO-8859-1" indent="yes"/>
<xsl:variable name="latex.math.support">0</xsl:variable>
<xsl:variable name="latex.use.babel">0</xsl:variable>
<xsl:variable name="latex.use.isolatin1">0</xsl:variable>
<xsl:variable name="latex.use.hyperref">0</xsl:variable>
<xsl:variable name="latex.use.fancyvrb">0</xsl:variable>
<xsl:variable name="latex.use.fancyhdr">0</xsl:variable>
<xsl:variable name="latex.use.subfigure">0</xsl:variable>
<xsl:variable name="latex.use.times">0</xsl:variable>



<!-- WRITE CHUNK, (c) Nwalsh --> 
<xsl:template name="write.chunk">
  <xsl:param name="filename" select="''"/>
  <xsl:param name="method" select="'text'"/>
  <xsl:param name="indent" select="'no'"/>
  <xsl:param name="content" select="''"/>

  <xsl:message>
    <xsl:text>Writing </xsl:text>
    <xsl:value-of select="$filename"/>
    <xsl:if test="name(.) != ''">
      <xsl:text> for </xsl:text>
      <xsl:value-of select="name(.)"/>
    </xsl:if>
  </xsl:message>

  <xsl:variable name="vendor" select="system-property('xsl:vendor')"/>

  <xsl:choose>
    <xsl:when test="contains($vendor, 'SAXON 6.2')">
      <!-- Saxon 6.2.x uses xsl:document
	<xsl:message>Using SAXON 6.2.X</xsl:message>
      <xsl:document href="{$filename}"
                    method="{$method}"
                    encoding="{$encoding}"
                    indent="{$indent}">
        <xsl:copy-of select="$content"/>
      </xsl:document> -->
    </xsl:when>
    <xsl:when test="contains($vendor, 'SAXON')">
      <!-- Saxon uses saxon:output -->
	<xsl:message>Using SAXONY</xsl:message>
      <saxon:output file="{$filename}"
                    href="{$filename}"
                    method="{$method}"
                    encoding="{$encoding}"
                    indent="{$indent}">
        <xsl:copy-of select="$content"/>
      </saxon:output>
    </xsl:when>
    <xsl:when test="contains($vendor, 'Apache')">
	<xsl:message>Using XALAN</xsl:message>
      <xalanredirect:write file="{$filename}">
        <xsl:value-of select="$content"/>
      </xalanredirect:write>
    </xsl:when>
    <xsl:otherwise>
	<xsl:message>Using OTHER</xsl:message>
		<!-- When using XT , Buggy ??
	      <xt:document href="{$filename}">
        		<xsl:copy-of select="$content"/>
		</xt:document>
		-->
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>




<xsl:template match="chapter">
<xsl:text>% -------------------------------------------------------------&#10;</xsl:text>
<xsl:text>% Chapter </xsl:text><xsl:value-of select="title"/><xsl:text>  &#10;</xsl:text>
<xsl:text>% -------------------------------------------------------------&#10;</xsl:text>
<xsl:text>\InputIfFileExists{</xsl:text><xsl:value-of select="@id"/><xsl:text>}</xsl:text>
<xsl:text>{\typeout{Using file </xsl:text><xsl:value-of select="@id"/><xsl:text>.tex}}</xsl:text>
<xsl:text>{\typeout{WARNING file </xsl:text><xsl:value-of select="@id"/>
<xsl:text>.tex NOT FOUND!}}&#10;</xsl:text>

<xsl:variable name="filename"><xsl:text>./</xsl:text><xsl:value-of select="./@id"/><xsl:text>.tex</xsl:text></xsl:variable>
<xsl:call-template name="write.chunk">
    <xsl:with-param name="filename" select="$filename"/>
    <xsl:with-param name="content">
		<xsl:call-template name="map.begin"/>
		<xsl:apply-templates/>
		<xsl:call-template name="map.end"/>
    </xsl:with-param>
</xsl:call-template>
</xsl:template>



</xsl:stylesheet>

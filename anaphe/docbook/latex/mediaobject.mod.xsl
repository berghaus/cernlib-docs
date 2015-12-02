<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: mediaobject.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
 |- #############################################################################
 |	$Author: rcasellas $												
 |														
 |   PURPOSE: Manage Imageobject related tags.
 + ############################################################################## -->

<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
	exclude-result-prefixes="doc" version='1.0'>



<!--############################################################################# -->
<!-- DOCUMENTATION                                                                -->
<doc:reference id="mediaobject" xmlns="">
	<referenceinfo>
	<releaseinfo role="meta">
		$Id: mediaobject.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
	</releaseinfo>
	<author>
		<surname>Casellas</surname>
		<firstname>Ramon</firstname>
	</author>
	<copyright>
		<year>2000</year>
		<year>2001</year>
		<holder>Ramon Casellas</holder>
	</copyright>
	</referenceinfo>
	
	<title>MediaObjects <filename>mediaobject.mod.xsl</filename></title>
	<partintro>
		<section><title>Introduction</title>
		<para></para>
		</section>
	</partintro>
</doc:reference>



<xsl:template match="videoobject">
  	<xsl:apply-templates select="videodata"/>
</xsl:template>
<xsl:template match="audioobject">
  	<xsl:apply-templates select="audiodata"/>
</xsl:template>
<xsl:template match="textobject">
  	<xsl:apply-templates/>
</xsl:template>


<xsl:template match="mediaobject">
<xsl:variable name="imageobjectscnt" select="count(child::imageobject)"/>
<xsl:choose>
	<xsl:when test="$imageobjectscnt > 1">
		<xsl:text>\mbox {&#10;</xsl:text>
		<xsl:apply-templates select="imageobject"/>
		<xsl:text>}&#10;</xsl:text>
	</xsl:when>
	<xsl:otherwise>
		<xsl:apply-templates select="imageobject"/>
	</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="inlinemediaobject">
<xsl:variable name="imageobjectscnt" select="count(child::imageobject)"/>
<xsl:choose>
	<xsl:when test="$imageobjectscnt > 1">
		<xsl:text>\mbox {&#10;</xsl:text>
		<xsl:apply-templates select="imageobject"/>
		<xsl:text>}&#10;</xsl:text>
	</xsl:when>
	<xsl:otherwise>
		<xsl:apply-templates select="imageobject"/>
	</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="imageobject">
  	<xsl:apply-templates select="imagedata"/>
</xsl:template>








<xsl:template match="imagedata">
<xsl:variable name="filename" select="@fileref"> </xsl:variable>
<xsl:variable name="ext">
	<xsl:call-template name="filename-extension">
	<xsl:with-param name="filename" select="$filename"/>
	</xsl:call-template>
</xsl:variable>
<xsl:if test="count(../../imageobject) &gt; 1">
		<xsl:text>\subfigure[</xsl:text><xsl:value-of select="../@role"/><xsl:text>]</xsl:text>
</xsl:if>
<xsl:text>{\includegraphics[width=.</xsl:text>
<xsl:choose>
	<xsl:when test="@scale"> 
		<xsl:value-of select="normalize-space(@scale)"/><xsl:text>\linewidth</xsl:text>
	</xsl:when>
	<xsl:otherwise><xsl:text>45\linewidth</xsl:text></xsl:otherwise>
</xsl:choose>
<xsl:choose>
	<xsl:when test="@format = 'PRN'"><xsl:text>, angle=270</xsl:text></xsl:when>
</xsl:choose>
<xsl:text>]{</xsl:text>
<xsl:choose><!-- package graphicx and DeclareGraphicExtensions will take care of this -->
	<xsl:when test="$ext != ''">
		<xsl:value-of select="$filename"/>
	</xsl:when>
	<xsl:otherwise> 
		<xsl:value-of select="$filename"/>
	</xsl:otherwise>
</xsl:choose>
<xsl:text>}}\quad&#10;</xsl:text>
</xsl:template>



<xsl:template match="videodata">
	<xsl:variable name="filename">
    		<xsl:call-template name="mediaobject.filename"><xsl:with-param name="object" select=".."/>
    		</xsl:call-template>
  	</xsl:variable>
  	<xsl:variable name="alt">
    		<xsl:apply-templates select="(../../textobject/phrase)[1]"/>
  	</xsl:variable>
</xsl:template>

<xsl:template match="audiodata">
	<xsl:variable name="filename">
    		<xsl:call-template name="mediaobject.filename"><xsl:with-param name="object" select=".."/>
    		</xsl:call-template>
  	</xsl:variable>
  	<xsl:variable name="alt">
    		<xsl:apply-templates select="(../../textobject/phrase)[1]"/>
	</xsl:variable>
</xsl:template>


<xsl:template match="caption">
    <xsl:apply-templates/>
</xsl:template>

</xsl:stylesheet>

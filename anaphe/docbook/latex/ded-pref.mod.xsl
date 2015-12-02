<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: ded-pref.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
 |- #############################################################################
 |	$Author: rcasellas $
 |														
 |   PURPOSE:
 + ############################################################################## -->

<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
	exclude-result-prefixes="doc" version='1.0'>



<!--############################################################################# -->
<!-- DOCUMENTATION                                                                -->
<doc:reference id="ded-pref" xmlns="">
	<referenceinfo>
	<releaseinfo role="meta">
		$Id: ded-pref.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
	
	<title>Dedication and Preface <filename>ded-pref.mod.xsl</filename></title>
	<partintro>
		<section><title>Introduction</title>
		<para></para>
		</section>
	</partintro>
</doc:reference>




<xsl:template match="dedication">
<xsl:text>% -------------------------------------------------------------&#10;</xsl:text>
<xsl:text>% Dedication	 &#10;</xsl:text>
<xsl:text>% -------------------------------------------------------------&#10;</xsl:text>
<xsl:call-template name="label.id"/>
<xsl:text>\newpage&#10;</xsl:text>
<xsl:call-template name="dedication.title"/>
<xsl:call-template name="dedication.subtitle"/>
<xsl:apply-templates/>
</xsl:template>


<xsl:template name="dedication.title">
<xsl:text>&#10;{\sc </xsl:text><xsl:apply-templates select="." mode="title.ref"/><xsl:text>}&#10;</xsl:text>
</xsl:template>

<xsl:template name="dedication.subtitle">
<xsl:variable name="subtitle"> <xsl:apply-templates select="." mode="subtitle.content"/> </xsl:variable>
<xsl:if test="$subtitle != ''">
	<xsl:text>{\sc </xsl:text><xsl:copy-of select="$subtitle"/><xsl:text>}</xsl:text>
</xsl:if>
</xsl:template>

<xsl:template match="dedication/title"></xsl:template>
<xsl:template match="dedication/subtitle"></xsl:template>
<xsl:template match="dedication/titleabbrev"></xsl:template>

<xsl:template match="dedication/para">
<xsl:text>&#10;\paragraph*{}&#10;</xsl:text>  <!-- This is a fixme !! -->
<xsl:apply-templates/>
</xsl:template>

<!--############################################################################# 
 |	$Id: ded-pref.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
 |- #############################################################################
 |	$Author: rcasellas $
 |														
 |   PURPOSE:
 + ############################################################################## -->


<xsl:template match="preface">
<xsl:text>&#10;</xsl:text>
<xsl:text>% ------------------------------------------------------------&#10;</xsl:text>
<xsl:text>% Preface&#10;</xsl:text> 
<xsl:text>% ------------------------------------------------------------&#10;</xsl:text>
<xsl:call-template name="label.id"/>
<xsl:text>\newpage&#10;</xsl:text>
<xsl:call-template name="preface.title"/>
<xsl:call-template name="preface.subtitle"/>
	<xsl:apply-templates/>
</xsl:template>



<xsl:template name="preface.title">
<xsl:call-template name="label.id"/>
<xsl:text>&#10;{\sc </xsl:text><xsl:apply-templates select="." mode="title.ref"/><xsl:text>}&#10;</xsl:text>
</xsl:template>

<xsl:template name="preface.subtitle">
<xsl:variable name="subtitle"><xsl:apply-templates select="." mode="subtitle.content"/></xsl:variable>
<xsl:if test="$subtitle != ''">
   	<xsl:text>{\sc</xsl:text><xsl:copy-of select="normalize-space($subtitle)"/><xsl:text>}</xsl:text>
</xsl:if>
</xsl:template>


<xsl:template match="preface/title"></xsl:template>
<xsl:template match="preface/titleabbrev"></xsl:template>
<xsl:template match="preface/subtitle"></xsl:template>
<xsl:template match="preface/docinfo|prefaceinfo"></xsl:template>

<xsl:template match="preface/para">
<xsl:text>&#10;\paragraph*{}&#10;</xsl:text>  <!-- This is a fixme !! -->
<xsl:apply-templates/>
</xsl:template>


<xsl:template match="preface/sect1">
<xsl:text>&#10;\section*{</xsl:text><xsl:copy-of select="normalize-space(title)"/>}<xsl:text>&#10;</xsl:text>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="preface/sect1/sect2">
<xsl:text>&#10;\subsection*{</xsl:text><xsl:copy-of select="normalize-space(title)"/>}<xsl:text>&#10;</xsl:text>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="preface/sect1/sect2/sect3">
<xsl:text>&#10;\subsubsection*{</xsl:text><xsl:copy-of select="normalize-space(title)"/>}<xsl:text>&#10;</xsl:text>
<xsl:apply-templates/>
</xsl:template>


</xsl:stylesheet>


<?xml version='1.0'?>
<!--#############################################################################
 |      $Id: latex.mapping.xsl,v 1.2 2001/05/01 17:34:52 rcasellas Exp $
 |- #############################################################################
 |      $Author: rcasellas $
 |
 |   PURPOSE:
 + ############################################################################## -->

<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
        exclude-result-prefixes="doc" version='1.0'>

<xsl:variable name="latex.mapping.xml" select="document('latex.mapping.xml')"/>


<!--############################################################################# -->
<!-- DOCUMENTATION                                                                -->
<doc:reference id="glossary" xmlns="">
<referenceinfo>
<releaseinfo role="meta">
    $Id: latex.mapping.xsl,v 1.2 2001/05/01 17:34:52 rcasellas Exp $
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
<title>Glossary <filename>glossary.mod.xsl</filename></title>
<partintro>
    <section><title>Introduction</title>
    <para></para>
    </section>
</partintro>
</doc:reference>
<!--############################################################################# -->


<!--############################################################################# -->
<!-- DOCUMENTATION -->
<doc:template name="latex.mapping" xmlns="">
<refpurpose></refpurpose>
<refdescription>
<para></para>
<formalpara><title>Remarks and Bugs</title>
<itemizedlist>
</itemizedlist>
</formalpara>
<formalpara><title>Default Behaviour</title>
<screen></screen>
</formalpara>
</refdescription>
</doc:template>
<!--############################################################################# -->



<xsl:template name="latex.mapping">
<xsl:param name="object"  select="."/>
<xsl:param name="keyword" select="local-name($object)"/>
<xsl:param name="role" 	  select="begin"/>
<xsl:param name="string"><xsl:value-of select="$object/title"/></xsl:param>
<xsl:param name="use.label"	select="1"/>
<xsl:param name="use.hypertarget" 	select="1"/>
<xsl:variable name="id">
	<xsl:choose>
	<xsl:when test="$object/@id"> <xsl:value-of select="$object/@id"/> </xsl:when>
	<xsl:otherwise> <xsl:value-of select="generate-id($object)"/> </xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="title">
	<xsl:choose>
	<xsl:when test="$string=''">
		<xsl:call-template name="gentext.element.name"/>
	</xsl:when>
	<xsl:otherwise>
		<xsl:value-of select="$string"/>
	</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="latex.mapping.node" 
	select="($latex.mapping.xml/latexbindings/latexmapping[@role=$role]/mapping[@key=$keyword])"/>
<xsl:choose>
	<xsl:when test="$latex.mapping.node/@text!=''">
			<xsl:call-template name="string-replace">
                		<xsl:with-param name="to"><xsl:value-of select="$id"/></xsl:with-param>
                		<xsl:with-param name="from">%id</xsl:with-param>
                		<xsl:with-param name="string">
				<xsl:call-template name="string-replace">
                			<xsl:with-param name="to"><xsl:value-of select="$title"/></xsl:with-param>
                			<xsl:with-param name="from">%title</xsl:with-param>
                			<xsl:with-param name="string">
						<xsl:value-of select="$latex.mapping.node/@text"/>
					</xsl:with-param>
				</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
		<xsl:for-each select="$latex.mapping.node/line">
			<xsl:call-template name="string-replace">
                		<xsl:with-param name="to"><xsl:value-of select="$id"/></xsl:with-param>
                		<xsl:with-param name="from">%id</xsl:with-param>
                		<xsl:with-param name="string">
				<xsl:call-template name="string-replace">
                			<xsl:with-param name="to"><xsl:value-of select="$title"/></xsl:with-param>
                			<xsl:with-param name="from">%title</xsl:with-param>
                			<xsl:with-param name="string" select="."/>
				</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:otherwise>
</xsl:choose>
</xsl:template>




<xsl:template name="map.begin">
<xsl:param name="object"  select="."/>
<xsl:param name="keyword" select="local-name($object)"/>
<xsl:param name="string"><xsl:value-of select="$object/title"/></xsl:param>
<xsl:call-template name="latex.mapping">
	<xsl:with-param name="keyword" select="$keyword"/>
	<xsl:with-param name="role">begin</xsl:with-param>
	<xsl:with-param name="string" select="$string"/>
</xsl:call-template>
</xsl:template>

<xsl:template name="map.end">
<xsl:param name="object"  select="."/>
<xsl:param name="keyword" select="local-name($object)"/>
<xsl:param name="role" 	  select="begin"/>
<xsl:param name="string"><xsl:value-of select="$object/title"/></xsl:param>
<xsl:call-template name="latex.mapping">
	<xsl:with-param name="keyword" select="$keyword"/>
	<xsl:with-param name="string" select="$string"/>
	<xsl:with-param name="role">end</xsl:with-param>
</xsl:call-template>
</xsl:template>

</xsl:stylesheet>


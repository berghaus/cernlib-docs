<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: figure.mod.xsl,v 1.3 2001/05/01 17:34:52 rcasellas Exp $
 |- #############################################################################
 |	$Author: rcasellas $												
 |														
 |   PURPOSE: Template for figure tag.
 + ############################################################################## -->

<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
	exclude-result-prefixes="doc" version='1.0'>
 
<!--############################################################################# -->
<!-- DOCUMENTATION                                                                -->
<doc:reference id="figure" xmlns="">
	<referenceinfo>
	<releaseinfo role="meta">
		$Id: figure.mod.xsl,v 1.3 2001/05/01 17:34:52 rcasellas Exp $
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
	
	<title>Figures and InformalFigures <filename>figure.mod.xsl</filename></title>
	<partintro>
		<section><title>Introduction</title>
		<para></para>
		</section>
	</partintro>
</doc:reference>
<!--############################################################################# -->




<!--############################################################################# -->
<doc:template match="figure|informalfigure" xmlns="">
	<refpurpose> XSL template for figure|informalfigure  </refpurpose>
	<refdescription>
		<para>Outputs <literal>\begin{figure}</literal>,
		applies templates and outputs <literal>\end{figure}</literal>. </para>
		<formalpara><title>Remarks and Bugs</title>
		<itemizedlist>
		</itemizedlist>
		</formalpara>
	</refdescription>
</doc:template>
<!--############################################################################# -->

<xsl:template match="figure|informalfigure">
<xsl:call-template name="map.begin"/>
<xsl:apply-templates/>
<xsl:call-template name="map.end"/>
</xsl:template>







<!--############################################################################# -->
<doc:template match="figure[programlisting]" xmlns="">
	<refpurpose> XSL template for programlisting within a figure </refpurpose>
	<refdescription>
		<para>Outputs <literal>\begin{figure}</literal>,
		applies templates and outputs <literal>\end{abstract}</literal>. </para>
		<formalpara><title>Remarks and Bugs</title>
		<itemizedlist>
		</itemizedlist>
		</formalpara>
	</refdescription>
</doc:template>
<!--############################################################################# -->

<xsl:template match="figure[programlisting]">
<xsl:call-template name="map.begin">
	<xsl:with-param name="keyword" select="programlisting"/>
</xsl:call-template>
<xsl:apply-templates />
<xsl:call-template name="map.end">
	<xsl:with-param name="keyword" select="programlisting"/>
</xsl:call-template>
</xsl:template>

<xsl:template match="figure/title"/>
<xsl:template match="informalfigure/title"/>
</xsl:stylesheet>

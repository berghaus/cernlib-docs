<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: admonition.mod.xsl,v 1.4 2001/05/01 17:34:52 rcasellas Exp $		
 |- #############################################################################
 |	$Author: rcasellas $
 |
 |   PURPOSE: Admonition templates. 
 + ############################################################################## -->
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
	exclude-result-prefixes="doc" version='1.0'>


<!--############################################################################# -->
<!-- DOCUMENTATION                                                                -->
<doc:reference id="admonition" xmlns="">
	<referenceinfo>
	<releaseinfo role="meta">
		$Id: admonition.mod.xsl,v 1.4 2001/05/01 17:34:52 rcasellas Exp $
	</releaseinfo>
	<author>
		<surname>Casellas</surname>
		<firstname>Ramon</firstname>
	</author>
	<copyright><year>2000</year>
		<holder>Ramon Casellas</holder>
	</copyright>
	</referenceinfo>
	
	<title>Admonition XSL Variables and Templates</title>

	<partintro>
		<section><title>Introduction</title>
		<para>This reference describes the templates and parameters relevant
		to formatting DocBook Admonitions markup. The </para>
		</section>
	</partintro>
</doc:reference>

<!--############################################################################# -->
<!-- DOCUMENTATION                                                                -->
<doc:param name="latex.admonition.environment" xmlns="">
	<refpurpose> 
	Declares a new environment to be used in admonition tags (warning, tip, important
	caution, note).
	</refpurpose>
	<refdescription>
		<para>This parameter is a text variable that is appended in the text document.
		You can use it to define your own environment for admonitions. See the stylesheets
		to know the default value. It requires the use of the fancybox package. 
		You can redefine this parameter in your stylesheet. The first argument is
		the associated filename (e.g $latex.admonition.path/warning) and the second
		argument is the admonition title (if any) or the associated generic text.
		</para>
		<para> When processing the admonition tag, the following code is generated: </para>
		<programlisting>
		\begin{admonition}{figures/warning}{My WARNING}
		....
		\end{admonition}
		</programlisting>
	</refdescription>
</doc:param>
<!--############################################################################# -->

<xsl:variable name="latex.admonition.environment">
<xsl:text>\newenvironment{admminipage}{\begin{Sbox}\begin{minipage}}{\end{minipage}\end{Sbox}\fbox{\TheSbox}}&#10;</xsl:text>
<xsl:text>\newlength{\admlength}&#10;</xsl:text>
<xsl:text>\newenvironment{admonition}[2] {&#10;</xsl:text>
<xsl:text> \hspace{0mm}\newline&#10;</xsl:text>
<xsl:text> \noindent&#10;</xsl:text>
<xsl:text> \vspace{8mm} &#10;</xsl:text>
<xsl:text> \setlength{\fboxsep}{5pt}&#10;</xsl:text>
<xsl:text> \setlength{\admlength}{\linewidth}&#10;</xsl:text>
<xsl:text> \addtolength{\admlength}{-10\fboxsep}&#10;</xsl:text>
<xsl:text> \addtolength{\admlength}{-10\fboxrule}&#10;</xsl:text>
<xsl:text> \vspace{3mm}&#10;</xsl:text>
<xsl:text> \admminipage{\admlength}&#10;</xsl:text>
<xsl:text> \setlength{\abovedisplayskip}{2pt}&#10;</xsl:text>
<xsl:text> \setlength{\belowdisplayskip}{20pt}&#10;</xsl:text>
<xsl:text> {\bf \sc\large{#2}} \newline&#10;</xsl:text>
<xsl:text> \vspace{1cm}&#10;</xsl:text>
<xsl:text> \sffamily&#10;</xsl:text>
<xsl:text> \includegraphics[width=15mm]{#1}\hspace{1cm}&#10;</xsl:text>
<xsl:text> \begin{minipage}[lt]{0.8\admlength}&#10;</xsl:text>
<xsl:text>}{&#10;</xsl:text>
<xsl:text> \end{minipage}&#10;</xsl:text>
<xsl:text> \endadmminipage&#10;</xsl:text>
<xsl:text> \newline&#10;</xsl:text>
<xsl:text> \vspace{5mm} &#10;</xsl:text>
<xsl:text>}&#10;</xsl:text>
</xsl:variable>

<xsl:template name="admon.graphic">
<xsl:param name="node" select="."/>
<xsl:choose>
    <xsl:when test="name($node)='note'">note</xsl:when>
    <xsl:when test="name($node)='warning'">warning</xsl:when>
    <xsl:when test="name($node)='caution'">caution</xsl:when>
    <xsl:when test="name($node)='tip'">tip</xsl:when>
    <xsl:when test="name($node)='important'">important</xsl:when>
    <xsl:otherwise>note</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!--############################################################################# -->
<!-- DOCUMENTATION                                                                -->
<doc:template match="note|important|warning|caution|tip " xmlns="">
	<refpurpose> XSL Template for admonitions </refpurpose>
	<refdescription>
		<para> The latex.admonition.environment is output at the document preamble.
		
		</para>
		<formalpara><title>Remarks and Bugs</title>
		<itemizedlist>
		</itemizedlist>
		</formalpara>
	</refdescription>
</doc:template>
<!--############################################################################# -->

<xsl:template match="note|important|warning|caution|tip">
<xsl:call-template name="map.begin">
	<xsl:with-param name="keyword">admonition</xsl:with-param>
	<xsl:with-param name="string">
		<xsl:text>{</xsl:text>
		<xsl:value-of select="$latex.admonition.path"/><xsl:text>/</xsl:text>
		<xsl:call-template name="admon.graphic"/>
		<xsl:text>}{</xsl:text>
		<xsl:choose> 
			<xsl:when test="title">
				<xsl:call-template name="normalize-scape">
				<xsl:with-param name="string" select="title"/></xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="gentext.element.name"/>
			</xsl:otherwise> 
		</xsl:choose>
		<xsl:text>}</xsl:text>
	</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates/>
<xsl:call-template name="map.end">
	<xsl:with-param name="keyword">admonition</xsl:with-param>
</xsl:call-template>
</xsl:template>

<!-- Empty title template -->
<xsl:template match="note/title|important/title|warning/title|caution/title|tip/title"/>

</xsl:stylesheet>

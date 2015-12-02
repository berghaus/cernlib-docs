<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: book-article.mod.xsl,v 1.3 2001/05/01 17:34:52 rcasellas Exp $
 |- #############################################################################
 |	$Author: rcasellas $												
 |														
 |   PURPOSE:
 |	This template matches a book / article
 + ############################################################################## -->

<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
	exclude-result-prefixes="doc" version='1.0'>



<!--############################################################################# -->
<!-- DOCUMENTATION                                                                -->
<doc:reference id="book-article" xmlns="">
	<referenceinfo>
	<releaseinfo role="meta">
		$Id: book-article.mod.xsl,v 1.3 2001/05/01 17:34:52 rcasellas Exp $
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
	
	<title>Books and Articles <filename>book-article.mod.xsl</filename></title>
	<partintro>
		<section><title>Introduction</title>
		<para></para>
		</section>
	</partintro>
</doc:reference>


<!--############################################################################# -->
<!-- DOCUMENTATION -->
<doc:template id="tmpl:book" match="book" xmlns="">
	<refpurpose>Book XSL Template</refpurpose>
	<refdescription>
		<para> Most DocBook documents are either articles or books, so the book 
		XSL template <xref linkend="book"/> is one classical entry point 
		when processign docbook documents.</para>
		
		<formalpara><title>Tasks</title>
		<itemizedlist>
		<listitem><para></para></listitem>
		</itemizedlist>
		</formalpara>
		
		<formalpara><title>Remarks and Bugs</title>
		<itemizedlist>
		<listitem><para> EMPTY templates: book/title and book/subtitle</para></listitem>
		</itemizedlist>
		</formalpara>
	</refdescription>
	<refparameter>
		<variablelist>
		<varlistentry>
			<term>colwidth</term>
			<listitem>
			<para>The CALS column width specification.</para>
			</listitem>
		</varlistentry>
		</variablelist>
	</refparameter>
	<refreturn>
		:<para>Outputs the LaTeX Code corresponding to a book.</para>
	</refreturn>
</doc:template>
<!--############################################################################# -->

<!-- XSL TEMPLATE -->
<xsl:template match="book">
<xsl:call-template name="generate.latex.book.preamble"/>
<!-- Output title information -->
<xsl:text>\title{</xsl:text>
	<xsl:choose>
            <xsl:when test="./title">
			<xsl:value-of select="normalize-space(./title)"/>
            </xsl:when>
            <xsl:otherwise>
			<xsl:value-of select="normalize-space(./bookinfo/title)"/>
            </xsl:otherwise>
	</xsl:choose>
<xsl:text>}&#10;</xsl:text>
<!-- Output author information -->
<xsl:text>\author{</xsl:text>
	<xsl:choose>
            <xsl:when test="bookinfo/authorgroup">
      		<xsl:apply-templates select="bookinfo/authorgroup"/>
            </xsl:when>
            <xsl:otherwise>
      		<xsl:apply-templates select="bookinfo/author"/>
            </xsl:otherwise>
	</xsl:choose>
<xsl:text>}&#10;</xsl:text>

<xsl:value-of select="$latex.book.afterauthor"/>
<xsl:text>&#10;\setcounter{tocdepth}{</xsl:text><xsl:value-of select="$toc.section.depth"/><xsl:text>}&#10;</xsl:text>
<xsl:text>&#10;\setcounter{secnumdepth}{</xsl:text><xsl:value-of select="$section.depth"/><xsl:text>}&#10;</xsl:text>
<xsl:value-of select="$latex.book.begindocument"/>
<!-- Include external Cover page if specified -->
<xsl:text>&#10;\InputIfFileExists{</xsl:text><xsl:value-of select="$latex.titlepage.file"/>
<xsl:text>}{\typeout{WARNING: Using cover page</xsl:text>
<xsl:value-of select="$latex.titlepage.file"/>
<xsl:text>}}</xsl:text>
<xsl:text>{\maketitle}&#10;</xsl:text>

<!-- APPLY TEMPLATES -->
<xsl:apply-templates/>
<xsl:call-template name="map.end"/>
</xsl:template>


<!-- EMPTY TEMPLATES -->
<xsl:template match="book/title"/>
<xsl:template match="book/subtitle"/>
<xsl:template match="book/bookinfo/title"/>

<!-- Only process revision history by now in bookinfo -->
<xsl:template match="book/bookinfo">
    <xsl:apply-templates select="revhistory" />
</xsl:template>


<!--############################################################################# 
 |	$Id: book-article.mod.xsl,v 1.3 2001/05/01 17:34:52 rcasellas Exp $
 |- #############################################################################
 |	$Author: rcasellas $												
 |														
 |   PURPOSE: Template for articles.
 |   
 + ############################################################################## -->

<!--############################################################################# -->
<!-- DOCUMENTATION -->
<doc:template match="article" xmlns="">
	<refpurpose>Article XSL Template</refpurpose>
	<refdescription>
		<para> Most DocBook documents are either articles or books, so the article
		XSL template <xref linkend="tmpl:article"/> is one classical entry point 
		when processign docbook documents.</para>
		
		<formalpara><title>Tasks</title>
		<itemizedlist>
		<listitem><para>Calls <literal>generate.latex.article.preamble</literal>.</para></listitem>
		<listitem><para>Outputs \title, \author, getting the information from its children.</para></listitem>
		<listitem><para>Calls <literal>latex.article.begindocument</literal>.</para></listitem>
		<listitem><para>Calls <literal>latex.article.maketitle.</literal></para></listitem>
		<listitem><para>Applies templates.</para></listitem>
		<listitem><para>Calls <literal>latex.article.end</literal> template.</para></listitem>
		</itemizedlist>
		</formalpara>
		
		<formalpara><title>Remarks and Bugs</title>
		<itemizedlist>
		<listitem><para> EMPTY templates: article/title and article/subtitle</para></listitem>
		</itemizedlist>
		</formalpara>
	</refdescription>
	<refparameter>
		<variablelist>
		<varlistentry>
			<term>colwidth</term>
			<listitem>
			<para>The CALS column width specification.</para>
			</listitem>
		</varlistentry>
		</variablelist>
	</refparameter>
	<refreturn>
		<para>Outputs the LaTeX Code corresponding to an article.</para>
	</refreturn>
</doc:template>
<!--############################################################################# -->


<!-- ARTICLE TEMPLATE -->
<xsl:template match="article">
<!-- Output LaTeX preamble -->
<xsl:call-template name="generate.latex.article.preamble"/>
<!-- Get and output article title -->
<xsl:variable name="article.title">
<xsl:choose>
	<xsl:when test="./title"> <xsl:value-of select="./title"/> </xsl:when>
      <xsl:when test="./articleinfo/title"> <xsl:value-of select="./articleinfo/title"/> </xsl:when>
      <xsl:otherwise> <xsl:value-of select="./artheader/title"/> </xsl:otherwise>
</xsl:choose>
</xsl:variable>
<xsl:text>\title{</xsl:text>
<xsl:call-template name="normalize-scape"> 
	<xsl:with-param name="string" select="$article.title"/>
</xsl:call-template>
<xsl:text>}&#10;</xsl:text>
<!-- Display author information --> 
<xsl:text>\author{</xsl:text>
<xsl:choose>
	<xsl:when test="artheader/author">		<xsl:apply-templates select="artheader/author"/>	</xsl:when>
	<xsl:when test="artheader/authorgroup">	<xsl:apply-templates select="artheader/authorgroup"/>	</xsl:when>
      <xsl:when test="articleinfo/author">	<xsl:apply-templates select="articleinfo/author"/>	</xsl:when>
	<xsl:when test="articleinfo/authorgroup">	<xsl:apply-templates select="articleinfo/authorgroup"/></xsl:when>
      <xsl:otherwise><xsl:apply-templates select="author"/></xsl:otherwise>
</xsl:choose>
<xsl:text>}&#10;</xsl:text>
<!-- Display  begindocument command -->
<xsl:value-of select="$latex.article.begindocument"/>
<xsl:value-of select="$latex.article.maketitle"/>
<xsl:apply-templates/>
<xsl:value-of select="$latex.article.end"/>
</xsl:template>



<xsl:template match="article/artheader|article/articleinfo">
    <xsl:apply-templates select="abstract"/>
</xsl:template>

<!-- EMPTY TEMPLATES -->
<xsl:template match="article/title"/>
<xsl:template match="article/subtitle"/>

<!--############################################################################# 
 |	$Id: book-article.mod.xsl,v 1.3 2001/05/01 17:34:52 rcasellas Exp $
 |- #############################################################################
 |	$Author: rcasellas $
 |														
 |   PURPOSE: Table of Contents, Figures, ...
 + ############################################################################## -->

<xsl:template match="toc">
<xsl:text>&#10;</xsl:text>
<xsl:text>\tableofcontents&#10;</xsl:text>
<xsl:text>\listoffigures&#10;</xsl:text>
</xsl:template>

<xsl:template match="lot|lotentry">
<xsl:text>\listoftables&#10;</xsl:text>
</xsl:template>

<xsl:template match="lotentry"/>
<xsl:template match="tocpart|tocchap|tocfront|tocback|tocentry"/>
<xsl:template match="toclevel1|toclevel2|toclevel3|toclevel4|toclevel5"/>
</xsl:stylesheet>

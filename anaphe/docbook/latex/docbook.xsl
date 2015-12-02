<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: docbook.xsl,v 1.2 2001/05/01 17:34:52 rcasellas Exp $		
 |- #############################################################################
 |	$Author: rcasellas $												
 |														
 |   PURPOSE: 
 | 	This is the "parent" stylesheet. The used "modules" are included here.
 |	output encoding text in ISO-8859-1 indented.
 + ############################################################################## -->

<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
	exclude-result-prefixes="doc" version='1.0'>
 
<xsl:output method="text" encoding="ISO-8859-1" indent="yes"/>

<xsl:include href="../common/l10n.xsl"/>
<xsl:include href="../common/common.xsl"/>

<xsl:include href="VERSION.xml"/>
<xsl:include href="vars.mod.xsl"/>
<xsl:include href="latex.mapping.xsl"/>
<xsl:include href="preamble.mod.xsl"/>
<xsl:include href="font.mod.xsl"/>
<xsl:include href="labelid.mod.xsl"/>

<xsl:include href="book-article.mod.xsl"/>

<xsl:include href="ded-pref.mod.xsl"/>

<xsl:include href="part-chap-app.mod.xsl"/>

<xsl:include href="sections.mod.xsl"/>
<xsl:include href="bridgehead.mod.xsl"/>

<xsl:include href="abstract.mod.xsl"/>
<xsl:include href="biblio.mod.xsl"/>
<xsl:include href="revision.mod.xsl"/>

<xsl:include href="admonition.mod.xsl"/>
<xsl:include href="verbatim.mod.xsl"/>
<xsl:include href="email.mod.xsl"/>
<xsl:include href="sgmltag.mod.xsl"/>
<xsl:include href="citation.mod.xsl"/>
<xsl:include href="qandaset.mod.xsl"/>
<xsl:include href="procedure.mod.xsl"/>
<xsl:include href="lists.mod.xsl"/>
<xsl:include href="callout.mod.xsl"/>


<xsl:include href="figure.mod.xsl"/>
<xsl:include href="graphic.mod.xsl"/>
<xsl:include href="mediaobject.mod.xsl"/>

<xsl:include href="index.mod.xsl"/>


<xsl:include href="xref.mod.xsl"/>
<xsl:include href="formal.mod.xsl"/>
<xsl:include href="example.mod.xsl"/>
<xsl:include href="table.mod.xsl"/>
<xsl:include href="inline.mod.xsl"/>
<xsl:include href="programlisting.mod.xsl"/>
<xsl:include href="authorgroup.mod.xsl"/>
<xsl:include href="dingbat.mod.xsl"/>
<xsl:include href="info.mod.xsl"/>
<xsl:include href="keywords.mod.xsl"/>
<xsl:include href="refentry.mod.xsl"/>
<xsl:include href="component.mod.xsl"/>
<xsl:include href="glossary.mod.xsl"/>
<xsl:include href="block.mod.xsl"/>


<xsl:include href="synop-oop.mod.xsl"/>
<xsl:include href="synop-struct.mod.xsl"/>

<xsl:include href="pi.mod.xsl"/>

<xsl:include href="footnote.mod.xsl"/>

<xsl:include href="texmath.mod.xsl"/>
<xsl:include href="mathelem.mod.xsl"/>
<xsl:include href="mathml/mathml.mod.xsl"/>
<xsl:include href="mathml/mathml.presentation.mod.xsl"/>
<xsl:include href="mathml/mathml.content.mod.xsl"/>
<xsl:include href="mathml/mathml.content.token.mod.xsl"/>
<xsl:include href="mathml/mathml.content.functions.mod.xsl"/>
<xsl:include href="mathml/mathml.content.constsymb.mod.xsl"/>

<xsl:include href="para.mod.xsl"/>
<xsl:include href="msgset.mod.xsl"/>
<xsl:include href="errors.mod.xsl"/>

<xsl:include href="normalize-scape.mod.xsl"/>

     
<xsl:template match="/">
<xsl:message>################################################################################	</xsl:message>
<xsl:message> XSLT stylesheets DocBook - LaTeX 2e 				</xsl:message>
<xsl:message> Reqs: LaTeX 2e installation common packages			</xsl:message>
<xsl:message> 										</xsl:message>
<xsl:message> VERSION : <xsl:value-of select="$CVSVERSION"/>		</xsl:message>
<xsl:message>     TAG : <xsl:value-of select="$TAG"/>				</xsl:message>
<xsl:message>     WWW : http://www.infres.enst.fr/~casellas/docbook.html</xsl:message>
<xsl:message>    OSDN : http://db2latex.sourceforge.net			</xsl:message>
<xsl:message>  AUTHOR : Ramon Casellas	casellas@aist.enst.fr		</xsl:message>
<xsl:message>   USING : <xsl:call-template name="set-vendor"/>		</xsl:message>
<xsl:message>################################################################################	</xsl:message>
     <xsl:apply-templates/>
</xsl:template>


<!--############################################################################# -->
<!-- XSL Processor Vendor                                                         -->
<!-- XSL Mailing Lists http://www.dpawson.co.uk/xsl/N10378.html                   -->
<!--############################################################################# -->
<xsl:template name="set-vendor">
<xsl:variable name="xsl-vendor" select="system-property('xsl:vendor')"/>
<xsl:choose>
	<xsl:when test="contains($xsl-vendor, 'SAXON 6.2')">
		<xsl:text>SAXON 6.2.X</xsl:text>
	</xsl:when>
	<xsl:when test="starts-with($xsl-vendor,'SAXON')">
		<xsl:text>SAXON</xsl:text>
	</xsl:when>
	<xsl:when test="contains($xsl-vendor,'Apache')">
		<xsl:text>XALAN</xsl:text>
	</xsl:when>
	<xsl:when test="contains($xsl-vendor,'Clark')">
		<xsl:text>XT</xsl:text>
	</xsl:when>
	<xsl:otherwise>
		<xsl:text>UNKNOWN</xsl:text>
	</xsl:otherwise>
</xsl:choose>
</xsl:template>


</xsl:stylesheet>

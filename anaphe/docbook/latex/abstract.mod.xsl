<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: abstract.mod.xsl,v 1.4 2001/05/01 17:34:52 rcasellas Exp $
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
<doc:reference id="abstract" xmlns="">
<referenceinfo>
<releaseinfo role="meta">
    $Id: abstract.mod.xsl,v 1.4 2001/05/01 17:34:52 rcasellas Exp $
</releaseinfo>
<author>
    <surname>Casellas</surname>
    <firstname>Ramon</firstname>
</author>
<copyright>
	<year>2000</year><year>2001</year>
	<holder>Ramon Casellas</holder>
</copyright>
</referenceinfo>
<title>Abstract</title>
<partintro>
    <section><title>Introduction</title>
    <para></para>
    </section>
</partintro>
</doc:reference>
<!--############################################################################# -->

<!--############################################################################# -->
<!-- DOCUMENTATION                                                                -->
<doc:template match="abstract" xmlns="">
<refpurpose> Abstract XSL template.  </refpurpose>
<refdescription>
<para>Calls template <xref linkend="map.begin"/>(<literal>map.begin</literal>),
to output the opening command (by default):</para>
<screen>
% --------------------------------------------
% Abstract 
% --------------------------------------------
\begin{abstract}
</screen>
<para> Calls "apply-templates" for all the children, and call template
<xref linkend="map.end"/>(<literal>map.end</literal>) to output the closing
command.</para>
<formalpara><title>Remarks and Bugs</title>
<itemizedlist>
	<listitem><para> The title of the abstract is lost.</para></listitem>
	<listitem><para> The template for abstract/title is defined EMPTY.</para></listitem>
</itemizedlist>
</formalpara>

<formalpara><title>Default Behaviour</title>
<screen>
	Fill	
</screen>
</formalpara>
</refdescription>
</doc:template>
<!--############################################################################# -->

<!-- TEMPLATE -->
<xsl:template match="abstract">
<xsl:call-template name="map.begin"/>
<xsl:apply-templates/>
<xsl:call-template name="map.end"/>
</xsl:template>

<xsl:template match="abstract/title"/>

</xsl:stylesheet>

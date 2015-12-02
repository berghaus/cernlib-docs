<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: revision.mod.xsl,v 1.4 2001/05/01 17:34:52 rcasellas Exp $
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
<doc:reference id="revision" xmlns="">
<referenceinfo>
<releaseinfo role="meta">
    $Id: revision.mod.xsl,v 1.4 2001/05/01 17:34:52 rcasellas Exp $
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
<title>Revision Management <filename>revision.mod.xsl</filename></title>
<partintro>
    <section><title>Introduction</title>
    <para></para>
    </section>
</partintro>
</doc:reference>
<!--############################################################################# -->




<!--############################################################################# -->
<!-- DOCUMENTATION                                                                -->
<doc:template match="revhistory" xmlns="">
<refpurpose> revhistory XSL template </refpurpose>
<refdescription>
</refdescription>
</doc:template>
<!--############################################################################# -->

<xsl:template match="revhistory">
<xsl:message>RCAS: Processing Revision History </xsl:message>
<xsl:if test="$latex.output.revhistory=1">
	<xsl:call-template name="map.begin"/>
	<xsl:apply-templates/>
	<xsl:call-template name="map.end"/>
</xsl:if>
</xsl:template>




<!--############################################################################# -->
<!-- DOCUMENTATION                                                                -->
<doc:template name="revhistory/revision" xmlns="">
<refpurpose> revhistory XSL template </refpurpose>
<refdescription>
</refdescription>
</doc:template>
<!--############################################################################# -->

<xsl:template match="revhistory/revision">
<xsl:variable name="revnumber" select=".//revnumber"/>
<xsl:variable name="revdate"   select=".//date"/>
<xsl:variable name="revauthor" select=".//authorinitials"/>
<xsl:variable name="revremark" select=".//revremark|../revdescription"/>
  <!-- Row starts here -->
    	<xsl:if test="$revnumber">
     		<xsl:call-template name="gentext.element.name"/>
     		<xsl:text> </xsl:text>
     		<xsl:apply-templates select="$revnumber"/>
    	</xsl:if>
    <xsl:text> &amp; </xsl:text>
    <xsl:apply-templates select="$revdate"/>
    <xsl:text> &amp; </xsl:text>
    <xsl:choose>
      <xsl:when test="count($revauthor)=0">
          	<xsl:call-template name="dingbat">
            <xsl:with-param name="dingbat">nbsp</xsl:with-param>
          	</xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
          	<xsl:apply-templates select="$revauthor"/>
      </xsl:otherwise>
    </xsl:choose>
    <!-- End Row here -->
    <xsl:text> \\ \hline&#10;</xsl:text>
    <!-- Add Remark Row if exists-->
    <xsl:if test="$revremark"> 
    	<xsl:text>\multicolumn{3}{l}{</xsl:text>
    	<xsl:apply-templates select="$revremark"/> 
    	<!-- End Row here -->
    	<xsl:text>} \\ \hline&#10;</xsl:text>
    </xsl:if>
</xsl:template>

<xsl:template match="revision/authorinitials">
<xsl:apply-templates/>
<xsl:if test="position()!=last()">
	<xsl:text>, </xsl:text>
</xsl:if>
</xsl:template>

<xsl:template match="revision/revnumber">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="revision/date">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="revision/revremark">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="revision/revdescription">
<xsl:apply-templates/>
</xsl:template>

</xsl:stylesheet>

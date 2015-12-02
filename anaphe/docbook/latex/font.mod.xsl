<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: font.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
<doc:reference id="font" xmlns="">
	<referenceinfo>
	<releaseinfo role="meta">
		$Id: font.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
	
	<title>Font <filename>font.mod.xsl</filename></title>
	<partintro>
		<section><title>Introduction</title>
		<para></para>
		</section>
	</partintro>
</doc:reference>



 
<doc:param name="latex.document.font" xmlns="">
	<refpurpose> Document Font  </refpurpose>
	<refdescription>
	Possible values: default, times, palatcm, charter, helvet, palatino, avant, newcent, bookman
	</refdescription>
</doc:param>
<xsl:param name="latex.document.font">palatino</xsl:param>

<!-- 
If you want to change explicitly to a certain font, use the command \fontfamily{XYZ}\selectfont whereby XYZ can be set to: pag for Adobe AvantGarde, pbk for Adobe Bookman, pcr for Adobe Courier, phv for Adobe Helvetica, pnc for Adobe NewCenturySchoolbook, ppl for Adobe Palatino, ptm for Adobe Times Roman, pzc for Adobe ZapfChancery 
-->

</xsl:stylesheet>

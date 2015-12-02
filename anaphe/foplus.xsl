<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:m="http://www.w3.org/1998/Math/MathML">

<xsl:import href="/afs/cern.ch/sw/XML/cdrom/www.nwalsh.com/docbook/xsl/fo/autoidx.xsl"/>
<xsl:param name="graphic.default.extension">eps</xsl:param>
<xsl:param name="paper.type" select="'A4'"/>
<xsl:param name="refentry.generate.name" select="1"/>
<!--
<xsl:param name="section.autolabel" select="1"/>
<xsl:param name="author.othername.in.middle" select="1"/>
<xsl:param name="refentry.xref.manvolnum" select="1"/>
<xsl:param name="show.comments" select="1"/>
<xsl:param name="funcsynopsis.style">kr</xsl:param>
<xsl:param name="funcsynopsis.decoration" select="1"/>
<xsl:param name="refentry.generate.name" select="1"/>
<xsl:param name="admon.graphics" select="0"/>
<xsl:param name="admon.graphics.path">../images/</xsl:param>
<xsl:param name="admon.graphics.extension" select="'.png'" doc:type='string'/>
<xsl:param name="section.autolabel" select="0"/>
<xsl:param name="section.label.includes.component.label" select="0"/>
<xsl:param name="chapter.autolabel" select="1"/>
<xsl:param name="part.autolabel" select="1"/>
<xsl:param name="preface.autolabel" select="0"/>
<xsl:param name="biblioentry.item.separator">. </xsl:param>
<xsl:param name="qandadiv.autolabel" select="1"/>
<xsl:param name="qanda.inherit.numeration" select="0"/>
<xsl:param name="graphic.default.extension"></xsl:param>
<xsl:param name="rootid" select="''"/>
<xsl:param name="callout.graphics" select="'1'"/>
<xsl:param name="callout.graphics.extension" select="'.png'"/>
<xsl:param name="callout.graphics.path" select="'../images/callouts/'"/>
<xsl:param name="callout.graphics.number.limit" select="'10'"/>
<xsl:param name="saxon.extensions" select="'0'"/>
<xsl:param name="saxon.textinsert" select="'1'"/>
<xsl:param name="saxon.linenumbering" select="'1'"/>
<xsl:param name="linenumbering.everyNth" select="'5'"/>
<xsl:param name="linenumbering.width" select="'3'"/>
<xsl:param name="linenumbering.separator" select="' '"/>
<xsl:param name="saxon.callouts" select="'1'"/>
<xsl:param name="callout.defaultcolumn" select="'60'"/>
<xsl:param name="paper.type" select="'USletter'"/>
<xsl:param name="page.orientation" select="'portrait'"/>
<xsl:param name="page.width.portrait">
<xsl:param name="page.height.portrait">
<xsl:param name="page.width">
<xsl:param name="page.height">
<xsl:param name="double.sided" select="'0'"/>
<xsl:param name="column.count" select="'1'"/>
<xsl:param name="region.after.extent" select="'12pt'"/>
<xsl:param name="region.before.extent" select="'12pt'"/>
<xsl:param name="page.margin.top">1in</xsl:param>
<xsl:param name="page.margin.bottom">1in</xsl:param>
<xsl:param name="page.margin.inner">
<xsl:param name="page.margin.outer">
<xsl:param name="body.margin.bottom">24pt</xsl:param>
<xsl:param name="body.margin.top">24pt</xsl:param>
<xsl:param name="body.font.family">Times Roman</xsl:param>
<xsl:param name="title.font.family">Helvetica</xsl:param>
<xsl:param name="monospace.font.family">Courier</xsl:param>
<xsl:param name="sans.font.family">Helvetica</xsl:param>
<xsl:param name="body.font.master">10</xsl:param>
<xsl:param name="body.font.size">
<xsl:param name="footnote.font.size">
<xsl:param name="hyphenate">true</xsl:param>
<xsl:param name="alignment">justify</xsl:param>
<xsl:param name="stylesheet.result.type" select="'fo'"/>
<xsl:param name="generate.component.toc" select="0" doc:type='boolean'/>
<xsl:param name="generate.division.toc" select="1" doc:type='boolean'/>
<xsl:param name="generate.division.figure.lot" select="1" doc:type='boolean'/>
<xsl:param name="generate.division.example.lot" select="1" doc:type='boolean'/>
<xsl:param name="generate.division.equation.lot" select="1" doc:type='boolean'/>
<xsl:param name="generate.division.table.lot" select="1" doc:type='boolean'/>
<xsl:param name="passivetex.extensions" select="0" doc:type='boolean'/>
<xsl:param name="default.units" select="'pt'" doc:type='list'
<xsl:param name="generate.index" select="1" doc:type='boolean'/>
-->

<!-- ********************************************************************
     Michel's additions to Norm's FO Docbook Style Sheets 
     ******************************************************************** -->

<xsl:template match="programlisting" priority="4">
  <fo:block wrap-option="no-wrap" 
            whitespace-treatment="preserve"
            text-align="start" 
            font-family="monospace"
            font-size="9pt"
            space-before.optimum="4pt"
            space-after.optimum="4pt"
 >
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="variablelist">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>
  <fo:list-block id="{$id}"
                 provisional-distance-between-starts="46mm"
                 provisional-label-separation="2mm"
                 space-before.minimum="0.2em"
                 space-before.optimum="0.4em"
                 space-before.maximum="0.6em">
    <xsl:apply-templates/>
  </fo:list-block>
</xsl:template>

<xsl:template match="varlistentry">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>
  <fo:list-item id="{$id}"
                space-before.minimum="0em"
                space-before.optimum=".1em"
                space-before.maximum=".2em">
    <fo:list-item-label>
      <fo:block>
        <xsl:apply-templates select="term"/>
      </fo:block>
    </fo:list-item-label>
    <fo:list-item-body>
      <xsl:apply-templates select="listitem"/>
    </fo:list-item-body>
  </fo:list-item>
</xsl:template>

<xsl:template match="programlisting[@role='outputlisting']" priority="5">
  <fo:block wrap-option="no-wrap" 
            whitespace-treatment="preserve"
            text-align="start" 
            font-family="monospace"
            font-size="7pt"
            space-before.optimum="4pt"
            space-after.optimum="4pt"
 >
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="xref.text" priority="5">
  <xsl:text>[</xsl:text><xsl:apply-templates/><xsl:text>]</xsl:text>
</xsl:template>

<xsl:template match="method|object">
  <fo:inline font-family="monospace">
    <xsl:apply-templates/> 
  </fo:inline>
</xsl:template>

<xsl:template match="m:math">
 <xsl:copy>
  <xsl:apply-templates mode="math"/> 
 </xsl:copy>
</xsl:template>

<xsl:template match="informalequation|inlineequation">
<xsl:element name="{name(.)}">
 <xsl:apply-templates/> 
</xsl:element>
</xsl:template>

<xsl:template  mode="math"  
  match="*|@*|comment()|processing-instruction()|text()">
  <xsl:copy>
  <xsl:apply-templates    mode="math" 
   select="*|@*|processing-instruction()|text()"/>
 </xsl:copy>
</xsl:template>

<!-- ====== from graphics.xsl in fo directory =========================== -->

<xsl:template match="inlinegraphic[@fileref]" priority="999">
  <xsl:call-template name="process.mygraphic"/>
</xsl:template>
<xsl:template match="graphic[@fileref]" priority="999">
 <fo:block>
  <xsl:call-template name="process.mygraphic"/>
 </fo:block>
</xsl:template>
<xsl:template name="process.mygraphic">
  <fo:external-graphic src="{@fileref}.eps">
   <xsl:if test="@width">
     <xsl:variable name="Width" select="string(@width)"/>
     <xsl:choose>
       <xsl:when test="contains($Width,'%')">
         <xsl:attribute name="content-width">
           <xsl:value-of select="concat('0.',substring-before($Width,'%'),'\linewidth')"/>
         </xsl:attribute>
       </xsl:when>
       <xsl:otherwise>
         <xsl:attribute name="content-width">
           <xsl:value-of select="$Width"/>
         </xsl:attribute>
       </xsl:otherwise>
     </xsl:choose>
   </xsl:if>
   <xsl:if test="@height">
     <xsl:variable name="Height" select="string(@height)"/>
     <xsl:choose>
       <xsl:when test="contains($Height,'%')">
         <xsl:attribute name="content-height">
           <xsl:value-of select="concat('0.',substring-before($Height,'%'),'\pageheight')"/>
         </xsl:attribute>
       </xsl:when>
       <xsl:otherwise>
         <xsl:attribute name="content-height">
           <xsl:value-of select="$Height"/>
         </xsl:attribute>
       </xsl:otherwise>
     </xsl:choose>
   </xsl:if>
  </fo:external-graphic>
</xsl:template>

  <!-- When this template is called, the current node should be  -->
  <!-- a graphic, inlinegraphic, imagedata, or videodata. All    -->
  <!-- those elements have the same set of attributes, so we can -->
  <!-- handle them all in one place.                             -->
<!--
<xsl:template name="process.image">
  <xsl:variable name="input-filename">
    <xsl:choose>
      <xsl:when test="@entityref">
        <xsl:value-of select="unparsed-entity-uri(@entityref)"/>
      </xsl:when>
      <xsl:when test="@fileref">
        <xsl:text>file:</xsl:text>
        <xsl:value-of select="@fileref"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message>
          <xsl:text>Expected @entityref or @fileref on </xsl:text>
          <xsl:value-of select="name(.)"/>
        </xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="fileext">
    <xsl:call-template name="filename-extension">
      <xsl:with-param name="filename" select="$input-filename"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="filename">
    <xsl:choose>
      <xsl:when test="$fileext != ''">
        <xsl:value-of select="$input-filename"/>
      </xsl:when>
      <xsl:when test="$graphic.default.extension != ''">
        <xsl:value-of select="$input-filename"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="$graphic.default.extension"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$input-filename"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="scale">
    <xsl:choose>
      <xsl:when test="@scale"><xsl:value-of select="@scale"/>%</xsl:when>
      <xsl:otherwise>auto</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="width">
    <xsl:choose>
      <xsl:when test="@width">
        <xsl:call-template name="length-spec">
          <xsl:with-param name="length" select="@width"/>
          <xsl:with-param name="default.units" select="$default.units"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>auto</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="height">
    <xsl:choose>
      <xsl:when test="@depth">
        <xsl:call-template name="length-spec">
          <xsl:with-param name="length" select="@depth"/>
          <xsl:with-param name="default.units" select="$default.units"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>auto</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
-->
  <!-- Scaling seems to require calculating an absolute width and height
       from a scale factor and the intrinsic width and height (possibly
       with contributions from the specified width and height). I'm not
       sure how to specify that... -->

<!--  <fo:external-graphic src="url({$filename})" 
    content-width="{$width}" content-height="{$height}"
    width="auto" height="auto"/>  -->
  <!-- ++++++ Next line CHANGED from above ++++++ -->
<!--
  <fo:external-graphic src="{$filename}" 
    width="{$width}" height="{$height}"/>
</xsl:template>
-->
</xsl:stylesheet>

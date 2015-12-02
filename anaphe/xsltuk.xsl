<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:verb5="http://nwalsh.com/com.nwalsh.saxon.Verbatim"
                xmlns:verb6="http://nwalsh.com/com.nwalsh.saxon6.Verbatim"
                exclude-result-prefixes="verb5 verb6"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0">

<xsl:import href="docbook-xsl/fo/docbook.xsl"/>

<xsl:output indent="no"/>

<xsl:param name="callout.graphics.path" select="'graphics/'"/>
<xsl:param name="section.label.includes.component.label" select="1"/>
<xsl:param name="section.autolabel" select="1"/>
<xsl:param name="paper.type" select="A4"/>
<xsl:param name="body.font.size" select="'10pt'"/>
<xsl:param name="body.font.family" select="'Janson'"/>
<xsl:param name="monospace.font.family" select="'Computer-Modern-Typewriter'"/>
<xsl:param name="title.font.family" select="'Computer-Modern-Sans'"/>
<xsl:param name="double.sided" select="'1'"/>
<xsl:param name="region.before.extent" select="'20pt'"/>
<xsl:param name="generate.division.figure.lot" select="0"/>
<xsl:param name="generate.division.example.lot" select="0"/>
<xsl:param name="generate.division.table.lot" select="0"/>
<xsl:param name="page.margin.top">0.5in</xsl:param>
<xsl:param name="page.margin.bottom">0.5in</xsl:param>

<xsl:attribute-set name="normal.para.spacing">
  <xsl:attribute name="space-before">0pt</xsl:attribute>
</xsl:attribute-set>

<!-- only indent first para of each section -->
 <xsl:template match="para">
  <fo:block>
   <xsl:variable name="x"><xsl:number/></xsl:variable>
   <xsl:choose>
   <xsl:when test="parent::footnote">
     <xsl:attribute name="text-indent">0em</xsl:attribute>
   </xsl:when>
   <xsl:when test="$x &gt; 1">
     <xsl:attribute name="text-indent">1em</xsl:attribute>
   </xsl:when>
   <xsl:otherwise>
     <xsl:attribute name="text-indent">0em</xsl:attribute>
   </xsl:otherwise>
   </xsl:choose>
   <xsl:apply-templates/>
  </fo:block>
 </xsl:template>


<!-- superscript numbers for footnotes -->
<xsl:template match="footnote/para[1]">
  <fo:block text-indent="0em"> 
    <fo:inline font-size="8pt" vertical-align="super">
    <xsl:apply-templates select="ancestor::footnote" mode="footnote.number"/>
    </fo:inline>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="footnote">
  <fo:footnote>
    <fo:inline font-size="8pt" vertical-align="super">
      <xsl:apply-templates select="." mode="footnote.number"/>
    </fo:inline>
    <fo:footnote-body font-size="{$footnote.font.size}">
      <xsl:apply-templates/>
    </fo:footnote-body>
  </fo:footnote>
</xsl:template>


<!-- start footnote numbering again for each article -->

<xsl:template match="footnote" mode="footnote.number">
  <xsl:number count="footnote" level="any" from="article" format="1"/>
</xsl:template>

<xsl:template match="section" mode="label.content">
  <xsl:number  from="article" level="multiple" count="section"/>
</xsl:template>

<!-- change space before and after programlisting -->
<xsl:template match="programlisting">
  <xsl:param name="suppress-numbers" select="'0'"/>
  <xsl:variable name="vendor" select="system-property('xsl:vendor')"/>

  <!-- Obey the <?dbfo linenumbering.everyNth="x"?> PI -->
  <xsl:variable name="default.linenumbering.everyNth"
                select="$linenumbering.everyNth"/>

  <xsl:variable name="pi.linenumbering.everyNth">
    <xsl:call-template name="dbfo-attribute">
      <xsl:with-param name="attribute" select="'everyNth'"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="linenumbering.everyNth">
    <xsl:choose>
      <xsl:when test="$pi.linenumbering.everyNth != ''">
        <xsl:value-of select="$pi.linenumbering.everyNth"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$default.linenumbering.everyNth"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- Obey the <?dbfo linenumbering.separator="x"?> PI -->
  <xsl:variable name="default.linenumbering.separator"
                select="$linenumbering.separator"/>

  <xsl:variable name="pi.linenumbering.separator">
    <xsl:call-template name="dbfo-attribute">
      <xsl:with-param name="attribute" select="'linenumbering.separator'"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="linenumbering.separator">
    <xsl:choose>
      <xsl:when test="$pi.linenumbering.separator != ''">
        <xsl:value-of select="$pi.linenumbering.separator"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$default.linenumbering.separator"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$suppress-numbers = '0'
                    and @linenumbering = 'numbered'">
      <xsl:variable name="rtf">
        <xsl:apply-templates/>
      </xsl:variable>
      <fo:block wrap-option='no-wrap'
                text-align='start'
                white-space-collapse='false'
                linefeed-treatment="preserve"
                font-family='{$monospace.font.family}'
                space-before.minimum="2pt"
                space-before.optimum="4pt"
                space-before.maximum="6pt"
                space-after.minimum="2pt"
                space-after.optimum="4pt"
                space-after.maximum="6pt">
        <xsl:choose>
          <xsl:when test="contains($vendor, 'SAXON 6')">
            <xsl:copy-of select="verb6:numberLines($rtf)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:copy-of select="verb5:numberLines($rtf,
                                 $linenumbering.everyNth,
                                 $linenumbering.width,
                                 $linenumbering.separator)"/>
          </xsl:otherwise>
        </xsl:choose>
      </fo:block>
    </xsl:when>
    <xsl:otherwise>
      <fo:block wrap-option='no-wrap'
                text-align='start'
                white-space-collapse='false'
                linefeed-treatment="preserve"
                font-family='{$monospace.font.family}'
                space-before.minimum="2pt"
                space-before.optimum="4pt"
                space-before.maximum="6pt"
                space-after.minimum="2pt"
                space-after.optimum="4pt"
                space-after.maximum="6pt">
        <xsl:apply-templates/>
      </fo:block>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!-- redefine indent on block quote -->
<xsl:template match="blockquote">
  <fo:block space-before="3pt" space-after="3pt" start-indent=".3in" end-indent=".3in">
    <xsl:call-template name="semiformal.object"/>
  </fo:block>
</xsl:template>

<!-- add abstract template -->
<xsl:template match="abstract">
  <fo:block text-align-last="center" font-weight="bold">ABSTRACT</fo:block>
  <fo:block start-indent=".3in" end-indent=".3in">
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

 <!-- norm added this -->
<xsl:template match="screen">
  <fo:wrapper font-size="9pt" line-height="10pt">
    <xsl:apply-imports/>
  </fo:wrapper>
</xsl:template>

 <!-- norm added this -->
<xsl:template match="co">
  <fo:inline id="{@id}">
    <xsl:choose>
      <xsl:when test="@role">
        <xsl:call-template name="callout-bug">
          <xsl:with-param name="conum" select="@role"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="." mode="callout-bug"/>
      </xsl:otherwise>
    </xsl:choose>
  </fo:inline>
</xsl:template>

<!-- redefine top-level, cos Norm had hard-wired font and size -->

<xsl:template match="/">
  <fo:root font-family="{$body.font.family}"
           font-size="{$body.font.size}"
           text-align="justify">
    <xsl:call-template name="setup.pagemasters"/>
    <xsl:apply-templates/>
  </fo:root>
</xsl:template>

<!-- replacement page masters -->

<xsl:template name="setup.pagemasters">
  <fo:layout-master-set>
<!-- for left-hand/even pages in twosided mode, single column -->
     <fo:simple-page-master
        master-name="left1"
                           page-width="{$page.width}"
                           page-height="{$page.height}"
                           margin-top="{$page.margin.top}"
                           margin-bottom="{$page.margin.bottom}"
                           margin-left="{$page.margin.outer}"
                           margin-right="{$page.margin.inner}">
        <fo:region-body 
		margin-bottom="{$body.margin.bottom}"
		margin-top="{$body.margin.top}"/>
        <fo:region-before
		region-name="region-before-left" 
		extent="{$region.before.extent}"/>
        <fo:region-after 
		region-name="region-after-left" 
		extent="{$region.after.extent}"/>
      </fo:simple-page-master>

<!-- for right-hand/odd pages in twosided mode, single column -->
      <fo:simple-page-master
        master-name="right1"
                           page-width="{$page.width}"
                           page-height="{$page.height}"
                           margin-top="{$page.margin.top}"
                           margin-bottom="{$page.margin.bottom}"
                           margin-left="{$page.margin.inner}"
                           margin-right="{$page.margin.outer}">
        <fo:region-body 
		margin-bottom="{$body.margin.bottom}"
		margin-top="{$body.margin.top}"/>
        <fo:region-before 
		region-name="region-before-right" 
		extent="{$region.before.extent}"/>
        <fo:region-after
		region-name="region-after-right" 
		extent="{$region.after.extent}"/>
     </fo:simple-page-master>

<!-- special case of first page in either mode, single column -->
      <fo:simple-page-master
        master-name="first1"
        margin-top="{$page.margin.top}"
        margin-bottom="{$page.margin.bottom}"
        margin-left="{$page.margin.outer}"
        margin-right="{$page.margin.inner}">
        <fo:region-body 
		margin-bottom="{$body.margin.bottom}"
		margin-top="{$body.margin.top}"/>
        <fo:region-before  
		region-name="region-before-first"
		extent="{$region.before.extent}"/>
        <fo:region-after 
		region-name="region-after-first"
		extent="{$region.after.extent}"/>
     </fo:simple-page-master>

<!-- special case of first page in either mode, single column -->
      <fo:simple-page-master
        master-name="titlepage1"
        margin-top="{$page.margin.top}"
        margin-bottom="{$page.margin.bottom}"
        margin-left="{$page.margin.outer}"
        margin-right="{$page.margin.inner}">
        <fo:region-body 
		margin-bottom="{$body.margin.bottom}"
		margin-top="{$body.margin.top}"/>
        <fo:region-before  
		region-name="region-before-first"
		extent="{$region.before.extent}"/>
        <fo:region-after 
		region-name="region-after-first"
		extent="{$region.after.extent}"/>
     </fo:simple-page-master>


<!-- setup for double-sided, 1 column -->
     <fo:page-sequence-master master-name="twoside1">
      <fo:repeatable-page-master-alternatives>
        <fo:conditional-page-master-reference
		master-name="first1"
		page-position="first"/>
        <fo:conditional-page-master-reference
		master-name="right1"
		odd-or-even="odd"/>
        <fo:conditional-page-master-reference
		master-name="left1"
		odd-or-even="even"/>
      </fo:repeatable-page-master-alternatives>
     </fo:page-sequence-master>

    </fo:layout-master-set>

</xsl:template>

<!-- running headers and footers -->
<xsl:template match="article" mode="running.head.mode">
  <xsl:variable name="artnum">
   <xsl:number level="any" count="article"/>
  </xsl:variable>
  <xsl:message>Article <xsl:value-of select="$artnum"/></xsl:message>
  <fo:static-content flow-name="region-before-left">
        <fo:block 
          background-color="blue" 
          font-weight="bold" padding="3pt" 
          font-family="{$title.font.family}" color="white" 
          text-align="justify" font-size="{$body.font.size}">
          <fo:inline><xsl:value-of select="$artnum"/></fo:inline>
           <fo:leader rule-thickness="0pt"/>
           <fo:inline><xsl:value-of select="articleinfo/title"/></fo:inline>
        </fo:block>
  </fo:static-content>
  <fo:static-content flow-name="region-before-right">
        <fo:block background-color="blue" 
          font-weight="bold" padding="3pt" 
          font-family="{$title.font.family}" color="white" text-align="left" 
          font-size="{$body.font.size}">
          <xsl:value-of select="articleinfo/author/firstname"/>
          <xsl:text> </xsl:text>
          <xsl:value-of select="articleinfo/author/surname"/>
        </fo:block>
  </fo:static-content>
</xsl:template>

<xsl:template match="article" mode="running.foot.mode">

  <fo:static-content flow-name="region-after-left">
<fo:block text-align="left" font-size="{$body.font.size}">-<fo:page-number/>-</fo:block>
  </fo:static-content>
  <fo:static-content flow-name="region-after-right">
    <fo:block text-align="right" font-size="{$body.font.size}">-<fo:page-number/>-</fo:block>
  </fo:static-content>
</xsl:template>


<!-- title for each article -->
<xsl:template name="article.titlepage.recto">
  <xsl:message>article title: <xsl:value-of select="articleinfo/title"/></xsl:message>
  <fo:block font-family="{$title.font.family}"
   font-size="25pt"
    font-wieght="bold" space-after="25pt">
    <xsl:value-of select="articleinfo/title"/>
  </fo:block>
  <fo:block font-family="{$title.font.family}"
   font-size="20pt"
    font-style="italic"  space-after="30pt" space-before="20pt">
    <xsl:value-of select="articleinfo/author/firstname"/>
  <xsl:text> </xsl:text>
  <xsl:value-of select="articleinfo/author/surname"/>
  <xsl:text> (</xsl:text>
  <xsl:value-of select="articleinfo/author/affiliation/orgname"/>)
</fo:block>
</xsl:template>


<!-- space around lists -->
<xsl:attribute-set name="list.block.spacing">
  <xsl:attribute name="space-before.optimum">3pt</xsl:attribute>
  <xsl:attribute name="space-before.minimum">1pt</xsl:attribute>
  <xsl:attribute name="space-before.maximum">6pt</xsl:attribute>
</xsl:attribute-set>

<!-- division TOC needs to look for <article> -->
<xsl:template name="division.toc">
  <xsl:variable name="nodes"
                select="article|part|reference|preface
                        |chapter|appendix
                        |bibliography|glossary|index"/>
  <xsl:if test="$nodes">
    <fo:block>
      <xsl:call-template name="table.of.contents.titlepage"/>
      <xsl:apply-templates select="$nodes" mode="toc"/>
    </fo:block>
  </xsl:if>
</xsl:template>


<!-- article TOC entry -->
<xsl:template match="article" mode="toc">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <fo:block space-before="6pt" font-weight="bold">
    <xsl:number/>
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="." mode="title.content"/>
    <fo:leader leader-pattern="dots" text-align-last="justify"/>
    <fo:page-number-citation ref-id="{$id}"/>
  </fo:block>

  <fo:block font-style="italic" start-indent="2pc">
  <xsl:value-of select="articleinfo/author/firstname"/>
  <xsl:text> </xsl:text>
  <xsl:value-of select="articleinfo/author/surname"/>
  <xsl:text> (</xsl:text>
  <xsl:value-of select="articleinfo/author/affiliation/orgname"/>)
  </fo:block>


  <xsl:if test="section">
    <fo:block start-indent="2pc">
      <xsl:apply-templates select="section" mode="toc"/>
    </fo:block>
  </xsl:if>
</xsl:template>

<!-- section TOC only goes down one level -->
<xsl:template match="section"  mode="toc">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <fo:block>
    <xsl:apply-templates select="." mode="label.content"/>
    <xsl:text>     </xsl:text>
    <xsl:apply-templates select="." mode="title.content"/>
    <fo:leader leader-pattern="dots" text-align-last="justify"/>
    <fo:page-number-citation ref-id="{$id}"/>
  </fo:block>
</xsl:template>

<xsl:template match="figure">
  <xsl:choose>
    <xsl:when test="@float='1'">
    <fo:float>
      <xsl:call-template name="formal.object"/>
    </fo:float>
   </xsl:when>
   <xsl:otherwise>
      <xsl:call-template name="formal.object"/>
   </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<xsl:attribute-set name="formal.title.attrs"
                   use-attribute-sets="normal.para.spacing">
  <xsl:attribute name="space-before">6pt</xsl:attribute>
  <xsl:attribute name="font-style">italic</xsl:attribute>
  <xsl:attribute name="font-size">10pt</xsl:attribute>
</xsl:attribute-set>

<!-- need to add initial-page-number to page-sequence -->
<xsl:template match="article">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>
  <xsl:variable name="master-name">
    <xsl:call-template name="select.pagemaster"/>
  </xsl:variable>

  <fo:page-sequence id="{$id}"
                    initial-page-number="auto-odd"
                    hyphenate="{$hyphenate}"
                    master-name="{$master-name}">
    <xsl:attribute name="language">
      <xsl:call-template name="l10n.language"/>
    </xsl:attribute>

    <xsl:apply-templates select="." mode="running.head.mode">
      <xsl:with-param name="master-name" select="$master-name"/>
    </xsl:apply-templates>
    <xsl:apply-templates select="." mode="running.foot.mode">
      <xsl:with-param name="master-name" select="$master-name"/>
    </xsl:apply-templates>

    <fo:flow flow-name="xsl-region-body">
      <xsl:call-template name="article.titlepage"/>
      <xsl:if test="$generate.component.toc">
        <xsl:call-template name="component.toc"/>
      </xsl:if>
      <xsl:apply-templates/>
    </fo:flow>
  </fo:page-sequence>
</xsl:template>

<!-- space after section headings needed, and smaller sizes -->

<xsl:template name="section.heading">
  <xsl:param name="level">1</xsl:param>
  <xsl:param name="title"></xsl:param>
  <xsl:variable name="fsize">
    <xsl:choose>
      <xsl:when test="$level=1">16</xsl:when>
      <xsl:when test="$level=2">14</xsl:when>
      <xsl:when test="$level=3">12</xsl:when>
      <xsl:when test="$level=4">11</xsl:when>
      <xsl:when test="$level=5">10</xsl:when>
      <xsl:otherwise>10</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <fo:block  keep-with-next.within-page="always"
             font-size="{$fsize}pt" 
            font-weight="bold"
            space-before.minimum="1em"
            space-before.optimum="1.5em"
            space-before.maximum="2em"
            space-after.minimum=".25em"
            space-after.optimum=".5em"
            space-after.maximum=".75em">
    <xsl:copy-of select="$title"/>
  </fo:block>
</xsl:template>

<xsl:template name="bibliography.titlepage.recto">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" 
            xsl:use-attribute-sets="bibliography.titlepage.recto.style" 
            font-size="14pt" 
            space-before.minimum="1em"
            space-before.optimum="1.5em"
            space-before.maximum="2em"
            space-after.minimum=".25em"
            space-after.optimum=".5em"
            space-after.maximum=".75em"
  font-family="{$title.font.family}" 
 font-weight="bold">
<xsl:call-template name="component.title">
<xsl:with-param name="node" select="ancestor-or-self::bibliography[1]"/>
</xsl:call-template></fo:block>
  <xsl:apply-templates mode="bibliography.titlepage.recto.auto.mode" select="(bibliographyinfo/subtitle|docinfo/subtitle|subtitle)[1]"/>
</xsl:template>


<xsl:template name="formal.object">
  <fo:block keep-with-next.within-page="always">
    <xsl:attribute name="id">
      <xsl:call-template name="object.id"/>
    </xsl:attribute>
  </fo:block>
  <fo:block>
    <xsl:call-template name="formal.object.heading">
       <xsl:with-param name="title">
         <xsl:apply-templates select="." mode="title.ref"/>
       </xsl:with-param>
    </xsl:call-template>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template name="formal.object.heading">
  <xsl:param name="title"></xsl:param>
  <fo:block  space-below="2pt" space-before="3pt"
    keep-with-next.within-page="always" font-style="italic">
    <xsl:copy-of select="$title"/>
  </fo:block>
</xsl:template>


<xsl:template match="biblioentry">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>
  <fo:block space-below="2pt" id="{$id}">
    <xsl:apply-templates mode="bibliography.mode"/>
  </fo:block>
</xsl:template>

<xsl:template match="ulink">
<xsl:variable name="content">
        <xsl:apply-templates/>
</xsl:variable>
  <fo:basic-link external-destination="{@url}">
    <xsl:choose>
      <xsl:when test="count(child::node())=0">
        <xsl:value-of select="@url"/>
      </xsl:when>
      <xsl:otherwise>
<xsl:value-of select="$content"/>
      </xsl:otherwise>
    </xsl:choose>
  </fo:basic-link>
  <xsl:if test="count(child::node()) != 0">
  <fo:footnote>
    <fo:inline font-size="8pt" vertical-align="super">
      <xsl:number count="ulink" level="any" from="article" format="a"/>
    </fo:inline>
    <fo:footnote-body font-size="{$footnote.font.size}">
 <fo:block text-indent="0em" font-style="normal" >  
    <fo:inline font-size="8pt" vertical-align="super">
      <xsl:number count="ulink" level="any" from="article" format="a"/>
    </fo:inline>
     <xsl:value-of select="@url"/></fo:block>
    </fo:footnote-body>
  </fo:footnote>
  </xsl:if>
</xsl:template>

<xsl:template name="process.image">
  <!-- When this template is called, the current node should be  -->
  <!-- a graphic, inlinegraphic, imagedata, or videodata. All    -->
  <!-- those elements have the same set of attributes, so we can -->
  <!-- handle them all in one place.                             -->
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

  <!-- Scaling seems to require calculating an absolute width and height
       from a scale factor and the intrinsic width and height (possibly
       with contributions from the specified width and height). I'm not
       sure how to specify that... -->

  <fo:external-graphic src="{$filename}"
    content-width="{$width}" content-height="{$height}"
    width="auto" height="auto"/>
</xsl:template>

<xsl:template name="length-spec">
  <xsl:param name="length" select="'0pt'"/>
  <xsl:param name="default.units" select="'pt'"/>
  <xsl:variable name="magnitude">
    <xsl:call-template name="length-magnitude">
      <xsl:with-param name="length" select="$length"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="units">
    <xsl:value-of select="substring($length, string-length($magnitude)+1)"/>
  </xsl:variable>

  <xsl:value-of select="$magnitude"/>
  <xsl:choose>
    <xsl:when test="$units='cm'
                    or $units='mm'
                    or $units='in'
                    or $units='pt'
                    or $units='pc'
                    or $units='px'
                    or $units='em'">
      <xsl:value-of select="$units"/>
    </xsl:when>
    <xsl:when test="$units = ''">
      <xsl:value-of select="$default.units"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$units"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<xsl:template match="preface">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>
  <xsl:variable name="master-name">
    <xsl:call-template name="select.pagemaster"/>
  </xsl:variable>

  <fo:page-sequence id="{$id}"
                    initial-page-number="auto-odd"
                    hyphenate="{$hyphenate}"
                    format="i"
                    master-name="{$master-name}">
    <xsl:attribute name="language">
      <xsl:call-template name="l10n.language"/>
    </xsl:attribute>

    <xsl:apply-templates select="." mode="running.head.mode">
      <xsl:with-param name="master-name" select="$master-name"/>
    </xsl:apply-templates>

    <xsl:apply-templates select="." mode="running.foot.mode">
      <xsl:with-param name="master-name" select="$master-name"/>
    </xsl:apply-templates>

    <fo:flow flow-name="xsl-region-body">
      <xsl:call-template name="component.separator"/>
      <xsl:call-template name="preface.titlepage"/>
      <xsl:if test="$generate.component.toc">
        <xsl:call-template name="component.toc"/>
      </xsl:if>
      <xsl:apply-templates/>
    </fo:flow>
  </fo:page-sequence>
</xsl:template>



<xsl:template match="title" mode="book.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.recto.style" 
font-size="24.8832pt" space-before="18.6624pt" 
font-weight="bold" text-align-last="left" 
font-family="{$title.font.family}">
<xsl:call-template name="division.title">
<xsl:with-param name="node" select="ancestor-or-self::book[1]"/>
</xsl:call-template>
</fo:block>
</xsl:template>


<xsl:template match="book">
  <xsl:variable name="preamble"
                select="title|subtitle|titleabbrev|bookinfo"/>
  <xsl:variable name="content"
                select="*[not(self::title or self::subtitle
                            or self::titleabbrev
                            or self::bookinfo)]"/>
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>
  <xsl:variable name="master-name">
    <xsl:call-template name="select.pagemaster"/>
  </xsl:variable>

  <fo:page-sequence id="{$id}"
                    initial-page-number="auto-odd"
                     hyphenate="{$hyphenate}"
                      master-name="{$master-name}">
      <xsl:attribute name="language">
        <xsl:call-template name="l10n.language"/>
      </xsl:attribute>

      <xsl:apply-templates select="." mode="running.head.mode">
        <xsl:with-param name="master-name" select="$master-name"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="." mode="running.foot.mode">
        <xsl:with-param name="master-name" select="$master-name"/>
      </xsl:apply-templates>
      <fo:flow flow-name="xsl-region-body">
        <xsl:call-template name="book.titlepage"/>
      </fo:flow>
  </fo:page-sequence>


  <fo:page-sequence hyphenate="{$hyphenate}"
                      format="i"
                      initial-page-number="auto-odd"
                      master-name="{$master-name}">
      <xsl:attribute name="language">
        <xsl:call-template name="l10n.language"/>
      </xsl:attribute>
      <xsl:apply-templates select="." mode="running.head.mode">
        <xsl:with-param name="master-name" select="$master-name"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="." mode="running.foot.mode">
        <xsl:with-param name="master-name" select="$master-name"/>
      </xsl:apply-templates>
      <fo:flow flow-name="xsl-region-body">
        <xsl:call-template name="division.toc"/>
      </fo:flow>
  </fo:page-sequence>

  <xsl:apply-templates select="$content"/>

</xsl:template>

<xsl:template name="book.titlepage">

<fo:block font-family="Computer-Modern-Sans" font-weight="bold"
font-size="24.8832pt" text-align-last="justify" text-align="justify">
<fo:block space-before="2in">XSLTUK 01: April 8th-9th, 2001</fo:block>
<fo:block>Keble College, Oxford, UK</fo:block>
<fo:block font-style="italic">Preprints</fo:block></fo:block>

<fo:block font-family="Computer-Modern-Sans" font-weight="bold"
font-size="16pt" text-align-last="justify" text-align="justify"
space-before="2in">edited by Sebastian Rahtz and David
Pawson</fo:block> <fo:block space-before="4in">
  <fo:external-graphic src="ane4"
    content-width="6in"/>
</fo:block>
</xsl:template>

<xsl:template match="ackno">
  <fo:block
     text-align-last="center" font-weight="bold">Acknowledgements</fo:block>
  <fo:block>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

</xsl:stylesheet>

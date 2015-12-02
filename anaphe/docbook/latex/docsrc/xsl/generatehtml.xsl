<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'
                xmlns:docbook="http://www.oasis-open.org/docbook/xml/4.1.2"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                xmlns:xt="http://www.jclark.com/xt"
                xmlns:saxon="http://icl.com/saxon"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:xalanredirect="org.apache.xalan.xslt.extensions.Redirect"
                exclude-result-prefixes="doc docbook xsl"
                extension-element-prefixes="xt saxon xalan xalanredirect lxslt">

<xsl:import href="docbook/html/chunk.xsl"/>
<xsl:output method="html" indent="yes" encoding="ISO-8859-1"/>

<xsl:param name="graphic.default.extension">.gif</xsl:param>
<xsl:param name="section.autolabel" select="1"/>
<xsl:param name="section.label.includes.component.label" select="1"/>
<xsl:param name="chapter.autolabel" select="1"/>
<xsl:param name="part.autolabel" select="1"/>
<xsl:param name="toc.section.depth">4</xsl:param>
<xsl:param name="using.chunker" select="1"/>


<xsl:template match="refentry">
  <xsl:apply-imports/>
</xsl:template>

<xsl:template match="refdescription">
  <div class="{name(.)}">
    <a>
      <xsl:attribute name="name">
        <xsl:call-template name="object.id"/>
      </xsl:attribute>
    </a>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="refauthor">
  <div class="{name(.)}">
    <b>
      <a>
        <xsl:attribute name="name">
          <xsl:call-template name="object.id"/>
        </xsl:attribute>
      </a>
      <xsl:text>Author</xsl:text>
    </b>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="refversion">
  <div class="{name(.)}">
    <b>
      <a>
        <xsl:attribute name="name">
          <xsl:call-template name="object.id"/>
        </xsl:attribute>
      </a>
      <xsl:text>Version</xsl:text>
    </b>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="refparameter">
  <div class="{name(.)}">
    <b>
      <a>
        <xsl:attribute name="name">
          <xsl:call-template name="object.id"/>
        </xsl:attribute>
      </a>
      <xsl:text>Parameters</xsl:text>
    </b>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="refreturn">
  <div class="{name(.)}">
    <b>
      <a>
        <xsl:attribute name="name">
          <xsl:call-template name="object.id"/>
        </xsl:attribute>
      </a>
      <xsl:text>Returns</xsl:text>
    </b>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="refexception|refthrows">
  <div class="{name(.)}">
    <b>
      <a>
        <xsl:attribute name="name">
          <xsl:call-template name="object.id"/>
        </xsl:attribute>
      </a>
      <xsl:text>Exceptions</xsl:text>
    </b>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="refsee">
  <div class="{name(.)}">
    <b>
      <a>
        <xsl:attribute name="name">
          <xsl:call-template name="object.id"/>
        </xsl:attribute>
      </a>
      <xsl:text>See</xsl:text>
    </b>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="refsince">
  <div class="{name(.)}">
    <b>
      <a>
        <xsl:attribute name="name">
          <xsl:call-template name="object.id"/>
        </xsl:attribute>
      </a>
      <xsl:text>Since</xsl:text>
    </b>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="refserial">
  <div class="{name(.)}">
    <b>
      <a>
        <xsl:attribute name="name">
          <xsl:call-template name="object.id"/>
        </xsl:attribute>
      </a>
      <xsl:text>Serial</xsl:text>
    </b>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="refdeprecated">
  <div class="{name(.)}">
    <b>
      <a>
        <xsl:attribute name="name">
          <xsl:call-template name="object.id"/>
        </xsl:attribute>
      </a>
      <xsl:text>Deprecated</xsl:text>
    </b>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<!-- ==================================================================== -->

</xsl:stylesheet>

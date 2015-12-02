<?xml version='1.0'?>
<!--############################################################################# 
 |	$Id: table.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
<doc:reference id="table" xmlns="">
	<referenceinfo>
	<releaseinfo role="meta">
		$Id: table.mod.xsl,v 1.2 2001/04/16 16:02:37 rcasellas Exp $
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
	
	<title>Tables <filename>table.mod.xsl</filename></title>
	<partintro>
		<section><title>Introduction</title>
		<para></para>
		</section>
	</partintro>
</doc:reference>




<!--############################################################################# -->
<!-- DOCUMENTATION -->
<doc:template match="table|informaltable" xmlns="">
<refpurpose>XSL template for docbook tables.  </refpurpose>
<refdescription>
<para></para>
<formalpara><title>Remarks and Bugs</title>
<itemizedlist>
</itemizedlist>
</formalpara>
<formalpara><title>Default Behaviour</title>
<screen></screen>
</formalpara>
</refdescription>
</doc:template>
<!--############################################################################# -->


<xsl:template match="table|informaltable">
<xsl:call-template name="map.begin"/>
<xsl:apply-templates/>
<xsl:call-template name="map.end"/>
</xsl:template>

<xsl:template match="table/title"/>
<xsl:template match="informaltable/title"/>


<!-- FIX THIS -->
<xsl:template name="table.format.tabular">
  	<xsl:param name="cols" select="1"/>
	<xsl:param name="i" select="1"/>
  	<xsl:choose>
		<!-- Out of the recursive iteration -->
    		<xsl:when test="$i > $cols"></xsl:when>
		<!-- There are still columns to count -->
    		<xsl:otherwise>
        		<xsl:text>c|</xsl:text>
				<!-- Recursive for next column -->
      			<xsl:call-template name="table.format.tabular">
        				<xsl:with-param name="i" select="$i+1"/>
        				<xsl:with-param name="cols" select="$cols"/>
      			</xsl:call-template>
    		</xsl:otherwise>
	</xsl:choose>
</xsl:template>



<xsl:template match="tgroup">
<xsl:variable name="align" select="@align"/>
<xsl:variable name="colspecs" select="./colspec"/>
<!-- <xsl:text>{\tt </xsl:text> -->
<xsl:text>\begin{tabular}{</xsl:text>
<xsl:if test="@frame='' or @frame='all' or @frame='sides'">
	<xsl:text>|</xsl:text>
</xsl:if>
<xsl:call-template name="table.format.tabular">
     	<xsl:with-param name="cols" select="@cols"/>
</xsl:call-template>
<xsl:if test="@frame='' or @frame='all' or @frame='sides'">
	<xsl:text>|</xsl:text>
</xsl:if>
<xsl:text>}&#10;</xsl:text>
<xsl:if test="@frame!='sides' and @frame!='none' and @frame!='bottom'">
	<xsl:text>\hline</xsl:text>
</xsl:if>
	<!-- APPLY TEMPLATES -->
	<xsl:apply-templates/>
	<!--                 -->
<xsl:if test="@frame!='sides' and @frame!='none' and @frame!='top'">
	<xsl:text>\hline &#10;</xsl:text>
</xsl:if>
<xsl:text>\end{tabular}&#10;</xsl:text>
<!-- <xsl:text>}</xsl:text> -->
</xsl:template>



<!--
<xsl:template name="generate.col">
  <xsl:param name="countcol">1</xsl:param>
</xsl:template>
-->

<xsl:template match="colspec"></xsl:template>
<xsl:template match="spanspec"></xsl:template>




<xsl:template match="thead|tfoot">
<xsl:if test="@align">
      <xsl:attribute name="align">
        <xsl:value-of select="@align"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@char">
      <xsl:attribute name="char">
        <xsl:value-of select="@char"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@charoff">
      <xsl:attribute name="charoff">
        <xsl:value-of select="@charoff"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@valign">
      <xsl:attribute name="valign">
        <xsl:value-of select="@valign"/>
      </xsl:attribute>
    </xsl:if>
<xsl:apply-templates/>
</xsl:template>


<xsl:template match="thead/row/entry">
<xsl:apply-templates/><xsl:text> &amp; </xsl:text> 
</xsl:template>

<xsl:template match="thead/row/entry[position()=last()]">
<xsl:apply-templates/><xsl:text> \\ &#10;</xsl:text> 
</xsl:template>

<xsl:template match="tbody">
      <xsl:apply-templates/>
</xsl:template>

<xsl:template match="row">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="tbody/row|thead/row|tfoot/row">
<xsl:apply-templates/>
	<!-- The rule below the last row in the table is controlled by the 
	Frame attribute of the enclosing Table or InformalTable and the RowSep 
	of the last row is ignored. If unspecified, this attribute is 
	inherited from enclosing elements. -->
<xsl:if test="@rowsep='1' and position() != last()"> 
	<xsl:text> \hline &#10;</xsl:text>
</xsl:if>
</xsl:template>


<xsl:template match="tbody/row/entry">
<!--
  <xsl:call-template name="process.cell">
    <xsl:with-param name="cellgi">td</xsl:with-param>
  </xsl:call-template>
-->
<xsl:apply-templates/><xsl:text> &amp; </xsl:text> 
</xsl:template>


<xsl:template match="tbody/row/entry[position()=last()]">
<xsl:apply-templates/><xsl:text> \\ &#10;</xsl:text>
</xsl:template>















<xsl:template name="process.cell">
  <xsl:param name="cellgi">td</xsl:param>
  <xsl:variable name="empty.cell" select="count(node()) = 0"/>

  <xsl:element name="{$cellgi}">
    <xsl:if test="@morerows">
      <xsl:attribute name="rowspan">
        <xsl:value-of select="@morerows+1"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@namest">
      <xsl:attribute name="colspan">
        <xsl:call-template name="calculate.colspan"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@align">
      <xsl:attribute name="align">
        <xsl:value-of select="@align"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@char">
      <xsl:attribute name="char">
        <xsl:value-of select="@char"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@charoff">
      <xsl:attribute name="charoff">
        <xsl:value-of select="@charoff"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@valign">
      <xsl:attribute name="valign">
        <xsl:value-of select="@valign"/>
      </xsl:attribute>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="$empty.cell">
        <xsl:text>&#160;</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:element>
</xsl:template>

<xsl:template name="generate.colgroup">
  <xsl:param name="cols" select="1"/>
  <xsl:param name="count" select="1"/>
  <xsl:choose>
    <xsl:when test="$count>$cols"></xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="generate.col">
        <xsl:with-param name="countcol" select="$count"/>
      </xsl:call-template>
      <xsl:call-template name="generate.colgroup">
        <xsl:with-param name="cols" select="$cols"/>
        <xsl:with-param name="count" select="$count+1"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="generate.col">
  <xsl:param name="countcol">1</xsl:param>
  <xsl:param name="colspecs" select="./colspec"/>
  <xsl:param name="count">1</xsl:param>
  <xsl:param name="colnum">1</xsl:param>

  <xsl:choose>
    <xsl:when test="$count>count($colspecs)">
      <col/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="colspec" select="$colspecs[$count=position()]"/>
      <xsl:variable name="colspec.colnum">
        <xsl:choose>
          <xsl:when test="$colspec/@colnum">
            <xsl:value-of select="$colspec/@colnum"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$colnum"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:choose>
        <xsl:when test="$colspec.colnum=$countcol">
          <col>
            <xsl:if test="$colspec/@align">
              <xsl:attribute name="align">
                <xsl:value-of select="$colspec/@align"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="$colspec/@char">
              <xsl:attribute name="char">
                <xsl:value-of select="$colspec/@char"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="$colspec/@charoff">
              <xsl:attribute name="charoff">
                <xsl:value-of select="$colspec/@charoff"/>
              </xsl:attribute>
            </xsl:if>
          </col>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="generate.col">
            <xsl:with-param name="countcol" select="$countcol"/>
            <xsl:with-param name="colspecs" select="$colspecs"/>
            <xsl:with-param name="count" select="$count+1"/>
            <xsl:with-param name="colnum">
              <xsl:choose>
                <xsl:when test="$colspec/@colnum">
                  <xsl:value-of select="$colspec/@colnum + 1"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$colnum + 1"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
           </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template>

<xsl:template name="colspec.colnum">
  <!-- when this macro is called, the current context must be an entry -->
  <xsl:param name="colname"></xsl:param>
  <!-- .. = row, ../.. = thead|tbody, ../../.. = tgroup -->
  <xsl:param name="colspecs" select="../../../../tgroup/colspec"/>
  <xsl:param name="count">1</xsl:param>
  <xsl:param name="colnum">1</xsl:param>
  <xsl:choose>
    <xsl:when test="$count>count($colspecs)"></xsl:when>
    <xsl:otherwise>
      <xsl:variable name="colspec" select="$colspecs[$count=position()]"/>
<!--
      <xsl:value-of select="$count"/>:
      <xsl:value-of select="$colspec/@colname"/>=
      <xsl:value-of select="$colnum"/>
-->
      <xsl:choose>
        <xsl:when test="$colspec/@colname=$colname">
          <xsl:choose>
            <xsl:when test="$colspec/@colnum">
              <xsl:value-of select="$colspec/@colnum"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$colnum"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="colspec.colnum">
            <xsl:with-param name="colname" select="$colname"/>
            <xsl:with-param name="colspecs" select="$colspecs"/>
            <xsl:with-param name="count" select="$count+1"/>
            <xsl:with-param name="colnum">
              <xsl:choose>
                <xsl:when test="$colspec/@colnum">
                  <xsl:value-of select="$colspec/@colnum + 1"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$colnum + 1"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
           </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="colspec.colwidth">
  <!-- when this macro is called, the current context must be an entry -->
  <xsl:param name="colname"></xsl:param>
  <!-- .. = row, ../.. = thead|tbody, ../../.. = tgroup -->
  <xsl:param name="colspecs" select="../../../../tgroup/colspec"/>
  <xsl:param name="count">1</xsl:param>
  <xsl:choose>
    <xsl:when test="$count>count($colspecs)"></xsl:when>
    <xsl:otherwise>
      <xsl:variable name="colspec" select="$colspecs[$count=position()]"/>
      <xsl:choose>
        <xsl:when test="$colspec/@colname=$colname">
          <xsl:value-of select="$colspec/@colwidth"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="colspec.colwidth">
            <xsl:with-param name="colname" select="$colname"/>
            <xsl:with-param name="colspecs" select="$colspecs"/>
            <xsl:with-param name="count" select="$count+1"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="calculate.colspan">
  <xsl:variable name="scol">
    <xsl:call-template name="colspec.colnum">
      <xsl:with-param name="colname" select="@namest"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="ecol">
    <xsl:call-template name="colspec.colnum">
      <xsl:with-param name="colname" select="@nameend"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:value-of select="$ecol - $scol + 1"/>
</xsl:template>

</xsl:stylesheet>

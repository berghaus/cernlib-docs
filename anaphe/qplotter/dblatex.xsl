<?xml version='1.0'?>
<!-- minilatex.xsl --> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/XSL/Transform/1.0"
                xmlns="http://www.tug.org/latex"
                default-space="strip"
                result-ns="">

<xsl:template name="label">
  <xsl:apply-templates/>
  <xsl:if test="../@id"><xsl:text>\label{</xsl:text>
  <xsl:value-of select="../@id"/><xsl:text>}</xsl:text></xsl:if>
<xsl:text>}
</xsl:text>
</xsl:template>

<xsl:template match="book">
<xsl:apply-templates/>
</xsl:template>

<!--   ================ Frontmatter element ======================= -->
<xsl:template match="bookinfo">
<xsl:text>
\catcode`\&amp;=12
</xsl:text>
</xsl:template>

<!-- ===================== Bodymatter element ================= -->
<xsl:template match="appendix[position()=1]">
<xsl:text>
\appendix
</xsl:text>
<xsl:apply-templates/>
</xsl:template>
<xsl:template match="part|appendix|chapter|sect1|sect2|sect3|sect4|sect5">
  <xsl:apply-templates/>
</xsl:template>

<!-- ========= Section headings ============ -->
<xsl:template match="part/title">
  <xsl:text>\part{</xsl:text><xsl:call-template name="label"/>
</xsl:template>
<xsl:template match="appendix/title|chapter/title">
  <xsl:text>\chapter{</xsl:text><xsl:call-template name="label"/>
</xsl:template>
<xsl:template match="sect1/title">
  <xsl:text>\section{</xsl:text><xsl:call-template name="label"/>
</xsl:template>
<xsl:template match="sect2/title">
  <xsl:text>\subsection{</xsl:text><xsl:call-template name="label"/>
</xsl:template>
<xsl:template match="sect3/title">
  <xsl:text>\subsubsection{</xsl:text><xsl:call-template name="label"/>
</xsl:template>
<xsl:template match="sect4/title">
  <xsl:text>\paragraph{</xsl:text><xsl:call-template name="label"/>
</xsl:template>
<xsl:template match="sect5/title">
  <xsl:text>\subparagraph{</xsl:text><xsl:call-template name="label"/>
</xsl:template>

<!-- ========= Emphasis ============ -->

<xsl:template match="emphasis">
<xsl:text>\emph{</xsl:text>
  <xsl:apply-templates/>
<xsl:text>}</xsl:text>
</xsl:template>
<xsl:template match="application|classname|command|envar|function|interface|literal">
<xsl:text>\Lit{</xsl:text>
  <xsl:apply-templates/>
<xsl:text>}</xsl:text>
</xsl:template>
<xsl:template match="userinput">
<xsl:text>\Ucom{</xsl:text>
  <xsl:apply-templates/>
<xsl:text>}
</xsl:text>
</xsl:template>
<!-- ======== Cross-references ======== -->
<xsl:template match="xref">
  <xsl:text>\ref{</xsl:text>
  <xsl:value-of select="@linkend"/>
  <xsl:text>}</xsl:text>
</xsl:template>
<!-- ====== quotes, footnotes, verbatim ====== -->
<xsl:template match="footnote">
<xsl:text>\footnote{</xsl:text>
  <xsl:apply-templates/>
<xsl:text>}</xsl:text>
</xsl:template>
<xsl:template match="quote">
<xsl:text>``</xsl:text>
<xsl:apply-templates/>
<xsl:text>''</xsl:text>
</xsl:template>
<xsl:template match="programlisting" priority="1">
<xsl:choose>
<xsl:when test="userinput">
<xsl:text>
\begin{alltt}
</xsl:text>
  <xsl:apply-templates/>
<xsl:text>\end{alltt}
</xsl:text>
</xsl:when>
<xsl:otherwise>
<xsl:text>
\begin{verbatim}</xsl:text>
  <xsl:apply-templates/>
<xsl:text>\end{verbatim}
</xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:template>
<xsl:template match="informalexample/programlisting" priority="10">
<xsl:text>\begin{listing}</xsl:text>
  <xsl:apply-templates/>
<xsl:text>\end{listing}
</xsl:text>
</xsl:template>
<!-- ============ Lists ============== -->
<xsl:template match="description">
<xsl:text>
\begin{description}
</xsl:text>
  <xsl:apply-templates/>
<xsl:text>
\end{description}
</xsl:text>
</xsl:template>
<xsl:template match="variablelist">
<xsl:text>\begin{DLtt}{</xsl:text>
<xsl:choose>
<xsl:when test="@termlength">
<xsl:value-of select="@termlength"/>
</xsl:when>
<xsl:otherwise>
<xsl:text>MMMM</xsl:text>
</xsl:otherwise>
</xsl:choose>
<xsl:text>}
</xsl:text>
  <xsl:apply-templates/>
<xsl:text>
\end{DLtt}
</xsl:text>
</xsl:template>

<xsl:template match="varlistentry/term">
<xsl:text>
\item[</xsl:text>
  <xsl:apply-templates/>
<xsl:text>]</xsl:text>
</xsl:template>
<xsl:template match="listitem/simpara[position()=1]" priority="10">
<xsl:if test="not(from-ancestors(varlistentry))">
<xsl:text>
\item </xsl:text>
</xsl:if>
<xsl:apply-templates/>
</xsl:template>
<xsl:template match="orderedlist">
<xsl:text>
\begin{enumerate}
</xsl:text>
  <xsl:apply-templates/>
<xsl:text>\end{enumerate}
</xsl:text>
</xsl:template>
<xsl:template match="itemizedlist">
<xsl:text>
\begin{itemize}
</xsl:text>
  <xsl:apply-templates/>
<xsl:text>\end{itemize}
</xsl:text>
</xsl:template>
<!-- ======== inline and display math =========== -->
<xsl:template match="inlinemath">
<xsl:text>\begin{math}</xsl:text>
  <xsl:apply-templates/>
<xsl:text>\end{math}</xsl:text>
</xsl:template>
<xsl:template match="displaymath">
<xsl:text>
\begin{displaymath}
</xsl:text>
  <xsl:apply-templates/>
<xsl:text>
\end{displaymath}
</xsl:text>
</xsl:template>
<xsl:template match="equation">
<xsl:text>
\begin{equation}
</xsl:text>
  <xsl:apply-templates/>
<xsl:text>
\end{equation}
</xsl:text>
</xsl:template>
<xsl:template match="eqnarray">
<xsl:text>
\begin{eqnarray}
</xsl:text>
  <xsl:apply-templates/>
<xsl:text>
\end{eqnarray}
</xsl:text>
</xsl:template>
<!-- ===== everything that can go into a paragraph ===== -->
<xsl:template match="para|simpara">
<xsl:text>
\par
</xsl:text>
  <xsl:apply-templates/>
</xsl:template>
<!-- ===== tabular ===== -->
<xsl:template match="informaltable/tgroup|table/tgroup">
<xsl:text>
\begingroup\catcode`\&amp;=4
\begin{tabular}{</xsl:text>
  <xsl:value-of select="../@preamble"/><xsl:text>}
</xsl:text>
  <xsl:apply-templates/>
<xsl:text>
\end{tabular}\catcode`\&amp;=12\endgroup
</xsl:text>
</xsl:template>
<xsl:template match="tbody/row">  
<xsl:apply-templates/>
<xsl:text>\\
</xsl:text>
</xsl:template>
<xsl:template match="tbody/row/entry">  
<xsl:apply-templates/><xsl:text>&amp;</xsl:text>
</xsl:template>
<xsl:template match="tbody/row/entry[position()=last()]" priority="2">  
<xsl:apply-templates/>
</xsl:template>
<!-- ======= "floats" and their contents ========= -->
<xsl:template match="figure|table">
<xsl:text>
\begin{</xsl:text><xsl:value-of select="qname(.)"/>
<xsl:choose>
<xsl:when test="@loc">
<xsl:text>}[</xsl:text>
<xsl:value-of select="./@loc"/>
<xsl:text>]</xsl:text>
</xsl:when>
<xsl:otherwise>
<xsl:text>[tbhp]</xsl:text>
</xsl:otherwise>
</xsl:choose>
<xsl:text>\centering</xsl:text>
  <xsl:apply-templates/>
<xsl:text>\end{</xsl:text>
<xsl:value-of select="qname(.)"/>
<xsl:text>}
</xsl:text>
</xsl:template>
<xsl:template match="figure/title | table/title">
  <xsl:text>\caption{</xsl:text><xsl:call-template name="label"/>
</xsl:template>
<!--   ==================== Includegraphics ======================= -->
<xsl:template match="includegraphics">
<xsl:text>
\includegraphics[</xsl:text>
<xsl:if test="@width"><xsl:text>width=</xsl:text>
    <xsl:value-of select="@width"/><xsl:text>, </xsl:text></xsl:if>
<xsl:if test="@height"><xsl:text>height=</xsl:text>
    <xsl:value-of select="@height"/><xsl:text>, </xsl:text></xsl:if>
<xsl:if test="@bb"><xsl:text>bb="</xsl:text>
    <xsl:value-of select="@bb"/><xsl:text>, </xsl:text></xsl:if>
<xsl:if test="@angle"><xsl:text>angle=</xsl:text>
    <xsl:value-of select="@angle"/><xsl:text>, </xsl:text></xsl:if>
<xsl:if test="@scale"><xsl:text>scale=</xsl:text>
    <xsl:value-of select="@scale"/><xsl:text></xsl:text></xsl:if>
<xsl:text>]{</xsl:text><xsl:value-of select="@file"/><xsl:text>}
</xsl:text>
</xsl:template>
<!-- url -->
<xsl:template match="ulink">
<xsl:text>at the URL \url{</xsl:text>
<xsl:value-of select="@url"/>
<xsl:text>}</xsl:text>
</xsl:template>
<!-- Index commands (LaTeX-only) -->
<xsl:template match="indexterm">
<xsl:text>\index{</xsl:text>
<xsl:value-of select="primary"/>
<xsl:text>}%
</xsl:text>
</xsl:template>
</xsl:stylesheet>


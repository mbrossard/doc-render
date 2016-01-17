<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:d="http://docbook.org/ns/docbook"
  exclude-result-prefixes="d"
  version="1.0">

  <xsl:import href="./xsltproc-tables-fo.xsl"/>
  
  <!--
  The purpose of this file is to customize PDF related features
  (links, table of content).
  -->

  <!-- Make TOC lines blue -->
  <xsl:attribute-set name="toc.line.properties">
    <xsl:attribute name="color">blue</xsl:attribute>
  </xsl:attribute-set>

  <!-- Make internal references blue -->
  <xsl:attribute-set name="xref.properties">
	<xsl:attribute name="color">blue</xsl:attribute>
  </xsl:attribute-set>

  <!-- Make index page number blue -->
  <xsl:attribute-set name="index.page.number.properties">
    <xsl:attribute name="color">blue</xsl:attribute>
  </xsl:attribute-set>

  <!-- Add fragment identifiers for links into PDF files. The value of
  this parameter determines whether the cross reference URIs to PDF
  documents made with olink will include fragment identifiers. When
  forming a URI to link to a PDF document, a fragment identifier
  (typically a '#' followed by an id value) appended to the PDF
  filename can be used by the PDF viewer to open the PDF file to a
  location within the document instead of the first page. However, not
  all PDF files have id values embedded in them, and not all PDF
  viewers can handle fragment identifiers. If insert.olink.pdf.frag is
  set to a non-zero value, then any olink targeting a PDF file will
  have the fragment identifier appended to the URI. The URI is formed
  by concatenating the value of the olink.base.uri parameter, the
  value of the baseuri attribute from the document element in the
  olink database with the matching targetdoc value, and the value of
  the href attribute for the targeted element in the olink
  database. The href attribute contains the fragment identifier. If
  insert.olink.pdf.frag is set to zero (the default value), then the
  href attribute from the olink database is not appended to PDF
  olinks, so the fragment identifier is left off. A PDF olink is any
  olink for which the baseuri attribute from the matching document
  element in the olink database ends with '.pdf'. Any other olinks
  will still have the fragment identifier added.  -->

  <xsl:param name="insert.olink.pdf.frag" select="1"></xsl:param>

  <!-- Show ulink URLs as footnotes -->
  <xsl:param name="ulink.show" select="1"></xsl:param>
  <xsl:param name="ulink.footnotes" select="1"></xsl:param>

  <!-- Don't want italic -->
  <xsl:template match="d:chapter|d:appendix" mode="insert.title.markup">
    <xsl:param name="purpose"/>
    <xsl:param name="xrefstyle"/>
    <xsl:param name="title"/>
    
    <xsl:choose>
      <xsl:when test="$purpose = 'xref'">
        <xsl:copy-of select="$title"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:copy-of select="$title"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Don't want italic -->
  <xsl:template name="title.xref">
    <xsl:param name="target" select="."/>
    <xsl:choose>
      <xsl:when test="local-name($target) = 'figure'
	or local-name($target) = 'example'
	or local-name($target) = 'equation'
	or local-name($target) = 'table'
	or local-name($target) = 'dedication'
	or local-name($target) = 'acknowledgements'
	or local-name($target) = 'preface'
	or local-name($target) = 'bibliography'
	or local-name($target) = 'glossary'
	or local-name($target) = 'index'
	or local-name($target) = 'setindex'
	or local-name($target) = 'colophon'">
	<xsl:call-template name="gentext.startquote"/>
	<xsl:apply-templates select="$target" mode="title.markup"/>
	<xsl:call-template name="gentext.endquote"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:apply-templates select="$target" mode="title.markup"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Do not expand Bookmark entries below chapter level -->

  <xsl:template match="d:set|d:book|d:part|d:reference|d:preface|d:chapter
    |d:appendix|d:article|d:glossary|d:bibliography|d:index|d:setindex
    |d:refentry|d:sect1|d:sect2|d:sect3|d:sect4|d:sect5|d:section"
    mode="fop1.outline">

    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>
    <xsl:variable name="bookmark-label">
      <xsl:apply-templates select="." mode="object.title.markup"/>
    </xsl:variable>

    <!-- If the object is a set or book, generate a bookmark for the toc -->

    <xsl:choose>
      <xsl:when test="self::d:index and $generate.index = 0"/>
      <!-- MAT: Addition begins here -->
      <xsl:when test="self::d:chapter or self::d:appendix or self::d:preface">
	<fo:bookmark internal-destination="{$id}" starting-state="hide">
	  <fo:bookmark-title>
	    <xsl:value-of select="normalize-space(translate($bookmark-label, $a-dia, $a-asc))"/>
	  </fo:bookmark-title>
	  <xsl:apply-templates select="*" mode="fop1.outline"/>
	</fo:bookmark>
      </xsl:when>
      <xsl:when test="(self::d:section or self::d:appendix or self::d:preface) and //d:article">
	<fo:bookmark internal-destination="{$id}" starting-state="hide">
	  <fo:bookmark-title>
	    <xsl:value-of select="normalize-space(translate($bookmark-label, $a-dia, $a-asc))"/>
	  </fo:bookmark-title>
	  <xsl:apply-templates select="*" mode="fop1.outline"/>
	</fo:bookmark>
      </xsl:when>
      <!-- MAT: Addition ends here -->
      <xsl:when test="parent::*">
	<fo:bookmark internal-destination="{$id}">
	  <fo:bookmark-title>
	    <xsl:value-of select="normalize-space(translate($bookmark-label, $a-dia, $a-asc))"/>
	  </fo:bookmark-title>
	  <xsl:apply-templates select="*" mode="fop1.outline"/>
	</fo:bookmark>
      </xsl:when>
      <xsl:otherwise>
	<fo:bookmark internal-destination="{$id}">
	  <fo:bookmark-title>
	    <xsl:value-of select="normalize-space(translate($bookmark-label, $a-dia, $a-asc))"/>
	  </fo:bookmark-title>
	  
	  <xsl:variable name="toc.params">
	    <xsl:call-template name="find.path.params">
	      <xsl:with-param name="table" select="normalize-space($generate.toc)"/>
	    </xsl:call-template>
	  </xsl:variable>

	  <xsl:if test="contains($toc.params, 'toc')
	    and (d:book|d:part|d:reference|d:preface|d:chapter|d:appendix|d:article
	    |d:glossary|d:bibliography|d:index|d:setindex|d:refentry
	    |d:sect1|d:sect2|d:sect3|d:sect4|d:sect5|d:section)">
	    <fo:bookmark internal-destination="toc...{$id}">
	      <fo:bookmark-title>
		<xsl:call-template name="gentext">
		  <xsl:with-param name="key" select="'TableofContents'"/>
		</xsl:call-template>
	      </fo:bookmark-title>
	    </fo:bookmark>
	  </xsl:if>
	  <xsl:apply-templates select="*" mode="fop1.outline"/>
	</fo:bookmark>
      </xsl:otherwise>
    </xsl:choose>
    <!--
    <fo:bookmark internal-destination="{$id}"/>
    -->
  </xsl:template>
</xsl:stylesheet>
<!-- Keep this comment at the end of the file
Local variables:
mode: xml
sgml-indent-step:2
sgml-indent-data:t
End:
-->

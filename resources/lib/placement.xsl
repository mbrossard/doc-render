<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:d="http://docbook.org/ns/docbook"
  exclude-result-prefixes="d"
  version="1.0">

  <!-- ***************  ToC/LoT/Index Generation  *********************  -->
  <!-- ***************************************************  -->


  <!--

       This parameter has a structured value. It is a table of
       space-delimited path/value pairs. Each path identifies some
       element in the source document using a restricted subset of
       XPath (only the implicit child axis, no wildcards, no
       predicates). Paths can be either relative or absolute. When
       processing a particular element, the stylesheets consult this
       table to determine if a ToC (or LoT(s)) should be
       generated.

       For example, consider the entry: "book toc,figure" This
       indicates that whenever a book is formatted, a Table Of
       Contents and a List of Figures should be generated.

       Similarly, "/chapter toc" indicates that whenever a document
       that has a root of chapter is formatted, a Table of Contents
       should be generated. The entry chapter would match all
       chapters, but /chapter matches only chapter document
       elements.

       Generally, the longest match wins. So, for example, if you want
       to distinguish articles in books from articles in parts, you
       could use these two entries: "book/article toc,figure" and
       "part/article toc"

       Note that an article in a part can never match a book/article,
       so if you want nothing to be generated for articles in parts,
       you can simply leave that rule out.

       If you want to leave the rule in, to make it explicit that
       you're turning something off, use the value "nop". For example,
       the following entry disables ToCs and LoTs for articles:
       "article nop"

       Do not simply leave the word "article" in the file without a
       matching value. That'd be just begging the silly little
       path/value parser to get confused. Section ToCs are further
       controlled by the generate.section.toc.level parameter. For a
       given section level to have a ToC, it must have both an entry
       in generate.toc and be within the range enabled by
       generate.section.toc.level.
  
  -->

  <xsl:param name="generate.toc">
        appendix  title
        article   toc,title
        book      toc,title
        chapter   title
        part      title
        preface   title
        qandadiv  toc
        qandaset  toc
        reference nop
        section   nop
        set       title
  </xsl:param>

  <xsl:param name="toc.section.depth">3</xsl:param>

  <xsl:param name="formal.title.placement">
	figure after
	example after
	equation after
	table after
	procedure after
	task after
  </xsl:param>

  <xsl:template name="formal.object.heading">
    <xsl:param name="object" select="."/>
    <xsl:param name="placement" select="'before'"/>
    <xsl:choose>
      <xsl:when test="self::d:table or self::d:figure">
	<fo:block xsl:use-attribute-sets="formal.tablefigure.properties">
	  <xsl:apply-templates select="$object" mode="object.title.markup">
	    <xsl:with-param name="allow-anchors" select="1"/>
	  </xsl:apply-templates>
	</fo:block>
      </xsl:when>
      <xsl:otherwise>
	<fo:block xsl:use-attribute-sets="formal.title.properties">
	  <xsl:apply-templates select="$object" mode="object.title.markup">
	    <xsl:with-param name="allow-anchors" select="1"/>
	  </xsl:apply-templates>
	</fo:block>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
<!-- Keep this comment at the end of the file
Local variables:
mode: xml
sgml-indent-step:2
sgml-indent-data:t
End:
-->

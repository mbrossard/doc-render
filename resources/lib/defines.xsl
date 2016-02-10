<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">

  <xsl:param name="chunker.output.encoding">UTF-8</xsl:param>
  <xsl:param name="use.role.for.mediaobject">1</xsl:param>
  <xsl:param name="show.comments" select="0"/>
  <xsl:param name="resources.path">images</xsl:param>

  <!-- Localisation and customized templates -->
  <xsl:param name="local.l10n.xml" select="document('../local.l10n.xml')"/>

  <!-- Default values for private variables  -->
  <xsl:param name="debug">0</xsl:param>
  <xsl:param name="output.target">screen</xsl:param>

  <!-- ***************  Processor Extensions  *********************  -->
  <!-- ***************************************************  -->
  <!--
       If non-zero, FOP extensions will be used. At present, this
       consists of PDF bookmarks. This parameter can also affect which
       graphics file formats are supported.
  -->
  <xsl:param name="fop.extensions" select="0"></xsl:param>
  <xsl:param name="fop1.extensions" select="1"></xsl:param>

  <!--
        If non-zero, extensions may be used. Each extension is further
        controlled by its own parameter. But if use.extensions is
        zero, no extensions will be used.
  -->
  <xsl:param name="use.extensions" select="'1'"></xsl:param>
  <xsl:param name="axf.extensions">0</xsl:param>
  <xsl:param name="xep.extensions">0</xsl:param>
  <xsl:param name="tablecolumns.extension">1</xsl:param>

  <!--
        Profiling tricks
  -->
  <xsl:variable name="profile.vendor">
    <xsl:if test="//@vendor">
      <xsl:value-of select="//@vendor"/>
    </xsl:if>
  </xsl:variable>

  <xsl:variable name="profile.condition">
    <xsl:if test="//@condition">
      <xsl:value-of select="//@condition"/>
    </xsl:if>
  </xsl:variable>

  <xsl:variable name="profile.conformance">
    <xsl:if test="//@conformance">
      <xsl:value-of select="//@conformance"/>
    </xsl:if>
  </xsl:variable>

</xsl:stylesheet>
<!-- Keep this comment at the end of the file
Local variables:
mode: xml
sgml-indent-step:2
sgml-indent-data:t
End:
-->

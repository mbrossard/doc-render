<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- The local path to DocBook HMTL stylesheets -->
  <xsl:import href="docbook-xsl/html/profile-chunk.xsl"/>

  <!-- The local path to common customization stylesheet -->
  <xsl:import href="lib/defines.xsl"/>
  <xsl:import href="lib/html.xsl"/>
  <xsl:import href="lib/html-tables.xsl"/>

  <!-- The path to local customization stylesheet -->
  <xsl:import href="custom/html.xsl"/>

  <xsl:param name="use.role.for.mediaobject">1</xsl:param>
  <xsl:param name="chunker.output.indent">yes</xsl:param>
  <xsl:param name="chunker.output.encoding">UTF-8</xsl:param>
  <xsl:param name="chunk.section.depth">2</xsl:param>
  <xsl:param name="chunk.tocs.and.lots">1</xsl:param>
  <xsl:param name="chunk.first.sections">1</xsl:param>
  <xsl:param name="html.stylesheet">style.css</xsl:param>
  
  <xsl:template match="*" mode="class.value">
    <xsl:param name="class" select="local-name(.)"/>
    <!-- permit customization of class value -->
    <!-- Use element name by default -->
    <xsl:value-of select="$class"/>
  </xsl:template>
  
</xsl:stylesheet>
<!-- Keep this comment at the end of the file
Local variables:
mode: xml
sgml-indent-step:2
sgml-indent-data:t
End:
-->

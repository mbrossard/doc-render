<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">

  <!-- ***************  Paper size  *********************  -->
  <!-- ***************************************************  -->
  <!--
        Select the paper type. The paper type is a convenient way to
        specify the paper size. The list of known paper sizes includes
        USletter and most of the A, B, and C sizes. See
        page.width.portrait, for example.
  -->
  <xsl:param name="paper.type" select="'USletter'"></xsl:param>

  <!-- ***************  Size paramater  *********************  -->
  <!-- ***************************************************  -->

  <xsl:param name="body.font.master">9</xsl:param>
  <xsl:param name="default.image.width">12cm</xsl:param>
  <xsl:param name="default.table.width">100%</xsl:param>
  <xsl:param name="page.margin.top">1.0cm</xsl:param>
  <xsl:param name="page.margin.bottom">1.5cm</xsl:param>
  <xsl:param name="body.margin.top">1.0cm</xsl:param>
  <xsl:param name="body.margin.bottom">1.0cm</xsl:param>
  <xsl:param name="page.margin.inner">2.0cm</xsl:param>
  <xsl:param name="page.margin.outer">2.0cm</xsl:param>
  <xsl:param name="body.start.indent">0cm</xsl:param>

</xsl:stylesheet>
<!-- Keep this comment at the end of the file
Local variables:
mode: xml
sgml-indent-step:2
sgml-indent-data:t
End:
-->

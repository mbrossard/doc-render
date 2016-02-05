<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">

  <!-- The local path to DocBook Epub3 stylesheets -->
  <xsl:import href="docbook-xsl/epub3/profile-chunk.xsl"/>

  <!-- The local path to your common customization stylesheet -->
  <xsl:import href="lib/defines.xsl"/>
  <xsl:import href="lib/defines-epub.xsl"/>

  <xsl:param name="default.table.width"></xsl:param>
  <xsl:param name="no.table.summary">1</xsl:param>

  <!-- The path to local customization stylesheet -->
  <xsl:import href="custom/epub3.xsl"/>
  
</xsl:stylesheet>
<!-- Keep this comment at the end of the file
Local variables:
mode: xml
sgml-indent-step:2
sgml-indent-data:t
End:
-->

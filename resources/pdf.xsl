<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">

  <!-- The local path to DocBook FO stylesheets -->
  <xsl:import href="docbook-xsl/fo/profile-docbook.xsl"/>
  <xsl:import href="docbook-xsl/fo/titlepage.templates.xsl"/>

  <!-- The local path to your common customization stylesheet -->
  <xsl:import href="lib/defines.xsl"/>
  <xsl:import href="lib/defines-a4.xsl"/>
  <xsl:import href="lib/defines-pdf.xsl"/>
  <xsl:import href="lib/placement.xsl"/>
  <xsl:import href="lib/style.xsl"/>
  <xsl:import href="lib/headers-footers.xsl"/>
  <xsl:import href="lib/titlepage-a4.xsl"/>

</xsl:stylesheet>
<!-- Keep this comment at the end of the file
Local variables:
mode: xml
sgml-indent-step:2
sgml-indent-data:t
End:
-->

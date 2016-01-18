<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:exsl="http://exslt.org/common"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="exsl">

  <xsl:template name="dump-fragment">
    <xsl:param name="fragment"/>
    <xsl:apply-templates select="exsl:node-set($fragment)/*" mode="dump-fragment"/>
  </xsl:template>

  <xsl:template match="@*" mode="dump-fragment">
    <xsl:text> </xsl:text>
    <xsl:value-of select="local-name(.)"/>
    <xsl:text>="</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>"</xsl:text>
  </xsl:template>

  <xsl:template match="*" mode="dump-fragment">
    <xsl:text>&lt;</xsl:text><xsl:value-of select="local-name(.)"/>
    <xsl:apply-templates select="@*" mode="dump-fragment"/>
    <xsl:text>></xsl:text>
    <xsl:apply-templates mode="dump-fragment"/>
    <xsl:text>&lt;/</xsl:text><xsl:value-of select="local-name(.)"/>
    <xsl:text>></xsl:text>
  </xsl:template>

</xsl:stylesheet>
<!-- Keep this comment at the end of the file
Local variables:
mode: xml
sgml-indent-step:2
sgml-indent-data:t
End:
-->

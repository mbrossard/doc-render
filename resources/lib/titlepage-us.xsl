<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:d="http://docbook.org/ns/docbook"
  exclude-result-prefixes="d"
  version="1.0">

  <xsl:import href="titlepage.xsl"/>

  <!-- ***************  Book  *********************  -->

  <xsl:template name="book.titlepage.before.recto">
    
    <!-- This is the logo -->
    <!--
    <fo:block-container position="absolute" top="-1.1cm" left="0cm">
      <fo:block>
	    <fo:external-graphic content-width="20%" src="{$resources.path}/images/logo.svg"/>
      </fo:block>
    </fo:block-container>
    <!-->
    <fo:block-container position="absolute" top="0cm" left="0cm" background-color="#444444" height="0.5pt" width="17cm">
      <fo:block></fo:block>
    </fo:block-container>
    
    <!-- This is the banner -->
    <!--
        <fo:block-container position="absolute" top="2.7cm" left="3.8cm">
        <fo:block>
	    <fo:external-graphic src="{$resources.path}/images/banner.png"/>
        </fo:block>
        </fo:block-container>
    -->
  </xsl:template>

  <xsl:attribute-set name="book.titlepage.recto.properties">
    <xsl:attribute name="position">absolute</xsl:attribute>
    <xsl:attribute name="top">11.5cm</xsl:attribute>
    <xsl:attribute name="left">4cm</xsl:attribute>
    <xsl:attribute name="height">3.5cm</xsl:attribute>
    <xsl:attribute name="width">13.5cm</xsl:attribute>
    <xsl:attribute name="display-align">center</xsl:attribute>
    <!-- <xsl:attribute name="background-color">#eeeeee</xsl:attribute> -->
  </xsl:attribute-set>

  <!-- ***************  Article  *********************  -->

  <xsl:template name="article.titlepage.before.recto">
    <!-- This is the logo -->
    <!--
    <fo:block-container position="absolute" top="-1.1cm" left="-1cm">
      <fo:block>
        <fo:external-graphic content-width="20%" src="{$resources.path}/images/logo.svg"/>
      </fo:block>
    </fo:block-container>
    -->
    <fo:block-container position="absolute" top="0cm" left="0cm" background-color="#444444" height="0.5pt" width="17cm">
      <fo:block></fo:block>
    </fo:block-container>
    
    <!-- This is the banner -->
    <!--
        <fo:block-container position="absolute" top="2.7cm" left="2.8cm">
        <fo:block>
        <fo:external-graphic src="{$resources.path}/images/banner.png"/>
        </fo:block>
        </fo:block-container>
    -->
  </xsl:template>

  <xsl:attribute-set name="article.titlepage.recto.properties">
    <xsl:attribute name="position">absolute</xsl:attribute>
    <xsl:attribute name="top">11.5cm</xsl:attribute>
    <xsl:attribute name="left">4cm</xsl:attribute>
    <xsl:attribute name="height">3.5cm</xsl:attribute>
    <xsl:attribute name="width">13.5cm</xsl:attribute>
    <xsl:attribute name="display-align">center</xsl:attribute>
    <!-- <xsl:attribute name="background-color">#eeeeee</xsl:attribute> -->
  </xsl:attribute-set>

</xsl:stylesheet>
<!-- Keep this comment at the end of the file
Local variables:
mode: xml
sgml-indent-step:2
sgml-indent-data:t
End:
-->

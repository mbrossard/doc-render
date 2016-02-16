<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="placement.xsl"/>

  <xsl:param name="use.id.as.filename" select="1"/>
  <xsl:param name="generate.id.attributes" select="1"/>
  <!-- <xsl:param name="css.decoration" select="1"/> -->

  <xsl:param name="section.autolabel">1</xsl:param>
  <xsl:param name="section.label.includes.component.label">1</xsl:param>
  <xsl:param name="section.autolabel.max.depth">4</xsl:param>


  <xsl:param name="navig.graphics">1</xsl:param>  
  <xsl:param name="navig.graphics.path">icons/</xsl:param>
  <xsl:param name="navig.graphics.extension">.png</xsl:param>  

  <xsl:template name="head.content">
    <xsl:param name="node" select="."/>
    <xsl:param name="title">
      <xsl:apply-templates select="$node" mode="object.title.markup.textonly"/>
    </xsl:param>

    <title>
      <xsl:copy-of select="$title"/>
    </title>

    <xsl:if test="$html.stylesheet != ''">
      <xsl:call-template name="output.html.stylesheets">
        <xsl:with-param name="stylesheets" select="normalize-space($html.stylesheet)"/>
      </xsl:call-template>
    </xsl:if>

    <xsl:if test="$link.mailto.url != ''">
      <link rev="made" href="{$link.mailto.url}"/>
    </xsl:if>

    <xsl:if test="$html.base != ''">
      <base href="{$html.base}"/>
    </xsl:if>

    <meta name="generator" content="DocBook {$DistroTitle} V{$VERSION}"/>

    <xsl:if test="($draft.mode = 'yes' or ($draft.mode = 'maybe' and ancestor-or-self::*[@status][1]/@status = 'draft')) and $draft.watermark.image != ''">
      <style type="text/css"><xsl:text>
        body { background-image: url('</xsl:text><xsl:value-of select="$draft.watermark.image"/><xsl:text>');
        background-repeat: repeat-y;
        background-position: top center;
        }</xsl:text>
      </style>
    </xsl:if>
    <xsl:apply-templates select="." mode="head.keywords.content"/>
  </xsl:template>

  <xsl:template name="breadcrumbs">
    <xsl:param name="this.node" select="."/>
    <div class="breadcrumbs">
      <xsl:for-each select="$this.node/ancestor::*[parent::*]">
        <!-- <xsl:for-each select="$this.node/ancestor::*"> -->
        <span class="breadcrumb-link">
          <a>
            <xsl:attribute name="href">
              <xsl:call-template name="href.target">
                <xsl:with-param name="object" select="."/>
                <xsl:with-param name="context" select="$this.node"/>
              </xsl:call-template>
            </xsl:attribute>
            <xsl:apply-templates select="." mode="title.markup"/>
          </a>
        </span>
        <xsl:text> &#187; </xsl:text>
      </xsl:for-each>
      <!-- And display the current node, but not as a link -->
      <span class="breadcrumb-node">
        <xsl:apply-templates select="$this.node" mode="title.markup"/>
      </span>
    </div>
  </xsl:template>

  <xsl:template name="user.header.content">
    <xsl:call-template name="breadcrumbs"/>
    <hr/>
  </xsl:template>

</xsl:stylesheet>
<!-- Keep this comment at the end of the file
Local variables:
mode: xml
sgml-indent-step:2
sgml-indent-data:t
End:
-->

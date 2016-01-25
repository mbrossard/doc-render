<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:d="http://docbook.org/ns/docbook"
    exclude-result-prefixes="d"
    version="1.0">
  
  <xsl:template match="d:caution/d:simpara|d:important/d:simpara|d:note/d:simpara|d:tip/d:simpara|d:warning/d:simpara">
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template name="nongraphical.admonition">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>

    <fo:block id="{$id}"
              xsl:use-attribute-sets="nongraphical.admonition.properties">
      <xsl:if test="$admon.textlabel != 0 or d:title or d:info/d:title">
        <fo:inline
            xsl:use-attribute-sets="admonition.title.properties">
          <xsl:apply-templates select="." mode="object.title.markup">
            <xsl:with-param name="allow-anchors" select="1"/>
            </xsl:apply-templates><xsl:text>: </xsl:text>
        </fo:inline>
      </xsl:if>

      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template name="process.image">
    <xsl:variable name="scalefit">
      <xsl:choose>
        <xsl:when test="$ignore.image.scaling != 0">0</xsl:when>
        <xsl:when test="@contentwidth">0</xsl:when>
        <xsl:when test="@contentdepth and 
                        @contentdepth != '100%'">0</xsl:when>
        <xsl:when test="@scale">0</xsl:when>
        <xsl:when test="@scalefit"><xsl:value-of select="@scalefit"/></xsl:when>
        <xsl:when test="@width or @depth">1</xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="scale">
      <xsl:choose>
        <xsl:when test="$ignore.image.scaling != 0">0</xsl:when>
        <xsl:when test="@contentwidth or @contentdepth">1.0</xsl:when>
        <xsl:when test="@scale">
          <xsl:value-of select="@scale div 100.0"/>
        </xsl:when>
        <xsl:otherwise>1.0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="filename">
      <xsl:choose>
        <xsl:when test="local-name(.) = 'graphic'
                        or local-name(.) = 'inlinegraphic'">
          <!-- handle legacy graphic and inlinegraphic by new template --> 
          <xsl:call-template name="mediaobject.filename">
            <xsl:with-param name="object" select="."/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <!-- imagedata, videodata, audiodata -->
          <xsl:call-template name="mediaobject.filename">
            <xsl:with-param name="object" select=".."/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="content-type">
      <xsl:if test="@format">
        <xsl:call-template name="graphic.format.content-type">
          <xsl:with-param name="format" select="@format"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:variable>

    <xsl:variable name="bgcolor">
      <xsl:call-template name="dbfo-attribute">
        <xsl:with-param name="pis"
                        select="../processing-instruction('dbfo')"/>
        <xsl:with-param name="attribute" select="'background-color'"/>
      </xsl:call-template>
    </xsl:variable>

    <fo:external-graphic>
      <xsl:attribute name="src">
        <xsl:call-template name="fo-external-image">
          <xsl:with-param name="filename">
            <xsl:if test="$img.src.path != '' and
                          not(starts-with($filename, '/')) and
                          not(contains($filename, '://'))">
              <xsl:value-of select="$img.src.path"/>
            </xsl:if>
            <xsl:value-of select="$filename"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:attribute>

      <xsl:attribute name="width">
        <xsl:choose>
          <xsl:when test="$ignore.image.scaling != 0">auto</xsl:when>
          <xsl:when test="contains(@width,'auto')">auto</xsl:when>
          <xsl:when test="contains(@width,'%')">
            <xsl:value-of select="@width"/>
          </xsl:when>
          <xsl:when test="@width and not(@width = '')">
            <xsl:call-template name="length-spec">
              <xsl:with-param name="length" select="@width"/>
              <xsl:with-param name="default.units" select="'px'"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="not(@depth) and $default.image.width != ''">
            <xsl:call-template name="length-spec">
              <xsl:with-param name="length" select="$default.image.width"/>
              <xsl:with-param name="default.units" select="'px'"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>auto</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>

      <xsl:attribute name="height">
        <xsl:choose>
          <xsl:when test="$ignore.image.scaling != 0">auto</xsl:when>
          <xsl:when test="contains(@height,'auto')">auto</xsl:when>
          <xsl:when test="contains(@depth,'auto')">auto</xsl:when>
          <xsl:when test="contains(@depth,'%')">
            <xsl:value-of select="@depth"/>
          </xsl:when>
          <xsl:when test="@depth and not (@depth = 'auto')">
            <xsl:call-template name="length-spec">
              <xsl:with-param name="length" select="@depth"/>
              <xsl:with-param name="default.units" select="'px'"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>auto</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>

      <xsl:attribute name="content-width">
        <xsl:choose>
          <xsl:when test="$ignore.image.scaling != 0">auto</xsl:when>
          <xsl:when test="contains(@contentwidth,'auto')">auto</xsl:when>
          <xsl:when test="contains(@contentwidth,'%')">
            <xsl:value-of select="@contentwidth"/>
          </xsl:when>
          <xsl:when test="@contentwidth">
            <xsl:call-template name="length-spec">
              <xsl:with-param name="length" select="@contentwidth"/>
              <xsl:with-param name="default.units" select="'px'"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="number($scale) != 1.0">
            <xsl:value-of select="$scale * 100"/>
            <xsl:text>%</xsl:text>
          </xsl:when>
          <xsl:when test="$scalefit = 1">scale-to-fit</xsl:when>
          <xsl:otherwise>auto</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>

      <xsl:attribute name="content-height">
        <xsl:choose>
          <xsl:when test="$ignore.image.scaling != 0">auto</xsl:when>
          <xsl:when test="contains(@contentheight,'auto')">auto</xsl:when>
          <xsl:when test="contains(@contentdepth,'%')">
            <xsl:value-of select="@contentdepth"/>
          </xsl:when>
          <xsl:when test="@contentdepth">
            <xsl:call-template name="length-spec">
              <xsl:with-param name="length" select="@contentdepth"/>
              <xsl:with-param name="default.units" select="'px'"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="number($scale) != 1.0">
            <xsl:value-of select="$scale * 100"/>
            <xsl:text>%</xsl:text>
          </xsl:when>
          <xsl:when test="$scalefit = 1">scale-to-fit</xsl:when>
          <xsl:otherwise>auto</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>

      <xsl:if test="$content-type != ''">
        <xsl:attribute name="content-type">
          <xsl:value-of select="concat('content-type:',$content-type)"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="$bgcolor != ''">
        <xsl:attribute name="background-color">
          <xsl:value-of select="$bgcolor"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@align">
        <xsl:attribute name="text-align">
          <xsl:value-of select="@align"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@valign">
        <xsl:attribute name="display-align">
          <xsl:choose>
            <xsl:when test="@valign = 'top'">before</xsl:when>
            <xsl:when test="@valign = 'middle'">center</xsl:when>
            <xsl:when test="@valign = 'bottom'">after</xsl:when>
            <xsl:otherwise>auto</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
      </xsl:if>
    </fo:external-graphic>
  </xsl:template>
</xsl:stylesheet>
<!-- Keep this comment at the end of the file
Local variables:
mode: xml
sgml-indent-step:2
sgml-indent-data:t
End:
-->

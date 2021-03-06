<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                xmlns:func="http://exslt.org/functions"
                xmlns:dtbl="http://docbook.sourceforge.net/dtbl"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                extension-element-prefixes="func"
                exclude-result-prefixes="exsl func dtbl"
                version="1.0">

  <!-- Based on the work of sjs@khadrin.com :
       http://www.oasis-open.org/archives/docbook-apps/200601/msg00155.html -->

  <xsl:param name="adjustColumnWidths.debug" select="false()"/>
  <!--<xsl:param name="adjustColumnWidths.debug" select="true()"/> -->

  <func:function name="dtbl:convertLength">
    <xsl:param name="arbitrary.length"/>

    <xsl:variable name="pixels.per.inch" select="300"/>

    <xsl:variable name="unscaled.length"
                  select="translate($arbitrary.length, 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ', '')"/>

    <xsl:variable name="units"
                  select="translate($arbitrary.length,'+-0123456789. ', '')"/>

    <xsl:variable name="scaled.length">
      <xsl:choose>
        <xsl:when test="$units='in'">
          <xsl:value-of select="$unscaled.length * 72"/>
        </xsl:when>
        <xsl:when test="$units='cm'">
          <xsl:value-of select="$unscaled.length * (72 div 2.54)"/>
        </xsl:when>
        <xsl:when test="$units='mm'">
          <xsl:value-of select="$unscaled.length * (72 div 25.4)"/>
        </xsl:when>
        <xsl:when test="$units='pc'">
          <xsl:value-of select="$unscaled.length * 12"/>
        </xsl:when>
        <xsl:when test="$units='pt'">
          <xsl:value-of select="$unscaled.length"/>
        </xsl:when>
        <xsl:when test="$units='px' or $units=''">
          <xsl:value-of select="$unscaled.length * (72 div $pixels.per.inch)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:message terminate="no">
            <xsl:text>"</xsl:text>
            <xsl:value-of select="$units"/>
            <xsl:text>" is not a known unit.  Applying scaling factor of 1 instead.</xsl:text>
          </xsl:message>
          <xsl:value-of select="$unscaled.length"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <func:result select="round($scaled.length)"/>
  </func:function>

  <func:function name="dtbl:adjustColumnWidths">
    <xsl:param name="colgroup"/>

    <xsl:if test="$adjustColumnWidths.debug">
      <xsl:message>
        <xsl:text>entering adjustColumnWidths(</xsl:text>
        <xsl:call-template name="dump-fragment">
          <xsl:with-param name="fragment" select="$colgroup"/>
        </xsl:call-template>
        <xsl:text>)</xsl:text>
      </xsl:message>
    </xsl:if>

    <xsl:variable name="expanded.colgroup">
      <xsl:apply-templates select="exsl:node-set($colgroup)" mode="dtbl-split-widths"/>
    </xsl:variable>

    <xsl:if test="$adjustColumnWidths.debug">
      <xsl:message>Expanded Colgroup
      <xsl:text>(</xsl:text>
      <xsl:call-template name="dump-fragment">
        <xsl:with-param name="fragment" select="$expanded.colgroup"/>
      </xsl:call-template>
      <xsl:text>)</xsl:text>
      </xsl:message>
    </xsl:if>


    <xsl:variable name="absolute.widths.total">
      <xsl:value-of select="sum(exsl:node-set($expanded.colgroup)//table-column/@abswidth)"/>
    </xsl:variable>

    <xsl:variable name="relative.widths.total">
      <xsl:value-of select="sum(exsl:node-set($expanded.colgroup)//table-column/@relwidth)"/>
    </xsl:variable>

    <xsl:if test="$adjustColumnWidths.debug">
      <xsl:message>
        <xsl:text>total relative widths = (</xsl:text>
        <xsl:value-of select="$relative.widths.total"/>
        <xsl:text>)</xsl:text>
      </xsl:message>
      <xsl:message>
        <xsl:text>total absolute widths = (</xsl:text>
        <xsl:value-of select="$absolute.widths.total"/>
        <xsl:text>)</xsl:text>
      </xsl:message>
    </xsl:if>

    <xsl:variable name="adjusted.colgroup">
      <xsl:choose>
        <xsl:when test="$relative.widths.total = 0">
          <xsl:if test="$adjustColumnWidths.debug">
            <xsl:message>all widths are absolute</xsl:message>
          </xsl:if>
          <xsl:apply-templates select="exsl:node-set($expanded.colgroup)/*"
                               mode="dtbl-use-absolute-widths"/>
        </xsl:when>
        <xsl:when test="$absolute.widths.total = 0">
          <xsl:if test="$adjustColumnWidths.debug">
            <xsl:message>all widths are relative</xsl:message>
          </xsl:if>
          <xsl:apply-templates select="exsl:node-set($expanded.colgroup)/*"
                               mode="dtbl-use-relative-widths">
            <xsl:with-param name="relative.widths.total"
                            select="$relative.widths.total"/>
          </xsl:apply-templates>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>

    <xsl:if test="$adjustColumnWidths.debug">
      <xsl:message>
        <xsl:text>result = (</xsl:text>
        <xsl:call-template name="dump-fragment">
          <xsl:with-param name="fragment" select="$adjusted.colgroup"/>
        </xsl:call-template>
        <xsl:text>)</xsl:text>
      </xsl:message>
    </xsl:if>

    <xsl:variable name="corrected.adjusted.colgroup">
      <xsl:choose>
        <xsl:when test="$relative.widths.total = 0">
          <xsl:copy-of select="$adjusted.colgroup"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="widths.total"
                        select="sum(exsl:node-set($adjusted.colgroup)//table-column/@column-width)"/>
          <xsl:variable name="n.columns"
                        select="count(exsl:node-set($adjusted.colgroup)//table-column)"/>
          <xsl:variable name="error"
                        select="100 - $widths.total"/>
          <xsl:variable name="first.bad.column"
                        select="($n.columns - $error) + 1"/>
          <xsl:apply-templates select="exsl:node-set($adjusted.colgroup)/*"
                               mode="dtbl-correct-rounding-error">
            <xsl:with-param name="first.bad.column"
                            select="$first.bad.column"/>
          </xsl:apply-templates>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!--
        <xsl:if test="$adjustColumnWidths.debug">
        <xsl:message>
        <xsl:text>result = (</xsl:text>
        <xsl:call-template name="dump-fragment">
        <xsl:with-param name="fragment" select="$corrected.adjusted.colgroup"/>
        </xsl:call-template>
        <xsl:text>)</xsl:text>
        </xsl:message>
        </xsl:if>

<func:result select="$corrected.adjusted.colgroup"/>
<xsl:if test="$adjustColumnWidths.debug">
<xsl:message>
<xsl:text>result = (</xsl:text>
<xsl:call-template name="dump-fragment">
<xsl:with-param name="fragment" select="$adjusted.colgroup"/>
</xsl:call-template>
<xsl:text>)</xsl:text>
</xsl:message>
</xsl:if>
    -->
    
	<func:result select="$adjusted.colgroup"/>
  </func:function>

  <xsl:template match="colgroup" mode="dtbl-correct-rounding-error">
    <xsl:param name="first.bad.column"/>

    <xsl:if test="$adjustColumnWidths.debug">
      <xsl:message>
        <xsl:text>first.bad.column = (</xsl:text>
        <xsl:value-of select="$first.bad.column"/>
        <xsl:text>)</xsl:text>
      </xsl:message>
    </xsl:if>

    <colgroup>
      <xsl:for-each select="col[position() &lt; $first.bad.column]">
        <xsl:element name="table-column">
          <xsl:attribute name="column-width">
            <xsl:value-of select="concat(@column-width, '%')"/>
          </xsl:attribute>
        </xsl:element>
      </xsl:for-each>
      <xsl:for-each select="col[position() >= $first.bad.column]">
        <xsl:element name="table-column">
          <xsl:attribute name="column-width">
            <xsl:value-of select="concat(@column-width + 1, '%')"/>
          </xsl:attribute>
        </xsl:element>
      </xsl:for-each>
    </colgroup>
  </xsl:template>

  <xsl:template match="table-column" mode="dtbl-correct-rounding-error">
    <xsl:param name="error"/>

    <xsl:element name="table-column">
      <xsl:attribute name="column-width">
        <xsl:value-of select="concat(round((@relwidth div $relative.widths.total) * 100))"/>
      </xsl:attribute>
      <xsl:apply-templates mode="dtbl-use-absolute-widths"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="colgroup" mode="dtbl-use-relative-widths">
    <xsl:param name="relative.widths.total"/>

    <colgroup>
      <xsl:apply-templates mode="dtbl-use-relative-widths">
        <xsl:with-param name="relative.widths.total"
                        select="$relative.widths.total"/>
      </xsl:apply-templates>
    </colgroup>
  </xsl:template>

  <xsl:template match="table-column" mode="dtbl-use-relative-widths">
    <xsl:param name="relative.widths.total"/>

    <xsl:element name="fo:table-column">
      <xsl:attribute name="column-width">
        <xsl:value-of select="round((@relwidth div $relative.widths.total) * 100)"/>
        <xsl:text>%</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates mode="dtbl-use-absolute-widths"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="colgroup" mode="dtbl-use-absolute-widths">
    <colgroup>
      <xsl:apply-templates mode="dtbl-use-absolute-widths"/>
    </colgroup>
  </xsl:template>

  <xsl:template match="table-column" mode="dtbl-use-absolute-widths">
    <xsl:element name="fo:table-column">
      <xsl:attribute name="column-width">
        <xsl:value-of select="@abswidth"/>
        <xsl:text>pt</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates mode="dtbl-use-absolute-widths"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="colgroup" mode="dtbl-split-widths">
    <colgroup>
      <xsl:apply-templates mode="dtbl-split-widths"/>
    </colgroup>
  </xsl:template>

  <xsl:template match="*" mode="dtbl-split-widths">
    <!-- width = @column-width ? @column-width : '1*' -->
    <xsl:variable name="width">
      <xsl:choose>
        <xsl:when test="@column-width != ''">
          <xsl:value-of select="@column-width"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>1*</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- absolute.width = contains($width,'*') ? substring-after($width, '*') : $width -->
    <xsl:variable name="absolute.width">
      <xsl:choose>
        <xsl:when test="contains($width, '*')">
          <xsl:value-of select="substring-after($width, '*')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$width"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="converted.absolute.width">
      <xsl:choose>
        <xsl:when test="$absolute.width != ''">
          <xsl:value-of select="dtbl:convertLength($absolute.width)"/>
        </xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="relative.width">
      <xsl:choose>
        <xsl:when test="substring-before($width, '*') != ''">
          <xsl:value-of select="substring-before($width, '*')"/>
        </xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:element name="table-column">
      <xsl:attribute name="column-width">
        <xsl:value-of select="$width"/>
      </xsl:attribute>
      <xsl:attribute name="relwidth">
        <xsl:value-of select="$relative.width"/>
      </xsl:attribute>
      <xsl:attribute name="abswidth">
        <xsl:value-of select="$converted.absolute.width"/>
      </xsl:attribute>
      <xsl:apply-templates mode="dtbl-split-widths"/>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>
<!-- Keep this comment at the end of the file
Local variables:
mode: xml
sgml-indent-step:2
sgml-indent-data:t
End:
-->

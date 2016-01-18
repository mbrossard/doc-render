<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:d="http://docbook.org/ns/docbook"
                xmlns:stbl="http://nwalsh.com/xslt/ext/com.nwalsh.saxon.Table"
                xmlns:xtbl="com.nwalsh.xalan.Table"
                xmlns:ptbl="http://nwalsh.com/xslt/ext/xsltproc/python/Table"
                xmlns:dtbl="http://docbook.sourceforge.net/dtbl"
                exclude-result-prefixes="stbl xtbl ptbl dtbl d"
                version="1.0">

  <xsl:include href="./dumpfragment.xsl"/>
  <xsl:include href="./fo-dtbl.xsl"/>

  <xsl:template match="d:tgroup" name="tgroup">
    <xsl:if test="not(@cols) or @cols = '' or string(number(@cols)) = 'NaN'">
      <xsl:message terminate="yes">
        <xsl:text>Error: CALS tables must specify the number of columns.</xsl:text>
      </xsl:message>
    </xsl:if>

    <xsl:variable name="table.width">
      <xsl:call-template name="table.width"/>
    </xsl:variable>

    <xsl:variable name="colspecs">
      <xsl:choose>
        <xsl:when test="$use.extensions != 0
                        and $tablecolumns.extension != 0">
          <xsl:call-template name="generate.colgroup.raw">
            <xsl:with-param name="cols" select="@cols"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="generate.colgroup">
            <xsl:with-param name="cols" select="@cols"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="prop-columns"
                  select=".//d:colspec[contains(@colwidth, '*')]"/>
    <xsl:if test="count($prop-columns) != 0 or
                  $fop.extensions != 0 or
                  $fop1.extensions != 0 or
                  $passivetex.extensions != 0">
      <xsl:attribute name="table-layout">fixed</xsl:attribute>
    </xsl:if>
    
    <xsl:attribute name="width">
      <xsl:value-of select="$table.width"/>
    </xsl:attribute>
    
    <xsl:choose>
      <xsl:when test="$use.extensions != 0
                      and $tablecolumns.extension != 0">
        <xsl:choose>
          <xsl:when test="function-available('stbl:adjustColumnWidths')">
            <xsl:copy-of select="stbl:adjustColumnWidths($colspecs)"/>
          </xsl:when>
          <xsl:when test="function-available('xtbl:adjustColumnWidths')">
            <xsl:copy-of select="xtbl:adjustColumnWidths($colspecs)"/>
          </xsl:when>
          <xsl:when test="function-available('ptbl:adjustColumnWidths')">
            <xsl:copy-of select="ptbl:adjustColumnWidths($colspecs)"/>
          </xsl:when>
          <xsl:when test="function-available('dtbl:adjustColumnWidths')">
            <xsl:copy-of select="dtbl:adjustColumnWidths($colspecs)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:message terminate="yes">
              <xsl:text>No adjustColumnWidths function available.</xsl:text>
            </xsl:message>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="$colspecs"/>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:apply-templates select="d:thead"/>
    <xsl:apply-templates select="d:tfoot"/>
    <xsl:apply-templates select="d:tbody"/>
  </xsl:template>

</xsl:stylesheet>
<!-- Keep this comment at the end of the file
Local variables:
mode: xml
sgml-indent-step:2
sgml-indent-data:t
End:
-->

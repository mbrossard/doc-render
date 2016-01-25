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

  <xsl:template name="table.cell.properties">
    <xsl:param name="rowsep.inherit" select="1"/>
    <xsl:param name="colsep.inherit" select="1"/>
    <xsl:param name="col" select="1"/>
    <xsl:param name="valign.inherit" select="''"/>
    <xsl:param name="align.inherit" select="''"/>
    <xsl:param name="char.inherit" select="''"/>

    <xsl:variable name="bgcolor.pi">
      <xsl:choose>
        <xsl:when test="ancestor::d:thead and $table.head.bg.color !=''">
          <xsl:value-of select="$table.head.bg.color"/>
        </xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="textcolor.pi">
      <xsl:choose>
        <xsl:when test="ancestor::d:thead and $table.head.text.color !=''">
          <xsl:value-of select="$table.head.text.color"/>
        </xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="ancestor::d:tgroup">
	    <xsl:if test="$bgcolor.pi != ''">
	      <xsl:attribute name="background-color">
	        <xsl:value-of select="$bgcolor.pi"/>
	      </xsl:attribute>
	    </xsl:if>

	    <xsl:if test="$textcolor.pi != ''">
	      <xsl:attribute name="color">
	        <xsl:value-of select="$textcolor.pi"/>
	      </xsl:attribute>
	    </xsl:if>

	    <xsl:if test="$rowsep.inherit &gt; 0">
	      <xsl:call-template name="border">
	        <xsl:with-param name="side" select="'bottom'"/>
	      </xsl:call-template>
	    </xsl:if>

	    <xsl:if test="$colsep.inherit &gt; 0 and 
	                  $col &lt; ancestor::d:tgroup/@cols">
	      <xsl:call-template name="border">
	        <xsl:with-param name="side" select="'right'"/>
	      </xsl:call-template>
	    </xsl:if>
	
	    <xsl:if test="$valign.inherit != ''">
	      <xsl:attribute name="display-align">
	        <xsl:choose>
	          <xsl:when test="$valign.inherit='top'">before</xsl:when>
	          <xsl:when test="$valign.inherit='middle'">center</xsl:when>
	          <xsl:when test="$valign.inherit='bottom'">after</xsl:when>
	          <xsl:otherwise>
		        <xsl:message>
		          <xsl:text>Unexpected valign value: </xsl:text>
		          <xsl:value-of select="$valign.inherit"/>
		          <xsl:text>, center used.</xsl:text>
		        </xsl:message>
		        <xsl:text>center</xsl:text>
	          </xsl:otherwise>
	        </xsl:choose>
	      </xsl:attribute>
	    </xsl:if>
	
	    <xsl:choose>
	      <xsl:when test="$align.inherit = 'char' and $char.inherit != ''">
	        <xsl:attribute name="text-align">
	          <xsl:value-of select="$char.inherit"/>
	        </xsl:attribute>
	      </xsl:when>
	      <xsl:when test="$align.inherit != ''">
	        <xsl:attribute name="text-align">
	          <xsl:value-of select="$align.inherit"/>
	        </xsl:attribute>
	      </xsl:when>
	    </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
	    <!-- HTML table -->
	    <xsl:variable name="border" 
	                  select="(ancestor::d:table |
	                          ancestor::d:informaltable)[last()]/@border"/>
	    <xsl:if test="$border != '' and $border != 0">
	      <xsl:attribute name="border">
	        <xsl:value-of select="$table.cell.border.thickness"/>
	        <xsl:text> </xsl:text>
	        <xsl:value-of select="$table.cell.border.style"/>
	        <xsl:text> </xsl:text>
	        <xsl:value-of select="$table.cell.border.color"/>
	      </xsl:attribute>
	    </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="table.cell.block.properties">

    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 0.9"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="color">
      <xsl:value-of select="$table.cell.text.color"/>
    </xsl:attribute>

    <xsl:if test="ancestor::d:thead">
      <xsl:attribute name="font-weight">bold</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
    </xsl:if>
  </xsl:template>

  <!-- -->

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

  <xsl:template name="table.footnote.block">
    <xsl:if test=".//d:footnote">
      <fo:block keep-with-previous.within-column="always">
	    <xsl:apply-templates select=".//d:footnote" mode="table.footnote.mode"/>
      </fo:block>
    </xsl:if>
    <!-- We add support for caption -->
    <xsl:if test=".//d:caption">
      <fo:block keep-with-previous.within-column="always">
        <xsl:apply-templates select=".//d:caption"/>
      </fo:block>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
<!-- Keep this comment at the end of the file
Local variables:
mode: xml
sgml-indent-step:2
sgml-indent-data:t
End:
-->

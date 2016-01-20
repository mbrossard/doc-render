<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">

  <!-- ***************  Font Families  *********************  -->
  <!-- ***************************************************  -->

  <!-- The body font family is the default font used for text in the
       page body. -->
  <xsl:param name="body.font.family" select="'Verdana,Arial'"/>
  <xsl:param name="body.fontset" select="'Verdana,Arial'"/>

  <xsl:param name="dingbat.font.family" select="'Courier,Arial,Helvetica'"/>
  <xsl:param name="symbol.font.family" select="'Courier,Arial,Helvetica'"/>

  <!-- The default font family for titles. The title font family is
       used for titles (chapter, section, figure, etc.) -->
  <xsl:param name="title.font.family" select="'Arial,Helvetica'"/>
  <xsl:param name="title.fontset" select="'Arial,Helvetica'"/>
  <xsl:param name="monospace.font.family" select="'Courier'"/>
  <xsl:param name="alignment">left</xsl:param>

  <xsl:param name="shade.verbatim">1</xsl:param>
  <xsl:param name="formal.procedures" select="0"/>
  <xsl:param name="bibliography.numbered">1</xsl:param>
  <xsl:param name="glossary.as.blocks">1</xsl:param>
  <xsl:param name="glossterm.width">6cm</xsl:param>

  <xsl:param name="section.autolabel">1</xsl:param>
  <xsl:param name="section.label.includes.component.label">1</xsl:param>
  <xsl:param name="section.autolabel.max.depth">4</xsl:param>

  <xsl:param name="headers.on.blank.pages">1</xsl:param>
  <xsl:param name="footers.on.blank.pages">1</xsl:param>

  <!-- If a graphic or mediaobject includes a reference to a filename
       that does not include an extension, and the format attribute is
       unspecified, the default extension will be used.  -->
  <xsl:param name="graphic.default.extension">png</xsl:param>

  <xsl:param name="insert.xref.page.number" select="1"/>
  <xsl:param name="hyphenate">false</xsl:param>
  <xsl:param name="column.count.index">2</xsl:param>
  <xsl:param name="column.gap.index">12pt</xsl:param>
  <xsl:param name="double.sided">1</xsl:param>

  <!-- Display definition lists without table -->
  <xsl:param name="variablelist.as.blocks" select="1"/>

  <xsl:param name="draft.mode">maybe</xsl:param>
  <xsl:param name="draft.watermark.image"><xsl:value-of select="$resources.path"/>/docbook-xsl/images/draft.png</xsl:param>
  <xsl:param name="callout.graphics.extension">.svg</xsl:param>
  <xsl:param name="callout.graphics.path"><xsl:value-of select="$resources.path"/>/docbook-xsl/images/callouts/</xsl:param>
  <xsl:param name="admon.graphics" select="0"/>
  <!--
  <xsl:param name="admon.graphics.extension">.svg</xsl:param>
  <xsl:param name="admon.graphics.path"><xsl:value-of select="$resources.path"/>/images/admonitions/</xsl:param>
  -->

  <xsl:param name="header.column.widths">6 1 4</xsl:param>
  <xsl:param name="footer.column.widths">5 1 1</xsl:param>

  <!-- Title page and section style -->

  <xsl:attribute-set name="common.title.properties">
    <!-- <xsl:attribute name="color">#00447A</xsl:attribute> -->
    <xsl:attribute name="start-indent">0</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
    <xsl:attribute name="font-size">16pt</xsl:attribute>
    <xsl:attribute name="font-weight">normal</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="common.component.title.properties"
    use-attribute-sets="common.title.properties">
    <xsl:attribute name="font-family">TrebuchetMS</xsl:attribute>
    <xsl:attribute name="font-size">24pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="subtitle.style"
    use-attribute-sets="common.title.properties">
    <xsl:attribute name="color">#F39911</xsl:attribute>
    <xsl:attribute name="line-height">150%</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="book.titlepage.recto.style">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$title.fontset"/>
    </xsl:attribute>  
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
    <xsl:attribute name="font-size">48pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="article.titlepage.recto.style">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$title.fontset"/>
    </xsl:attribute>  
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
    <xsl:attribute name="font-size">48pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="article.titlepage.recto.properties">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$title.fontset"/>
    </xsl:attribute>  
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
  </xsl:attribute-set>

  <xsl:template name="chapter.title">
    <xsl:param name="node" select="."/>
    
    <fo:block padding-bottom="1em">
      <fo:inline font-size="48pt" padding-right="0.5em">
        <xsl:apply-templates select="$node" mode="label.markup"/>
      </fo:inline>
      <fo:inline text-align="start">
        <xsl:apply-templates select="$node" mode="title.markup"/>
      </fo:inline>
    </fo:block>
  </xsl:template>

  <xsl:attribute-set name="section.title.level1.properties"
    use-attribute-sets="common.title.properties">
    <xsl:attribute name="font-size">18pt</xsl:attribute>
    <xsl:attribute name="border-top-style">solid</xsl:attribute>
    <xsl:attribute name="border-top-width">2pt</xsl:attribute>
    <xsl:attribute name="border-top-color">#444444</xsl:attribute>
    <xsl:attribute name="margin-top">1em</xsl:attribute>
    <xsl:attribute name="padding-left">0.2em</xsl:attribute>
    <xsl:attribute name="padding-top">0.3em</xsl:attribute>
    <xsl:attribute name="padding-bottom">0.1em</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level2.properties" use-attribute-sets="common.title.properties">
    <xsl:attribute name="font-size">14pt</xsl:attribute>
    <xsl:attribute name="border-top-style">solid</xsl:attribute>
    <xsl:attribute name="border-top-width">1pt</xsl:attribute>
    <xsl:attribute name="border-top-color">#bbbbbb</xsl:attribute>
    <xsl:attribute name="padding-top">0.3em</xsl:attribute>
    <xsl:attribute name="keep-with-next">always</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level3.properties" use-attribute-sets="common.title.properties">
    <xsl:attribute name="font-size">12pt</xsl:attribute>
    <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
    <xsl:attribute name="border-bottom-width">0.5pt</xsl:attribute>
    <xsl:attribute name="border-bottom-color">#eeeeee</xsl:attribute>
    <xsl:attribute name="keep-with-next">always</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level4.properties" use-attribute-sets="common.title.properties">
    <xsl:attribute name="font-size">10pt</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="keep-with-next">always</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level5.properties" use-attribute-sets="common.title.properties">
    <xsl:attribute name="font-size">10pt</xsl:attribute>
    <xsl:attribute name="keep-with-next">always</xsl:attribute>    
  </xsl:attribute-set>

  <xsl:attribute-set name="index.div.title.properties"
    use-attribute-sets="common.title.properties">
    <xsl:attribute name="font-size">16pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="bibliodiv.title.properties"
    use-attribute-sets="common.title.properties">
    <xsl:attribute name="padding-left">0.2em</xsl:attribute>
    <xsl:attribute name="padding-top">0.2em</xsl:attribute>
    <xsl:attribute name="padding-bottom">0.1em</xsl:attribute>
    <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
    <xsl:attribute name="border-bottom-width">1pt</xsl:attribute>
    <xsl:attribute name="border-bottom-color">#eeeeee</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="address.properties" use-attribute-sets="verbatim.properties">
    <xsl:attribute name="white-space-collapse">true</xsl:attribute>
    <xsl:attribute name="white-space-treatment">ignore-if-surrounding-linefeed</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="glossterm.list.properties">
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="glossterm.block.properties">
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
  </xsl:attribute-set>

  <xsl:param name="orderedlist.label.width">1.7em</xsl:param>

  <xsl:attribute-set name="orderedlist.label.properties">
    <xsl:attribute name="text-align">end</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="procedure.step.label.properties">
    <xsl:attribute name="text-align">end</xsl:attribute>
    <xsl:attribute name="margin-left">0cm</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="verso.style">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$title.fontset"/>
    </xsl:attribute>  
  </xsl:attribute-set>

  <!-- Between recto and verso titlepage we add a page break :) -->
  <xsl:template name="book.titlepage.separator">
    <!-- <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" break-after="page"/> -->
  </xsl:template>

  <!-- Between recto and verso titlepage we add a page break :) -->
  <xsl:template name="article.titlepage.separator">
    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" break-after="page"/>
  </xsl:template>

  <xsl:template name="article.titlepage.before.verso">
    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" break-after="page"/>
  </xsl:template>

  <!-- Break page before index -->
  <xsl:attribute-set name="index.titlepage.recto.style">
    <xsl:attribute name="break-before">page</xsl:attribute>
  </xsl:attribute-set>

  <!-- Bullet points hierarchy -->
  <xsl:template name="next.itemsymbol">
    <xsl:param name="itemsymbol" select="'default'"/>
    <xsl:choose>
      <!-- Change this list if you want to change the order of symbols -->
      <xsl:when test="$itemsymbol = 'disc'">circle</xsl:when>
      <xsl:when test="$itemsymbol = 'circle'">square</xsl:when>
      <xsl:otherwise>disc</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Bullet points characters -->
  <xsl:template name="itemizedlist.label.markup">
    <xsl:param name="itemsymbol" select="'disc'"/>

    <xsl:choose>
      <xsl:when test="$itemsymbol='none'"></xsl:when>
      <xsl:when test="$itemsymbol='disc'">&#x2022;</xsl:when>
      <xsl:when test="$itemsymbol='bullet'">&#x2022;</xsl:when>
      <xsl:when test="$itemsymbol='circle'">&#x25E6;</xsl:when>
      <xsl:when test="$itemsymbol='square'">&#x25AB;</xsl:when>
      <xsl:when test="$itemsymbol='box'">&#x25AA;</xsl:when>
      <xsl:otherwise>&#x2022;</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:attribute-set name="monospace.verbatim.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 0.75"/>
      <xsl:text>pt</xsl:text>
     </xsl:attribute>
    <xsl:attribute name="margin-left">1em</xsl:attribute>
    <xsl:attribute name="margin-right">1em</xsl:attribute>
  </xsl:attribute-set>

  <xsl:template name="inline.reditalicseq">
    <xsl:param name="content">
      <xsl:call-template name="simple.xlink">
        <xsl:with-param name="content">
          <xsl:apply-templates/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:param>

    <fo:inline font-style="italic" color="#FF0000">
      <xsl:call-template name="anchor"/>
      <xsl:if test="@dir">
        <xsl:attribute name="direction">
          <xsl:choose>
            <xsl:when test="@dir = 'ltr' or @dir = 'lro'">ltr</xsl:when>
            <xsl:otherwise>rtl</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
      </xsl:if>
      <xsl:copy-of select="$content"/>
    </fo:inline>
  </xsl:template>

  <!-- Table of content -->

  <xsl:attribute-set name="toc.line.properties">
    <xsl:attribute name="text-align-last">justify</xsl:attribute>
    <xsl:attribute name="text-align">start</xsl:attribute>
  </xsl:attribute-set>

  <xsl:template name="table.of.contents.titlepage.recto">
    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"
      xsl:use-attribute-sets="common.component.title.properties">
      <xsl:call-template name="gentext">
        <xsl:with-param name="key" select="'TableofContents'"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>

  <xsl:template name="toc.line">
    <xsl:param name="toc-context" select="NOTANODE"/>

    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>

    <xsl:variable name="label">
      <xsl:apply-templates select="." mode="label.markup"/>
    </xsl:variable>

    <xsl:variable name="depth.from.context" select="count(ancestor::*)-count($toc-context/ancestor::*)"/>

    <xsl:variable name="toc.font.size">
      <xsl:choose>
        <xsl:when test="$depth.from.context='1'">
          <xsl:value-of select="$body.font.master * 1.1"/>
        </xsl:when>
        <xsl:when test="$depth.from.context='2'">
          <xsl:value-of select="$body.font.master * 0.9"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$body.font.master * 0.7"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="leader.pattern.width">
      <xsl:choose>
        <xsl:when test="$depth.from.context='1'">
          <xsl:text>3</xsl:text>
        </xsl:when>
        <xsl:when test="$depth.from.context='2'">
          <xsl:text>2</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>1</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="line.height">
      <xsl:choose>
        <xsl:when test="$depth.from.context='1'">
          <xsl:text>175%</xsl:text>
        </xsl:when>
        <xsl:when test="$depth.from.context='2'">
          <xsl:text>150%</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>125%</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <fo:block xsl:use-attribute-sets="toc.line.properties"
      end-indent="{$toc.indent.width}pt"
      last-line-end-indent="-{$toc.indent.width}pt"
      font-size="{$toc.font.size}pt" line-height="{$line.height}">
      <fo:wrapper>
        <fo:inline keep-with-next.within-line="always">
          <fo:basic-link internal-destination="{$id}">
            
            <xsl:apply-templates select="." mode="object.title.markup"/>
          </fo:basic-link>
        </fo:inline>
      </fo:wrapper>
      <fo:inline keep-together.within-line="always">
        <xsl:text> </xsl:text>
        <!-- <xsl:value-of select="$depth.from.context"/> -->
        
        <fo:leader leader-pattern="dots"
          leader-pattern-width="{$leader.pattern.width}pt"
          leader-alignment="reference-area"
          keep-with-next.within-line="always"/>
        <xsl:text> </xsl:text>
        <fo:wrapper>
          <fo:basic-link internal-destination="{$id}">
            <fo:page-number-citation ref-id="{$id}"/>
          </fo:basic-link>
        </fo:wrapper>
      </fo:inline>
    </fo:block>
  </xsl:template>

  <!-- Tables -->
  
  <xsl:param name="table.frame.border.thickness">0.5pt</xsl:param>
  <xsl:param name="table.cell.border.thickness">0.5pt</xsl:param>
  <xsl:param name="table.frame.border.color">#1b325e</xsl:param>
  <xsl:param name="table.cell.border.color">#1b325e</xsl:param>
  <xsl:param name="table.footnote.number.format" select="1"></xsl:param>
  <xsl:param name="table.frame.border.style">solid</xsl:param>
  <xsl:param name="table.cell.border.style">solid</xsl:param>

  <xsl:attribute-set name="table.table.properties">
    <xsl:attribute name="border-before-width.conditionality">retain</xsl:attribute>
    <xsl:attribute name="border-collapse">collapse</xsl:attribute>
    <xsl:attribute name="text-align">center</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="table.properties">
    <xsl:attribute name="space-before.minimum">2em</xsl:attribute>
    <xsl:attribute name="space-before.optimum">2em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">4em</xsl:attribute>
    <xsl:attribute name="space-after.minimum">2em</xsl:attribute>
    <xsl:attribute name="space-after.optimum">2em</xsl:attribute>
    <xsl:attribute name="space-after.maximum">4em</xsl:attribute>
    <xsl:attribute name="border-before-width.conditionality">retain</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="informaltable.properties" 
    xsl:use-attribute-sets="table.properties"/>

  <!-- Not really a table -->
  <xsl:attribute-set name="figure.properties">
    <xsl:attribute name="space-before.minimum">0.5em</xsl:attribute>
    <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">2em</xsl:attribute>
    <xsl:attribute name="space-after.minimum">0.5em</xsl:attribute>
    <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
    <xsl:attribute name="space-after.maximum">2em</xsl:attribute>
    <xsl:attribute name="keep-together.within-column">always</xsl:attribute>
    <xsl:attribute name="text-align">center</xsl:attribute>
  </xsl:attribute-set>

  <xsl:template name="table.layout">
    <xsl:param name="table.content"/>
    <xsl:choose>
      <xsl:when test="@align='center'">
        <fo:table width="100%" table-layout="fixed">
          <fo:table-column column-width="proportional-column-width(1)"/> 
          <fo:table-column column-width="3in"/>
          <fo:table-column column-width="proportional-column-width(1)"/>
          <fo:table-body start-indent="0pt">
            <fo:table-row>
              <fo:table-cell>
                <fo:block>&#xFEFF;</fo:block>
              </fo:table-cell>
              <fo:table-cell>
                <fo:table>
                  <fo:table-body start-indent="0pt">
                    <fo:table-row>
                      <fo:table-cell>
                        <fo:block>
                          <xsl:copy-of select="$table.content"/>
                        </fo:block>
                      </fo:table-cell>
                    </fo:table-row>
                  </fo:table-body>
                </fo:table>
              </fo:table-cell>
              <fo:table-cell>
                <fo:block>&#xFEFF;</fo:block>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="$table.content"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Headers & footers -->

  <!-- Managing header style -->
  <xsl:attribute-set name="header.content.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 0.7"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="font-family">
      <xsl:value-of select="$body.fontset"/>
    </xsl:attribute>
  </xsl:attribute-set>  

  <!-- Managing footer style -->
  <xsl:attribute-set name="footer.content.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 0.7"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="font-family">
      <xsl:value-of select="$body.fontset"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:template name="head.sep.rule">
    <xsl:param name="pageclass" select="''"/>
    <xsl:param name="sequence" select="''"/>
    <xsl:param name="gentext-key" select="''"/>

    <xsl:variable name="display">
      <xsl:call-template name="display.headers.footers">
	<xsl:with-param name="pageclass" select="$pageclass"/>
	<xsl:with-param name="sequence" select="$sequence"/>
	<xsl:with-param name="gentext-key" select="$gentext-key"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$header.rule = 0"><!-- no output --></xsl:when>
      <xsl:when test="$display = 0"><!-- no output --></xsl:when>
      <xsl:otherwise>
	<xsl:attribute name="border-bottom-width">0.5pt</xsl:attribute>
	<xsl:attribute name="border-bottom-style">solid</xsl:attribute>
	<xsl:attribute name="border-bottom-color">#444444</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="foot.sep.rule">
    <xsl:param name="pageclass" select="''"/>
    <xsl:param name="sequence" select="''"/>
    <xsl:param name="gentext-key" select="''"/>

    <xsl:variable name="display">
      <xsl:call-template name="display.headers.footers">
	<xsl:with-param name="pageclass" select="$pageclass"/>
	<xsl:with-param name="sequence" select="$sequence"/>
	<xsl:with-param name="gentext-key" select="$gentext-key"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$footer.rule = 0"><!-- no output --></xsl:when>
      <xsl:when test="$display = 0"><!-- no output --></xsl:when>
      <xsl:otherwise>
	<xsl:attribute name="border-top-width">0.5pt</xsl:attribute>
	<xsl:attribute name="border-top-style">solid</xsl:attribute>
	<xsl:attribute name="border-top-color">#444444</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Admonitions -->

  <xsl:attribute-set name="admonition.title.properties">
    <xsl:attribute name="font-size"><xsl:value-of select="$body.font.master"/>pt</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="hyphenate">false</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="nongraphical.admonition.properties">
    <xsl:attribute name="border-top">0.5pt solid black</xsl:attribute>
    <xsl:attribute name="border-bottom">0.5pt solid black</xsl:attribute>
    <xsl:attribute name="padding-top">4pt</xsl:attribute>
    <xsl:attribute name="padding-bottom">4pt</xsl:attribute>
    <xsl:attribute name="keep-together">1</xsl:attribute>
  </xsl:attribute-set>

  <!-- Formal titles -->

  <xsl:attribute-set name="formal.title.properties" use-attribute-sets="normal.para.spacing">
    <xsl:attribute name="text-align">center</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 0.8"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="hyphenate">false</xsl:attribute>
    <xsl:attribute name="space-after.minimum">0.4em</xsl:attribute>
    <xsl:attribute name="space-after.optimum">0.6em</xsl:attribute>
    <xsl:attribute name="space-after.maximum">0.8em</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="formal.tablefigure.properties"
    use-attribute-sets="formal.title.properties">
    <xsl:attribute name="text-align">center</xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 0.8"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="list.block.spacing.alt">
    <xsl:attribute name="space-before.optimum">12pt</xsl:attribute>
    <xsl:attribute name="space-before.minimum">8pt</xsl:attribute>
    <xsl:attribute name="space-before.maximum">14pt</xsl:attribute>
    <xsl:attribute name="space-after.optimum">0pt</xsl:attribute>
    <xsl:attribute name="space-after.minimum">0pt</xsl:attribute>
    <xsl:attribute name="space-after.maximum">0pt</xsl:attribute>
  </xsl:attribute-set>

</xsl:stylesheet>
<!-- Keep this comment at the end of the file
Local variables:
mode: xml
sgml-indent-step:2
sgml-indent-data:t
End:
-->

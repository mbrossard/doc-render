<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:exsl="http://exslt.org/common"
  exclude-result-prefixes="exsl d"
  version="1.0">

  <!-- ***************  Book  *********************  -->

  <xsl:template name="book.titlepage">
    <xsl:call-template name="book.titlepage.before.recto"/>
    <xsl:call-template name="book.titlepage.recto"/>
    <xsl:call-template name="book.titlepage.before.verso"/>
    <xsl:call-template name="book.titlepage.verso"/>
    <xsl:call-template name="book.titlepage.separator"/>
  </xsl:template>

  <!-- * Recto *  -->

  <!-- Title -->
  <xsl:template match="d:title" mode="book.titlepage.recto.auto.mode">
    <fo:block xsl:use-attribute-sets="book.titlepage.recto.style">
      <xsl:call-template name="component.title">
        <xsl:with-param name="node" select="ancestor-or-self::d:book[1]"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>

  <!-- Subtitle -->
  <xsl:template match="d:subtitle" mode="book.titlepage.recto.auto.mode">
    <fo:block xsl:use-attribute-sets="subtitle.style">
      <xsl:apply-templates select="." mode="book.titlepage.recto.mode"/>
    </fo:block>
  </xsl:template>

  <xsl:template name="book.titlepage.recto">
    <fo:block-container xsl:use-attribute-sets="book.titlepage.recto.properties">
      <xsl:choose>
        <xsl:when test="d:bookinfo/d:title">
          <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="d:bookinfo/d:title"/>
        </xsl:when>
        <xsl:when test="d:info/d:title">
          <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="d:info/d:title"/>
        </xsl:when>
        <xsl:when test="d:title">
          <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="d:title"/>
        </xsl:when>
      </xsl:choose>

      <xsl:choose>
        <xsl:when test="d:bookinfo/d:subtitle">
          <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="d:bookinfo/d:subtitle"/>
        </xsl:when>
        <xsl:when test="d:info/d:subtitle">
          <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="d:info/d:subtitle"/>
        </xsl:when>
        <xsl:when test="d:subtitle">
          <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="d:subtitle"/>
        </xsl:when>
      </xsl:choose>
    </fo:block-container>
  </xsl:template>

  <!-- * Verso *  -->

  <xsl:template name="book.titlepage.verso">
    <xsl:choose>
      <xsl:when test="d:bookinfo/d:title">
        <xsl:apply-templates mode="common.titlepage.verso.auto.mode" select="d:bookinfo/d:title"/>
      </xsl:when>
      <xsl:when test="d:info/d:title">
        <xsl:apply-templates mode="common.titlepage.verso.auto.mode" select="d:info/d:title"/>
      </xsl:when>
      <xsl:when test="d:title">
        <xsl:apply-templates mode="common.titlepage.verso.auto.mode" select="d:title"/>
      </xsl:when>
    </xsl:choose>

    <xsl:apply-templates mode="common.titlepage.verso.auto.mode" select="d:bookinfo/d:pubdate"/>
    <xsl:apply-templates mode="common.titlepage.verso.auto.mode" select="d:info/d:pubdate"/>
    <xsl:apply-templates mode="common.titlepage.verso.auto.mode" select="d:bookinfo/d:edition"/>
    <xsl:apply-templates mode="common.titlepage.verso.auto.mode" select="d:info/d:edition"/>
    <xsl:apply-templates mode="common.titlepage.verso.auto.mode" select="d:bookinfo/d:legalnotice"/>
    <xsl:apply-templates mode="common.titlepage.verso.auto.mode" select="d:info/d:legalnotice"/>
    <xsl:apply-templates mode="common.titlepage.verso.auto.mode" select="d:bookinfo/d:abstract"/>
    <xsl:apply-templates mode="common.titlepage.verso.auto.mode" select="d:info/d:abstract"/>

    <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:bookinfo/d:corpauthor"/>
    <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:info/d:corpauthor"/>
    <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:bookinfo/d:authorgroup"/>
    <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:info/d:authorgroup"/>
    <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:bookinfo/d:author"/>
    <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:info/d:author"/>
    <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:bookinfo/d:othercredit"/>
    <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:info/d:othercredit"/>
    <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:bookinfo/d:releaseinfo"/>
    <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:info/d:releaseinfo"/>
    <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:bookinfo/d:copyright"/>
    <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:info/d:copyright"/>
    <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:bookinfo/d:revision"/>
    <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:info/d:revision"/>
    <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:bookinfo/d:revhistory"/>
    <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:info/d:revhistory"/>
  </xsl:template>

  <!-- ***************  Article  *********************  -->

  <xsl:template name="article.titlepage">
    <xsl:call-template name="article.titlepage.before.recto"/>
    <xsl:call-template name="article.titlepage.recto"/>
    <xsl:call-template name="article.titlepage.before.verso"/>
    <xsl:call-template name="article.titlepage.verso"/>
    <!-- <xsl:call-template name="article.titlepage.separator"/> -->
  </xsl:template>

  <!-- * Recto *  -->

  <!-- Title -->
  <xsl:template match="d:title" mode="article.titlepage.recto.auto.mode">
    <fo:block xsl:use-attribute-sets="article.titlepage.recto.style">
      <xsl:call-template name="component.title">
        <xsl:with-param name="node" select="ancestor-or-self::d:article[1]"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>

  <!-- Subtitle -->
  <xsl:template match="d:subtitle" mode="article.titlepage.recto.auto.mode">
    <fo:block xsl:use-attribute-sets="subtitle.style">
      <xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
    </fo:block>
  </xsl:template>

  <xsl:template name="article.titlepage.recto">
    <fo:block-container xsl:use-attribute-sets="article.titlepage.recto.properties">
      <xsl:choose>
        <xsl:when test="d:articleinfo/d:title">
          <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="d:articleinfo/d:title"/>
        </xsl:when>
        <xsl:when test="d:info/d:title">
          <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="d:info/d:title"/>
        </xsl:when>
        <xsl:when test="d:title">
          <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="d:title"/>
        </xsl:when>
      </xsl:choose>

      <xsl:choose>
        <xsl:when test="d:articleinfo/d:subtitle">
          <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="d:articleinfo/d:subtitle"/>
        </xsl:when>
        <xsl:when test="d:info/d:subtitle">
          <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="d:info/d:subtitle"/>
        </xsl:when>
        <xsl:when test="d:subtitle">
          <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="d:subtitle"/>
        </xsl:when>
      </xsl:choose>
    </fo:block-container>
  </xsl:template>

  <!-- * Verso *  -->

  <xsl:template name="article.titlepage.verso">
    <xsl:choose>
      <xsl:when test="d:articleinfo/d:title">
        <xsl:apply-templates mode="common.titlepage.verso.auto.mode" select="d:articleinfo/d:title"/>
      </xsl:when>
      <xsl:when test="d:info/d:title">
        <xsl:apply-templates mode="common.titlepage.verso.auto.mode" select="d:info/d:title"/>
      </xsl:when>
      <xsl:when test="d:title">
        <xsl:apply-templates mode="common.titlepage.verso.auto.mode" select="d:title"/>
      </xsl:when>
    </xsl:choose>

    <xsl:apply-templates mode="common.titlepage.verso.auto.mode" select="d:articleinfo/d:pubdate"/>
    <xsl:apply-templates mode="common.titlepage.verso.auto.mode" select="d:info/d:pubdate"/>
    <xsl:apply-templates mode="common.titlepage.verso.auto.mode" select="d:articleinfo/d:edition"/>
    <xsl:apply-templates mode="common.titlepage.verso.auto.mode" select="d:info/d:edition"/>
    <xsl:apply-templates mode="common.titlepage.verso.auto.mode" select="d:articleinfo/d:abstract"/>
    <xsl:apply-templates mode="common.titlepage.verso.auto.mode" select="d:info/d:abstract"/>
    <xsl:apply-templates mode="common.titlepage.verso.auto.mode" select="d:articleinfo/d:legalnotice"/>
    <xsl:apply-templates mode="common.titlepage.verso.auto.mode" select="d:info/d:legalnotice"/>

    <xsl:apply-templates mode="article.titlepage.verso.auto.mode" select="d:articleinfo/d:corpauthor"/>
    <xsl:apply-templates mode="article.titlepage.verso.auto.mode" select="d:info/d:corpauthor"/>
    <xsl:apply-templates mode="article.titlepage.verso.auto.mode" select="d:articleinfo/d:authorgroup"/>
    <xsl:apply-templates mode="article.titlepage.verso.auto.mode" select="d:info/d:authorgroup"/>
    <xsl:apply-templates mode="article.titlepage.verso.auto.mode" select="d:articleinfo/d:author"/>
    <xsl:apply-templates mode="article.titlepage.verso.auto.mode" select="d:info/d:author"/>
    <xsl:apply-templates mode="article.titlepage.verso.auto.mode" select="d:articleinfo/d:othercredit"/>
    <xsl:apply-templates mode="article.titlepage.verso.auto.mode" select="d:info/d:othercredit"/>
    <xsl:apply-templates mode="article.titlepage.verso.auto.mode" select="d:articleinfo/d:releaseinfo"/>
    <xsl:apply-templates mode="article.titlepage.verso.auto.mode" select="d:info/d:releaseinfo"/>
    <xsl:apply-templates mode="article.titlepage.verso.auto.mode" select="d:articleinfo/d:copyright"/>
    <xsl:apply-templates mode="article.titlepage.verso.auto.mode" select="d:info/d:copyright"/>
    <xsl:apply-templates mode="article.titlepage.verso.auto.mode" select="d:articleinfo/d:revision"/>
    <xsl:apply-templates mode="article.titlepage.verso.auto.mode" select="d:info/d:revision"/>
    <xsl:apply-templates mode="article.titlepage.verso.auto.mode" select="d:articleinfo/d:revhistory"/>
    <xsl:apply-templates mode="article.titlepage.verso.auto.mode" select="d:info/d:revhistory"/>
  </xsl:template>

  <!-- ***************  Common  *********************  -->

  <xsl:template name="common.verso.title">
    <fo:block>
      <xsl:apply-templates mode="titlepage.mode"/>

      <xsl:if test="following-sibling::d:subtitle
	|following-sibling::d:info/d:subtitle
	|following-sibling::d:bookinfo/d:subtitle
	|following-sibling::d:articleinfo/d:subtitle">
	<xsl:text>: </xsl:text>

	<xsl:apply-templates select="(following-sibling::d:subtitle
	  |following-sibling::d:info/d:subtitle
	  |following-sibling::d:bookinfo/d:subtitle
	  |following-sibling::d:articleinfo/d:subtitle)[1]"
	  mode="verso.subtitle.mode"/>
      </xsl:if>
    </fo:block>
  </xsl:template>

  <xsl:template match="d:subtitle" mode="verso.subtitle.mode">
    <xsl:apply-templates mode="titlepage.mode"/>
    <xsl:if test="following-sibling::d:subtitle">
      <xsl:text>: </xsl:text>
      <xsl:apply-templates select="following-sibling::d:subtitle[1]"
	mode="verso.subtitle.mode"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="d:title" mode="common.titlepage.verso.auto.mode">
    <fo:block xsl:use-attribute-sets="verso.style"
      font-size="12pt" font-weight="bold" font-family="{$title.fontset}">
      <xsl:call-template name="common.verso.title"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="d:legalnotice|d:abstract" mode="common.titlepage.verso.auto.mode">
    <fo:block xsl:use-attribute-sets="article.titlepage.verso.style">
      <xsl:apply-templates select="." mode="article.titlepage.verso.mode"/>
    </fo:block>
  </xsl:template>

  <!-- Publishing Date -->
  <xsl:template match="d:pubdate" mode="common.titlepage.verso.auto.mode">
    <fo:block xsl:use-attribute-sets="verso.style">
      <!--
          <xsl:text>Release Date: </xsl:text>
          <xsl:call-template name="svn.escape">
	      <xsl:with-param name="node">
      -->
	  <xsl:apply-templates/>
      <!--
	      </xsl:with-param>
          </xsl:call-template>
      -->
    </fo:block>
  </xsl:template>

  <!-- Edition -->
  <xsl:template match="d:edition" mode="common.titlepage.verso.auto.mode">
    <fo:block xsl:use-attribute-sets="verso.style">
      <!--
          <xsl:text>Revision: </xsl:text>
          <xsl:call-template name="svn.escape">
	      <xsl:with-param name="node">
      -->
	  <xsl:apply-templates/>
      <!--
	      </xsl:with-param>
          </xsl:call-template>
      -->
    </fo:block>
  </xsl:template>

</xsl:stylesheet>
<!-- Keep this comment at the end of the file
Local variables:
mode: xml
sgml-indent-step:2
sgml-indent-data:t
End:
-->

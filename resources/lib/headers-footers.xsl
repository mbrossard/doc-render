<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:d="http://docbook.org/ns/docbook"
  exclude-result-prefixes="d"
  version="1.0">

  <xsl:template name="footer.title.content">
    <xsl:text></xsl:text>
    <xsl:choose>
      <xsl:when test="//d:book/d:bookinfo/d:title">
	<xsl:apply-templates mode="book.verso.title" select="//d:book/d:bookinfo/d:title"/>
      </xsl:when>
      <xsl:when test="//d:book/d:info/d:title">
	<xsl:apply-templates mode="book.verso.title" select="//d:book/d:info/d:title"/>
      </xsl:when>
      <xsl:when test="//d:book/d:title">
	<xsl:apply-templates mode="book.verso.title" select="//d:book/d:title"/>
      </xsl:when>
      <xsl:when test="//d:article/d:articleinfo/d:title">
	<xsl:apply-templates mode="article.verso.title" select="//d:article/d:articleinfo/d:title"/>
      </xsl:when>
      <xsl:when test="//d:article/d:info/d:title">
	<xsl:apply-templates mode="article.verso.title" select="//d:article/d:info/d:title"/>
      </xsl:when>
      <xsl:when test="//d:article/d:title">
	<xsl:apply-templates mode="article.verso.title" select="//d:article/d:title"/>
      </xsl:when>
    </xsl:choose>
    
    <xsl:choose>
      <xsl:when test="//d:book/d:bookinfo/d:subtitle">
	<xsl:text>: </xsl:text>
	<xsl:apply-templates mode="book.verso.subtitle" select="//d:book/d:bookinfo/d:subtitle"/>
      </xsl:when>
      <xsl:when test="//d:book/d:info/d:subtitle">
	<xsl:text>: </xsl:text>
	<xsl:apply-templates mode="book.verso.subtitle" select="//d:book/d:info/d:subtitle"/>
      </xsl:when>
      <xsl:when test="//d:book/d:subtitle">
	<xsl:text>: </xsl:text>
	<xsl:apply-templates mode="book.verso.subtitle" select="//d:book/d:subtitle"/>
      </xsl:when>
      <xsl:when test="//d:article/d:articleinfo/d:subtitle">
	<xsl:text>: </xsl:text>
	<xsl:apply-templates mode="article.verso.subtitle" select="//d:article/d:articleinfo/d:subtitle"/>
      </xsl:when>
      <xsl:when test="//d:article/d:info/d:subtitle">
	<xsl:text>: </xsl:text>
	<xsl:apply-templates mode="article.verso.subtitle" select="//d:article/d:info/d:subtitle"/>
      </xsl:when>
      <xsl:when test="//d:article/d:subtitle">
	<xsl:text>: </xsl:text>
	<xsl:apply-templates mode="article.verso.subtitle" select="//d:article/d:subtitle"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="display.headers.footers">
    <xsl:param name="pageclass" select="''"/>
    <xsl:param name="sequence" select="''"/>
    <xsl:param name="gentext-key" select="''"/>
     <xsl:choose>
      <xsl:when test="$sequence = 'first' and $gentext-key = 'article'">0</xsl:when>
      <xsl:when test="$pageclass = 'titlepage' and $gentext-key = 'book'">0</xsl:when>
      <xsl:otherwise>1</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="header.content">  
    <xsl:param name="pageclass" select="''"/>
    <xsl:param name="sequence" select="''"/>
    <xsl:param name="position" select="''"/>
    <xsl:param name="gentext-key" select="''"/>

    <xsl:variable name="display">
      <xsl:call-template name="display.headers.footers">
	<xsl:with-param name="pageclass" select="$pageclass"/>
	<xsl:with-param name="sequence" select="$sequence"/>
	<xsl:with-param name="gentext-key" select="$gentext-key"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:if test="$debug != 0">
      <fo:block>
	<xsl:text>'</xsl:text>
	<xsl:value-of select="$pageclass"/>
	<xsl:text>', '</xsl:text>
	<xsl:value-of select="$sequence"/>
	<xsl:text>', '</xsl:text>
	<xsl:value-of select="$position"/>
	<xsl:text>', '</xsl:text>
	<xsl:value-of select="$gentext-key"/>
	<xsl:text>', </xsl:text>
	<xsl:value-of select="$display"/>
      </fo:block>
    </xsl:if>

    <!-- Does runtime parameter turn off blank page headers? -->
    <xsl:choose>
      <xsl:when test="$sequence='blank' and $headers.on.blank.pages=0"><!-- no output --></xsl:when>
      <xsl:when test="$display = 0"><!-- no output --></xsl:when>
      <xsl:when test="$pageclass = 'lot' and $gentext-key = 'TableofContents' and $sequence != 'blank'"><!-- no output --></xsl:when>
      <xsl:otherwise>
	<!-- sequence can be odd, even, first, blank -->
	<!-- position can be left, center, right -->
	<xsl:choose>
	  <!-- Odd sequence -->
	  <xsl:when test="$position = 'left' and ($sequence = 'odd' or ($sequence = 'even' and $double.sided = 0))">
	    <fo:block>
	      <xsl:choose> 
		<xsl:when test="$gentext-key = 'article'">
		</xsl:when>
		<xsl:otherwise>
		  <fo:retrieve-marker retrieve-class-name="section.head.marker"  
		    retrieve-position="first-including-carryover"
		    retrieve-boundary="page-sequence"/>
		</xsl:otherwise>
	      </xsl:choose>
	    </fo:block>
	  </xsl:when>
	  <xsl:when test="$position = 'right' and ($sequence = 'odd' or ($sequence = 'even' and $double.sided = 0))">
	    <fo:block>
	      <xsl:choose> 
		<xsl:when test="$gentext-key = 'article'">
		</xsl:when>
		<xsl:otherwise>
		  <xsl:apply-templates select="." mode="object.title.markup"/>
		</xsl:otherwise>
	      </xsl:choose>
	    </fo:block>
	  </xsl:when>

	  <!-- Even sequence -->
	  <xsl:when test="$position = 'left' and $sequence = 'even' and $double.sided != 0">
	    <fo:block>
	      <xsl:choose> 
		<xsl:when test="$gentext-key = 'article'">
		</xsl:when>
		<xsl:otherwise>
		  <xsl:apply-templates select="." mode="object.title.markup"/>
		</xsl:otherwise>
	      </xsl:choose>
	    </fo:block>
	  </xsl:when>
	  <xsl:when test="$position = 'right' and $sequence = 'even' and $double.sided != 0">
	    <fo:block>
	      <xsl:choose> 
		<xsl:when test="$gentext-key = 'article'">
		</xsl:when>
		<xsl:otherwise>
		  <fo:retrieve-marker retrieve-class-name="section.head.marker"  
		    retrieve-position="first-including-carryover"
		    retrieve-boundary="page-sequence"/>
		</xsl:otherwise>
	      </xsl:choose>
	    </fo:block>
	  </xsl:when>

	  <!-- First sequence -->
	  <xsl:when test="$sequence = 'first' and $position = 'left'">
	  </xsl:when>
	  <xsl:when test="$sequence = 'first' and $position = 'right'">  
	  </xsl:when>
	  <xsl:when test="$sequence = 'first' and $position = 'center'"> 
	  </xsl:when>
	  
	  <!-- Blank sequence -->
	  <xsl:when test="$sequence = 'blank' and $position = 'left'">
	    <xsl:text>This page intentionally left blank.</xsl:text>
	  </xsl:when>
	</xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="footer.content">
    <xsl:param name="pageclass" select="''"/>
    <xsl:param name="sequence" select="''"/>
    <xsl:param name="position" select="''"/>
    <xsl:param name="gentext-key" select="''"/>

    <xsl:variable name="display">
      <xsl:call-template name="display.headers.footers">
	<xsl:with-param name="pageclass" select="$pageclass"/>
	<xsl:with-param name="sequence" select="$sequence"/>
	<xsl:with-param name="gentext-key" select="$gentext-key"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:if test="$debug != 0">
      <fo:block>
	<xsl:text>'</xsl:text>
	<xsl:value-of select="$pageclass"/>
	<xsl:text>', '</xsl:text>
	<xsl:value-of select="$sequence"/>
	<xsl:text>', '</xsl:text>
	<xsl:value-of select="$position"/>
	<xsl:text>', '</xsl:text>
	<xsl:value-of select="$gentext-key"/>
	<xsl:text>', </xsl:text>
	<xsl:value-of select="$display"/>
      </fo:block>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="$sequence='blank' and $headers.on.blank.pages=0"><!-- no output --></xsl:when>
      <xsl:when test="$display = 0"><!-- no output --></xsl:when>
       <xsl:otherwise>
	<fo:block>
	  <xsl:choose>
	    <xsl:when test="$position = 'left'">
	      <xsl:choose>
		<xsl:when test="$sequence = 'even' or $sequence = 'blank'">
		  <fo:page-number/>
		</xsl:when>
		<xsl:otherwise> <!-- left/odd -->
		  <xsl:call-template name="footer.title.content"/>
		</xsl:otherwise>
	      </xsl:choose>
	    </xsl:when>
			
	    <xsl:when test="$position = 'right'">
	      <xsl:choose>
		<xsl:when test="$sequence = 'even' or $sequence = 'blank'">
		  <xsl:call-template name="footer.title.content"/>
		</xsl:when>
		<xsl:otherwise> <!-- left/odd -->
		  <fo:page-number/>
		</xsl:otherwise>
	      </xsl:choose>
	    </xsl:when>
	  </xsl:choose>
	</fo:block>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
<!-- Keep this comment at the end of the file
Local variables:
mode: xml
sgml-indent-step:2
sgml-indent-data:t
End:
-->

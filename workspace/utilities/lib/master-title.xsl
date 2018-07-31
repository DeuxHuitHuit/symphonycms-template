<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exslt="http://exslt.org/common"
	exclude-result-prefixes="exslt">

<!-- Template to override for custom master title algo -->
	<xsl:template name="master-title">
		<xsl:param name="lg" select="$url-language" />

		<xsl:call-template name="default-master-title" >
			<xsl:with-param name="lg" select="$lg" />
		</xsl:call-template>
	</xsl:template>

<!-- Override in the page to stop appending site name to the page-title -->
	<xsl:variable name="master-title-append-site-name" select="string-length($page-metas/titre) = 0" />

<!-- Default master title template with default algo for page title and site name -->
	<xsl:template name="default-master-title">
		<xsl:param name="lg" select="$url-language" />

		<xsl:if test="count(/data/params/page-types/item[@handle = 'index']) = 0">
			<xsl:call-template name="page-title">
				<xsl:with-param name="lg" select="$lg"/>
			</xsl:call-template>

			<!-- Append site name -->
			<xsl:if test="$master-title-append-site-name = true()">
				<xsl:text> - </xsl:text>
				<xsl:value-of select="$site-name" />
			</xsl:if>
 		</xsl:if>
	</xsl:template>

<!-- Default site name -->
	<xsl:template name="default-site-name">
		<xsl:param name="lg" select="$url-language" />

		<xsl:choose>
			<xsl:when test="count($config/site-title/item) != 0">
				<xsl:value-of select="$config/site-title/item[@lang=$lg]"/>
			</xsl:when>
			<xsl:when test="string-length($config/site-title) != 0">
				<xsl:value-of select="$config/site-title"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$website-name" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<!-- Final render <title> and <meta title> tag -->
	<xsl:template name="master-title-header">

		<xsl:variable name="master-title">
			<xsl:call-template name="master-title" />
		</xsl:variable>

		<!-- Use Master title if available or $site-name instead -->
		<xsl:variable name="final-title">
			<xsl:choose>
				<xsl:when test="string-length($master-title) != 0">
					<xsl:value-of select="$master-title" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$site-name" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<title><xsl:value-of select="normalize-space($final-title)" /></title>
		<meta name="title" content="{normalize-space($final-title)}" />
	</xsl:template>
</xsl:stylesheet>

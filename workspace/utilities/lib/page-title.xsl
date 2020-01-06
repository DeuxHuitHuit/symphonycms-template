<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- 

	PAGE-TITLE overwrite example :

	<xsl:template name="page-title">
		<xsl:param name="lg" select="$url-language" />
		<xsl:param name="title" select="'myCustomTitle'" />
		<xsl:call-template name="page-title-default">
			<xsl:with-param name="title" select="$title" />
		</xsl:call-template>
	</xsl:template>

	OVERWRITING PAGE-TITLE WILL AFFECT META TAGS, TITLE TAG, OPEN-GRAPH AND TWITTER-CARD

-->

	<xsl:template name="page-title">
		<xsl:param name="lg" select="$url-language" />
		<xsl:param name="title" select="''" />
		<xsl:call-template name="page-title-default">
			<xsl:with-param name="lg" select="$lg" />
			<xsl:with-param name="title" select="$title" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="page-title-default">
		<xsl:param name="lg" select="$url-language" />
		<xsl:param name="plh" select="/data/plh-page//page[@handle = $current-page]/item [@lang=$lg]" />
		<xsl:param name="title" />

		<xsl:choose>
			<xsl:when test="string-length($title) != 0">
				<xsl:value-of select="$title" />
			</xsl:when>
			<xsl:when test="string-length($plh) != 0">
				<xsl:value-of select="$plh" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$page-title" />
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>

</xsl:stylesheet>

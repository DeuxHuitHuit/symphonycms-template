<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:variable name="plh-page-title" select="/data/plh-page/descendant-or-self::page[@handle=$current-page]/item[@lang=$url-language]" />

<xsl:template name="page-title">
	<xsl:call-template name="default-page-title" />
</xsl:template>

<xsl:template name="default-page-title">
	<xsl:if test="count(/data/params/page-types/item[@handle = 'index']) = 0 and string-length($plh-page-title) &gt; 0">
		<xsl:value-of select="$plh-page-title"/>
		<xsl:text> - </xsl:text>
	</xsl:if>
	<xsl:value-of select="/data/site-config/entry [1]/site-titre" />
</xsl:template>

<xsl:template name="page-title-header">
	<xsl:variable name="page-title">
		<xsl:call-template name="page-title" />
	</xsl:variable>
	
	<xsl:variable name="title">
		<xsl:choose>
			<xsl:when test="string-length($page-title)">
				<xsl:value-of select="$page-title" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$website-name" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<title><xsl:value-of select="$title" /></title>
	<meta name="title" content="{$title}" />
</xsl:template>

</xsl:stylesheet>
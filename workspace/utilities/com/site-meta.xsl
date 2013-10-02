<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="page-metas">
	<xsl:call-template name="default-page-metas" />
</xsl:template>

<xsl:template name="default-page-metas">
	<xsl:call-template name="open-graph" />
	<xsl:call-template name="twitter-card" />
</xsl:template>

<xsl:template name="twitter-card">
	<xsl:param name="image" select="concat($root, $meta/meta-image/@path, '/' $metas/meta-image/filename)" />
	
	<xsl:choose>
		<xsl:when test="string-length($metas/meta-image/filename) != 0">
			<meta name="twitter:card" content="summary_large_image" />
		</xsl:when>
		<xsl:otherwise>
			<meta name="twitter:card" content="summary" />
		</xsl:otherwise>
	</xsl:choose>
	<meta name="twitter:title" content="{$metas/titre}" />
	<meta name="twitter:site" content="" />
	<meta name="twitter:creator" content="" />
	<xsl:if test="string-length($metas/meta-image/filename) != 0">
		<meta name="twitter:image" content="{$image}" />
	</xsl:if>
	<meta name="twitter:description" content="{$metas/meta-description}" />
</xsl:template>

<xsl:template name="open-graph">
	<xsl:param name="image" select="concat($root, $meta/meta-image/@path, '/' $metas/meta-image/filename)" />
	<xsl:param name="type" select="'website'" />
	
	<meta property="og:title" content="{$metas/titre}" />
	<meta property="og:type" content="" />
	<xsl:if test="string-length($metas/meta-image/filename) != 0">
		<meta property="og:image:url" content="{$image}" />
		<meta property="og:image:width" content="{$metas/meta-image/@width}" />
		<meta property="og:image:height" content="{$metas/meta-image/@height}" />
	</xsl:if>
	<meta property="og:description" content="{$metas/meta-description}" />
</xsl:template>

</xsl:stylesheet>
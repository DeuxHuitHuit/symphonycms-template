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
	<xsl:param name="titre" select="$metas/site-titre" />
	<xsl:param name="image" select="$metas/image-partage" />
	<xsl:param name="image-path" select="concat($root, '/workspace', $image/@path, '/', $image/filename)" />
	<xsl:param name="description" select="$metas/site-description" />
	<xsl:param name="site" select="'@         '" />
	<xsl:param name="creator" select="'@        '" />
	<xsl:param name="domain" select="'         '" />
	
	<xsl:choose>
		<xsl:when test="string-length($image) != 0">
			<meta name="twitter:card" content="summary_large_image" />
		</xsl:when>
		<xsl:otherwise>
			<meta name="twitter:card" content="summary" />
		</xsl:otherwise>
	</xsl:choose>
	
	<meta name="twitter:site" content="{$site}" />
	<meta name="twitter:title" content="{$titre}" />
	<meta name="twitter:creator" content="{$creator}" />
	<meta name="twitter:domain" content="{$domain}" />
	<xsl:if test="string-length($image) != 0">
		<meta name="twitter:image:src" content="{$image-path}" />
	</xsl:if>
	<meta name="twitter:description" content="{$description}" />
</xsl:template>

<xsl:template name="open-graph">
	<xsl:param name="titre" select="$metas/site-titre" />
	<xsl:param name="image" select="$metas/image-partage" />
	<xsl:param name="image-path" select="concat($root, '/workspace', $image/@path, '/', $image/filename)" />
	<xsl:param name="description" select="$metas/site-description" />
	<xsl:param name="type" select="'website'" />
	<xsl:param name="url" select="$current-url" />
	
	<meta property="og:title" content="{$titre}" />
	<meta property="og:url" content="{$url}" />
	<meta property="og:type" content="{$type}" />
	<xsl:if test="string-length($image) != 0">
		<meta property="og:image:url" content="{$image-path}" />
		<meta property="og:image:width" content="{$image/meta/@width}" />
		<meta property="og:image:height" content="{$image/meta/@height}" />
	</xsl:if>
	<meta property="og:description" content="{$description}" />
</xsl:template>

</xsl:stylesheet>
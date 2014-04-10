<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="page-metas">
	<xsl:call-template name="default-page-metas" />
</xsl:template>

<xsl:template name="default-page-metas">
	<xsl:call-template name="html-metas" />
	<xsl:call-template name="open-graph" />
	<xsl:call-template name="twitter-card" />
</xsl:template>

<xsl:template name="canonical-url">
	<xsl:variable name="real-url">
		<xsl:call-template name="create-page-url-by-id" />
	</xsl:variable>
	
	<xsl:variable name="url">
		<xsl:choose>
			<xsl:when test="string-length($real-url) != 0">
				<xsl:value-of select="$real-url" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($current-url, '/')" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<link rel="canonical" href="{$url}" />
</xsl:template>

<xsl:template name="html-metas">
	<xsl:param name="description" select="$metas/site-description" />

	<meta name="description" content="{$description}" />
</xsl:template>

<!-- TODO : Fill -->
<xsl:template name="twitter-card">
	<xsl:param name="titre" select="$metas/site-titre" />
	<xsl:param name="image" select="$metas/image-partage" />
	<xsl:param name="image-path" />
	<xsl:param name="description" select="$metas/site-description" />
	<xsl:param name="site" select="$metas/twitter-user" />
	<xsl:param name="creator" select="$metas/twitter-user" />
	<xsl:param name="domain" select="$metas/twitter-site-domain" />
	
	<xsl:variable name="image-full-path">
		<xsl:choose>
			<xsl:when test="string-length($image-path) != 0">
				<xsl:value-of select="$image-path" />
			</xsl:when>
			<xsl:when test="string-length($image)">
				<xsl:value-of select="concat($root, '/workspace', $image/@path, '/', $image/filename)" />
			</xsl:when>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:choose>
		<xsl:when test="string-length($image-full-path) != 1">
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
	<xsl:if test="string-length($image-path) != 1">
		<meta name="twitter:image:src" content="{$image-full-path}" />
	</xsl:if>
	<meta name="twitter:description" content="{$description}" />
</xsl:template>

<xsl:template name="open-graph">
	<xsl:param name="titre" select="$metas/site-titre" />
	<xsl:param name="image" select="$metas/image-partage" />
	<xsl:param name="image-path" />
	<xsl:param name="description" select="$metas/site-description" />
	<xsl:param name="type" select="'website'" />
	<xsl:param name="url" select="concat($current-url, '/')" />
	
	<xsl:variable name="image-full-path">
		<xsl:choose>
			<xsl:when test="string-length($image-path) != 0">
				<xsl:value-of select="$image-path" />
			</xsl:when>
			<xsl:when test="string-length($image)">
				<xsl:value-of select="concat($root, '/workspace', $image/@path, '/', $image/filename)" />
			</xsl:when>
		</xsl:choose>
	</xsl:variable>
	
	<meta property="og:title" content="{$titre}" />
	<meta property="og:url" content="{$url}" />
	<meta property="og:type" content="{$type}" />
	<xsl:if test="string-length($image-full-path) != 1">
		<meta property="og:image:url" content="{$image-full-path}" />
	</xsl:if>
	<xsl:if test="string-length($image) != 0">
		<meta property="og:image:width" content="{$image/meta/@width}" />
		<meta property="og:image:height" content="{$image/meta/@height}" />
	</xsl:if>
	<meta property="og:description" content="{$description}" />
</xsl:template>

</xsl:stylesheet>
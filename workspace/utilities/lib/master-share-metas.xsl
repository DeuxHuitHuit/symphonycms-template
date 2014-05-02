<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="master-share-metas">
	<xsl:call-template name="default-master-share-metas" />
</xsl:template>

<xsl:template name="default-master-share-metas">
	<xsl:call-template name="html-metas" />
	<xsl:call-template name="open-graph" />
	<xsl:call-template name="twitter-card" />
</xsl:template>

<xsl:template name="html-metas">
	<xsl:param name="description" select="$site-description" />
	
	<xsl:if test="string-length($description) != 0">
		<meta name="description" content="{$description}" />
	</xsl:if>
</xsl:template>

<xsl:template name="twitter-card">
	<xsl:param name="title" select="$default-share-page-title" />
	<xsl:param name="description" select="$site-description" />
	<xsl:param name="image" select="$site-share-image" />
	<xsl:param name="image-path" />
	
	<xsl:param name="site" select="$twitter-card-site" />
	<xsl:param name="creator" select="$twitter-card-creator" />
	<xsl:param name="domain" select="$twitter-card-domain" />
	
	<xsl:variable name="image-full-path">
		<xsl:call-template name="get-image-full-path">
			<xsl:with-param name="image" select="$image" />
			<xsl:with-param name="image-path" select="$image-path" />
		</xsl:call-template>
	</xsl:variable>
	
	<!-- ouput if twitter card site is set -->
	<xsl:if test="string-length($twitter-card-site) != 0">
	
		<!-- get the right card style if we have an image -->
		<xsl:choose>
			<xsl:when test="string-length($image-full-path) != 1">
				<meta name="twitter:card" content="summary_large_image" />
			</xsl:when>
			<xsl:otherwise>
				<meta name="twitter:card" content="summary" />
			</xsl:otherwise>
		</xsl:choose>
	
		<meta name="twitter:site" content="{$site}" />
		<meta name="twitter:title" content="{$title}" />
		<meta name="twitter:creator" content="{$creator}" />
		<meta name="twitter:domain" content="{$domain}" />
		<xsl:if test="string-length($image-path) != 1">
			<meta name="twitter:image:src" content="{$image-full-path}" />
		</xsl:if>
		<meta name="twitter:description" content="{$description}" />
	</xsl:if>
</xsl:template>

<xsl:template name="open-graph">
	<xsl:param name="title" select="$default-share-page-title" />
	<xsl:param name="image" select="$site-share-image" />
	<xsl:param name="image-path" />
	<xsl:param name="image-width" select="''" />
	<xsl:param name="image-height" select="''" />
	<xsl:param name="description" select="$site-description" />
	<xsl:param name="type" select="'website'" />
	<xsl:param name="url" select="concat($current-url, '/')" />
	
	<!-- Variables -->
	<xsl:variable name="image-full-path">
		<xsl:call-template name="get-image-full-path">
			<xsl:with-param name="image" select="$image" />
			<xsl:with-param name="image-path" select="$image-path" />
		</xsl:call-template>
	</xsl:variable>
	
	<xsl:variable name="image-real-width">
		<xsl:choose>
			<xsl:when test="string-length($image) != 0">
				<xsl:value-of select="$image/meta/@width" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$image-width" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="image-real-height">
		<xsl:choose>
			<xsl:when test="string-length($image) != 0">
				<xsl:value-of select="$image/meta/@height" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$image-height" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<!-- Output -->
	<meta property="og:title" content="{$title}" />
	<meta property="og:url" content="{$url}" />
	<meta property="og:type" content="{$type}" />
	
	<xsl:if test="string-length($image-path) != 1">
		<meta property="og:image" content="{$image-full-path}" />
		<meta property="og:image:url" content="{$image-full-path}" />
	</xsl:if>
	<xsl:if test="string-length($image-real-width) != 0">
		<meta property="og:image:width" content="{$image-real-width}" />
	</xsl:if>
	<xsl:if test="string-length($image-real-height) != 0">
		<meta property="og:image:height" content="{$image-real-height}" />
	</xsl:if>
	
	<xsl:if test="string-length($description) != 0">
		<meta property="og:description" content="{$description}" />
	</xsl:if>
</xsl:template>

<!-- Tools function -->
<xsl:template name="get-image-full-path">
	<xsl:param name="image" />
	<xsl:param name="image-path" />
	
	<xsl:choose>
		<xsl:when test="string-length($image-path) != 0">
			<xsl:value-of select="$image-path" />
		</xsl:when>
		<xsl:when test="string-length($image)">
			<xsl:value-of select="concat($root, '/workspace', $image/@path, '/', $image/filename)" />
		</xsl:when>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
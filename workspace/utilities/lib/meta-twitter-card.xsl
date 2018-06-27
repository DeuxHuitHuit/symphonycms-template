<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="meta-twitter-card">
	<xsl:param name="title" select="$meta-title" />
	<xsl:param name="description" select="$meta-description" />
	<xsl:param name="image">
		<xsl:call-template name="get-image-path">
			<xsl:with-param name="image" select="$meta-image" />
		</xsl:call-template>
	</xsl:param>

	<xsl:variable name="summary">
		<xsl:choose>
			<xsl:when test="string-length($image) != 0">
				<xsl:text>summary_large_image</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>summary</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:if test="string-length($twitter-card-site) != 0">
		<meta name="twitter:card" content="$summary" />
		<meta name="twitter:site" content="{$twitter-card-site}" />
		<meta name="twitter:title" content="{$title}" />
		<meta name="twitter:creator" content="{$twitter-card-creator}" />
		<meta name="twitter:domain" content="{$twitter-card-domain}" />
		<xsl:if test="string-length($image) != 0">
			<meta name="twitter:image" content="{$image}" />
		</xsl:if>
		<meta name="twitter:description" content="{$description}" />
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
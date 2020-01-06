<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="twitter-card">
		<xsl:param name="title">
			<xsl:call-template name="page-title" />
		</xsl:param>
		<xsl:param name="description">
			<xsl:call-template name="page-description" />
		</xsl:param>
		<xsl:param name="image-path" />
		<xsl:param name="site" select="$twitter-card-site" />
		<xsl:param name="creator" select="$twitter-card-creator" />
		<xsl:param name="domain" select="$twitter-card-domain" />
		
		<xsl:choose>
			<xsl:when test="string-length($image-path) != 0">
				<meta name="twitter:card" content="summary_large_image" />
			</xsl:when>
			<xsl:otherwise>
				<meta name="twitter:card" content="summary" />
			</xsl:otherwise>
		</xsl:choose>
	
		<xsl:if test="string-length($site) != 0">
			<meta name="twitter:site" content="{$site}" />
		</xsl:if>

		<xsl:if test="string-length($title) != 0">
			<meta name="twitter:title" content="{$title}" />
		</xsl:if>

		<xsl:if test="string-length($creator) != 0">
			<meta name="twitter:creator" content="{$creator}" />
		</xsl:if>

		<xsl:if test="string-length($domain) != 0">
			<meta name="twitter:domain" content="{$domain}" />
		</xsl:if>
		<xsl:if test="string-length($image-path) != 0">
			<meta name="twitter:image" content="{$image-path}" />
		</xsl:if>

		<xsl:if test="string-length($description) != 0">
			<meta name="twitter:description" content="{$description}" />
		</xsl:if>

	</xsl:template>

</xsl:stylesheet>

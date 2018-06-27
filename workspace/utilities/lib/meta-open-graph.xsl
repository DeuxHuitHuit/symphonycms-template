<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- meta-open-graph -->
	<xsl:template name="meta-open-graph">
		<xsl:param name="title" select="$og-title" />
		<xsl:param name="image" select="$og-image" />
		<xsl:param name="image-path">
			<xsl:call-template name="get-image-path">
				<xsl:with-param name="image" select="$og-image" />
			</xsl:call-template>
		</xsl:param>
		<xsl:param name="image-width" select="$og-image/meta/@width" />
		<xsl:param name="image-height" select="$og-image/meta/@height" />
		<xsl:param name="description" select="$meta-description" />
		<xsl:param name="type" select="$og-type" />
		<xsl:param name="url" select="$og-url" />

		<meta property="og:title" content="{$title}" />
		<meta property="og:url" content="{$url}" />
		<meta property="og:type" content="{$type}" />

		<xsl:if test="string-length($description) != 0">
			<meta property="og:description" content="{$description}" />
		</xsl:if>

		<xsl:if test="string-length($facebook-app-id) != 0">
			<meta property="fb:app_id" content="{$facebook-app-id}" />
		</xsl:if>

		<xsl:if test="string-length($image-path) != 0">
			<meta property="og:image" content="{$image-path}" />
			<meta property="og:image:url" content="{$image-path}" />
			<meta property="og:image:width" content="{$image-width}" />
			<meta property="og:image:height" content="{$image-height}" />
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>

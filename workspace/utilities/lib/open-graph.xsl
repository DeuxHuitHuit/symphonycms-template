<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="open-graph">
		<xsl:param name="title">
			<xsl:call-template name="page-title" />
		</xsl:param>
		<xsl:param name="image-path" />
		<xsl:param name="image-width"  />
		<xsl:param name="image-height" />
		<xsl:param name="description">
			<xsl:call-template name="page-description" />
		</xsl:param>
		<xsl:param name="type" select="'website'" />
		<xsl:param name="url" />
	
		<xsl:if test="string-length($config/facebook-app-id) != 0">
			<meta property="fb:app_id" content="{$config/facebook-app-id}" />
		</xsl:if>

		<xsl:if test="string-length($title) != 0">
			<meta property="og:title" content="{$title}" />
		</xsl:if>

		<xsl:if test="string-length($url) != 0">
			<meta property="og:url" content="{$url}" />
		</xsl:if>

		<xsl:if test="string-length($type) != 0">
			<meta property="og:type" content="{$type}" />
		</xsl:if>
		
		<xsl:if test="string-length($image-path) != 0">
			<meta property="og:image" content="{$image-path}" />
		</xsl:if>

		<xsl:if test="string-length($image-width) != 0 and string-length($image-height) != 0">
			<meta property="og:image:width" content="{$image-width}" />
			<meta property="og:image:height" content="{$image-height}" />
		</xsl:if>
		
		<xsl:if test="string-length($description) != 0">
			<meta property="og:description" content="{$description}" />
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	extension-element-prefixes="exsl">

<!-- 

	META-SHARE should only be overwritten to add custom images to open-graph and twitter-card.
	The first example is used for images as valid XML node.
	Second one os for absolute path when you only have a string.
	FOR CUSTOM DESCRIPTION AND TITLE, SEE PAGE-TITLE.XSL AND PAGE-DESCRIPTION.XSL

	<xsl:template name="meta-share">
		<xsl:call-template name="meta-share-default">
			<xsl:with-param name="image" select="/path/to/my/image" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="meta-share">
		<xsl:call-template name="meta-share-default">
			<xsl:with-param name="image-path" select="'https://myurl/image.jpeg'" />
			<xsl:with-param name="image-width" select="''" />
			<xsl:with-param name="image-height" select="''" />
		</xsl:call-template>
	</xsl:template>

 -->

	<xsl:template name="meta-share">
		<xsl:call-template name="meta-share-default" />
	</xsl:template>

	<xsl:template name="meta-share-default">
		<xsl:param name="image" select="$config/image" />
		<xsl:param name="image-node" select="exsl:node-set($image)" />
		<xsl:param name="image-path">
			<xsl:call-template name="util-image-path">
				<xsl:with-param name="image" select="$image" />
			</xsl:call-template>
		</xsl:param>
		<xsl:param name="image-width" select="$image-node/meta/@width" />
		<xsl:param name="image-height" select="$image-node/meta/@width" />

		<xsl:call-template name="meta-description" />
		<xsl:call-template name="open-graph">
			<xsl:with-param name="image-path" select="$image-path" />
			<xsl:with-param name="image-width" select="$image-width" />
			<xsl:with-param name="image-height" select="$image-width" />
		</xsl:call-template>
		<xsl:call-template name="twitter-card">
			<xsl:with-param name="image-path" select="$image-path" />
		</xsl:call-template>
	</xsl:template>

</xsl:stylesheet>

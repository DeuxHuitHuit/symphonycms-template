<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- VIDEOS (youtube, vimeo) -->
<xsl:template match="url[driver = 'YouTube' or driver = 'Vimeo']" mode="module-embed-item">
	<xsl:call-template name="com-embed-video" />
</xsl:template>

<!-- DEFAULT -->
<xsl:template match="*" mode="module-embed-item" priority="0">
	<xsl:variable name="attr">
		<xsl:call-template name="util-oembed-attr" />
		<add dev-element="module-embed-item" />
	</xsl:variable>

	<!-- STRUCTURE -->
	<xsl:call-template name="element">
		<xsl:with-param name="attr" select="$attr" />
	</xsl:call-template>
</xsl:template>
</xsl:stylesheet>

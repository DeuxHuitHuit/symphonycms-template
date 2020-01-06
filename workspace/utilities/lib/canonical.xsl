<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="page-canonical">
		<xsl:call-template name="canonical-default" />
	</xsl:template>

	<xsl:template name="canonical-default">
		<xsl:value-of select="concat($current-url, '/')" />
	</xsl:template>

	<xsl:template name="meta-canonical">
		<xsl:param name="url">
			<xsl:call-template name="page-canonical" />
		</xsl:param>
		<link rel="canonical" href="{$url}" />
	</xsl:template>

</xsl:stylesheet>

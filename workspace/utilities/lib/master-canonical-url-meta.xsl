<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:variable name="generated-page-url">
	<xsl:call-template name="create-page-url-by-id" />
</xsl:variable>

<xsl:template name="canonical-url">
	<xsl:value-of select="concat($current-url, '/')" />
</xsl:template>

<xsl:template name="master-canonical-url-meta">
	<xsl:variable name="url">
		<xsl:call-template name="canonical-url" />
	</xsl:variable>
	
	<link rel="canonical" href="{$url}" />
</xsl:template>

</xsl:stylesheet>
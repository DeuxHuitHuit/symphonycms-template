<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="master-canonical-url-meta">
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

</xsl:stylesheet>
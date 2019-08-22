<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="meta-title">
		<xsl:param name="lg" />
		<xsl:param name="title">
			<xsl:call-template name="full-title" />
		</xsl:param>
		<title><xsl:value-of select="$title" /></title>
		<meta name="title" content="{$title}" />
	</xsl:template>
	
</xsl:stylesheet>
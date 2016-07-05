<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="page-title">
	<xsl:call-template name="default-page-title" />
</xsl:template>

<xsl:template name="default-page-title">
	<xsl:variable name="plh-page-title" select="/data/plh-page//page [@handle=$current-page]/item [@lang=$url-language]" />
	
	<xsl:choose>
		<xsl:when test="string-length($plh-page-title) != 0">
			<xsl:value-of select="$plh-page-title" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$page-title" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="util-auto-handle">
		<xsl:param name="qs" select="true()" />
		<xsl:if test="string-length(/data/params/handle)">
			<xsl:value-of select="/data/params/handle" />
			<xsl:text>/</xsl:text>
		</xsl:if>
		<xsl:if test="string-length(/data/params/current-query-string) and $qs = true()">
			<xsl:text>?</xsl:text>
			<xsl:value-of select="/data/params/current-query-string" />
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
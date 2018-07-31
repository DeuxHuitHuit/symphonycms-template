<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- meta-description -->
	<xsl:template name="meta-description">
		<xsl:variable name="computed-description">
			<xsl:choose>
				<xsl:when test="string-length($page-description) != 0">
					<xsl:value-of select="$page-description" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$site-description" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="$computed-description" />
	</xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="meta-description">
		<xsl:param name="site-description">
			<xsl:call-template name="site-description" />
		</xsl:param>
		<xsl:param name="page-description">
			<xsl:call-template name="page-description" />
		</xsl:param>
		<xsl:param name="description">
			<xsl:choose>
				<xsl:when test="string-length($page-description) != 0">
					<xsl:value-of select="$page-description" />
				</xsl:when>
				<xsl:when test="string-length($site-description) != 0">
					<xsl:value-of select="$site-description" />
				</xsl:when>
			</xsl:choose>
		</xsl:param>

		<xsl:if test="string-length($description) != 0">
			<meta name="description" content="{$description}" />
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>

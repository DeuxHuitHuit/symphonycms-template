<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: meta-title -->
	<xsl:template name="meta-title">
		<xsl:param name="title">
			<xsl:choose>
				<xsl:when test="count(/data/params/page-types/item[@handle = 'index']) = 1">
					<xsl:choose>
						<xsl:when test="string-length($site-title) != 0">
							<xsl:value-of select="$site-title" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$site-name" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$page-title" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>

		<xsl:value-of select="$title" />

		<xsl:if test="$append-site-title">
			<xsl:text> - </xsl:text>
			<xsl:value-of select="$site-name" />
		</xsl:if>

	</xsl:template>
</xsl:stylesheet>

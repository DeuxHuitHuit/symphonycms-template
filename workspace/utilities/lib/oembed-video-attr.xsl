<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:template name="oembed">
	<xsl:param name="video-complet" select="video-complet" />
	
	<xsl:if test="string-length($video-complet) != 0">
		<xsl:attribute name="data-video-provider">
			<xsl:value-of select="$video-complet/driver" />
		</xsl:attribute>
		<xsl:attribute name="data-video-id">
			<xsl:choose>
				<xsl:when test="$video-complet/driver = 'YouTube'">
					<xsl:value-of select="$video-complet/url" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$video-complet/@id" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
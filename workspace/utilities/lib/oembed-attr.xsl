<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="oembed-attr">
	<xsl:param name="oembed" select="oembed" />
	
	<xsl:if test="string-length($oembed) != 0">
		<set>
			<xsl:attribute name="data-oembed-id">
				<xsl:choose>
					<xsl:when test="$oembed/driver = 'YouTube'">
						<xsl:value-of select="$oembed/url" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$oembed/@id" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		</set>
		
		<set data-oembed-provider="{$oembed/driver}" />
		<set data-oembed-title="{$oembed/title}" />
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
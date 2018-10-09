<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="util-oembed-attr">
	<xsl:param name="driver" select="driver" />
	<xsl:param name="url" select="url" />
	<xsl:param name="id" select="@id" />
	<xsl:param name="title" select="title" />

	<set>
		<xsl:attribute name="data-oembed-id">
			<xsl:choose>
				<xsl:when test="$driver = 'YouTube'">
					<xsl:value-of select="$url" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$id" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</set>
	<set data-oembed-provider="{$driver}" />
	<set data-oembed-title="{$title}" />
</xsl:template>

</xsl:stylesheet>
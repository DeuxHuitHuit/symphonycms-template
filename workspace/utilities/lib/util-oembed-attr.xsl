<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="util-oembed-attr">
	<xsl:param name="driver" select="driver" />
	<xsl:param name="url" select="url" />
	<xsl:param name="id" select="@id" />
	<xsl:param name="title" select="title" />

	<xsl:choose>
		<xsl:when test="$driver = 'YouTube'">
			<set data-oembed-id="$url" />
		</xsl:when>
		<xsl:otherwise>
			<set data-oembed-id="$id" />
		</xsl:otherwise>
	</xsl:choose>
	<set data-oembed-provider="{$driver}" />
	<set data-oembed-title="{$title}" />
</xsl:template>

</xsl:stylesheet>
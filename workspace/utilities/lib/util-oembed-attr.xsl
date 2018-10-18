<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="util-oembed-attr">
	<xsl:param name="driver" select="driver" />
	<xsl:param name="url" select="url" />
	<xsl:param name="id" select="@id" />
	<xsl:param name="title" select="title" />

	<xsl:variable name="has-id" select="string-length($id) != 0" />
	<xsl:variable name="has-url" select="string-length($url) != 0" />

	<xsl:choose>
		<xsl:when test="$driver = 'YouTube'">
			<xsl:if test="$has-url">
				<set data-oembed-id="$url" />
			</xsl:if>
		</xsl:when>
		<xsl:otherwise>
			<xsl:if test="$has-id">
				<set data-oembed-id="$id" />
			</xsl:if>
		</xsl:otherwise>
	</xsl:choose>
	<set data-oembed-provider="{$driver}" />
	<set data-oembed-title="{$title}" />
</xsl:template>

</xsl:stylesheet>

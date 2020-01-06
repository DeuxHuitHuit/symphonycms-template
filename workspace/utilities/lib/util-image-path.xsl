<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


	<xsl:template name="util-image-path">
		<xsl:param name="image" />
		<xsl:choose>
			<xsl:when test="string-length($image) != 0 and $image/filename">
				<xsl:value-of select="concat($root, '/workspace', $image/@path, '/', $image/filename)" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$image" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- 
	return the absolute image path from a valid <image> node 
-->

<xsl:template name="get-image-path">
	<xsl:param name="image" />
	<xsl:if test="string-length($image) != 0">
		<xsl:value-of select="concat($root, '/workspace', $image/@path, '/', $image/filename)" />
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template name="picture-src">
		<xsl:param name="image" />
		<xsl:param name="size" />

		<xsl:text>https://ficelle.app/v1/?src=</xsl:text>
		<xsl:value-of select="$root" />
		<xsl:text>/workspace</xsl:text>
		<xsl:value-of select="$image/@path" />
		<xsl:text>/</xsl:text>
		<xsl:value-of select="$image/filename" />
		<xsl:text>&amp;forceSVG=true</xsl:text>
		<xsl:if test="number($size/@width) &gt; 1">
			<xsl:text>&amp;width=</xsl:text><xsl:value-of select="$size/@width" />
		</xsl:if>
		<xsl:if test="number($size/@height) &gt; 1">
			<xsl:text>&amp;height=</xsl:text><xsl:value-of select="$size/@height" />
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>

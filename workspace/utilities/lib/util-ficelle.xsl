<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://exslt.org/strings"
	exclude-result-prefixes="str">

	<xsl:template name="picture-src">
		<xsl:param name="image" />
		<xsl:param name="size" />
		<xsl:param name="quality" select="'80'"/>

		<xsl:variable name="computed-src">
			<xsl:value-of select="$root" />
			<xsl:text>/workspace</xsl:text>
			<xsl:value-of select="$image/@path" />
			<xsl:text>/</xsl:text>
			<xsl:value-of select="$image/filename" />
		</xsl:variable>

		<xsl:text>https://ficelle.app/v1/?src=</xsl:text>
		<xsl:value-of select="str:encode-uri($computed-src, true())" />
		<xsl:if test="number($size/@width) &gt; 1">
			<xsl:text>&amp;width=</xsl:text><xsl:value-of select="$size/@width" />
		</xsl:if>
		<xsl:if test="number($size/@request-height) &gt; 1">
			<xsl:text>&amp;height=</xsl:text><xsl:value-of select="$size/@request-height" />
		</xsl:if>
		<xsl:if test="number($quality) &gt; 1">
			<xsl:text>&amp;quality=</xsl:text><xsl:value-of select="$quality" />
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exslt="http://exslt.org/common"
	exclude-result-prefixes="exslt"
>

<xsl:template name="content">
	<xsl:param name="content" />
	
	<xsl:choose>
		<xsl:when test="exslt:object-type($content) = 'string'">
			<xsl:value-of select="$content" />
		</xsl:when>
		<xsl:when test="exslt:object-type($content) = 'RTF'">
			<xsl:copy-of select="$content"/>
		</xsl:when>
		<xsl:when test="exslt:object-type($content) = 'node-set' and count($content/*) = 0">
			<xsl:value-of select="$content" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:copy-of select="$content/*" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:exsl="http://exslt.org/common"
	xmlns:str="http://exslt.org/strings"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="exsl str">

<!-- CORE-FUNCTION: append-qs-value =============================================================-->
	<xsl:template name="append-qs-value">
		<xsl:param name="url" />
		<xsl:param name="value" />

	<!-- STRUCTURE															 -->
		<xsl:value-of select="$url" />
		<xsl:if test="string-length($value) != 0">
			<xsl:choose>
				<xsl:when test="contains($url, '?')">
					<xsl:text>&amp;</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>?</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:value-of select="$value" />
		</xsl:if>
	<!--																	/-->
	</xsl:template>

</xsl:stylesheet>
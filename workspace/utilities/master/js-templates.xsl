<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="javascript/*/file" mode="local">
		<script src="{$js-path}{.}"></script>
	</xsl:template>

	<xsl:template match="javascript/*/file" mode="cdn">
		<script src="{.}"></script>
	</xsl:template>

	<xsl:template match="javascript/*/file" mode="cdn-async">
		<xsl:variable name="src">
			<xsl:variable name="lang-token" select="'{lang}'" />
			<xsl:choose>
				<xsl:when test="contains(., $lang-token)">
					<xsl:value-of select="substring-before(., $lang-token)" />
					<xsl:value-of select="$url-language" />
					<xsl:value-of select="substring-after(., $lang-token)" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="." />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<script src="{$src}" async="" defer=""></script>
	</xsl:template>
</xsl:stylesheet>

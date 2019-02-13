<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="copyright-288">
		<xsl:param name="attr" />

		<xsl:variable name="url">
			<xsl:choose>
				<xsl:when test="$dev = true()">
					<xsl:text>https://watermark.288dev.com</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>https://watermark.deuxhuithuit.com</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>/v3/?</xsl:text>
			<xsl:text>lang=</xsl:text><xsl:value-of select="$url-language" />
			<xsl:text>&amp;ref=</xsl:text><xsl:value-of select="$site-ref" />
		</xsl:variable>

		<xsl:variable name="computed-attr">
			<set data-href="{$url}" />
			<add class="js-watermark-ctn" />
			<xsl:copy-of select="$attr" />
		</xsl:variable>

		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$computed-attr" />
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>

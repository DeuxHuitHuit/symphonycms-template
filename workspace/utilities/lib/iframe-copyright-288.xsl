<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="iframe-copyright-288">
		<xsl:param name="bg-color" select="'transparent'" />
		<xsl:param name="text-color" select="'FFF'" />
		<xsl:param name="logo-color" select="'fff'" />
		<xsl:param name="font" select="'Arial, Helvetica, sans-serif'" />
		<xsl:param name="font-size" select="'12'" />
		<xsl:param name="w" select="'150'" />
		<xsl:param name="h" select="'28'" />
		<xsl:param name="word" select="'Credits'" />
		<xsl:param name="text-transform" select="'none'" />
		<xsl:param name="display" select="'inline'" />
		<xsl:param name="t-align" select="'left'" />
		<xsl:param name="l-height" select="'0'" />
		<xsl:param name="logo-align" select="'left'" />
		<xsl:param name="logo-always-animated" select="'false'" />
		<xsl:param name="no-logo" select="'false'" />

		<xsl:variable name="url">
			<xsl:choose>
				<xsl:when test="$dev = true()">
					<xsl:text>https://watermark.288dev.com</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>https://watermark.deuxhuithuit.com</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>/v2/?</xsl:text>
			<xsl:text>lang=</xsl:text><xsl:value-of select="$url-language" />
			<xsl:text>&amp;bg=</xsl:text><xsl:value-of select="$bg-color" />
			<xsl:text>&amp;text=</xsl:text><xsl:value-of select="$text-color" />
			<xsl:text>&amp;logo-color=</xsl:text><xsl:value-of select="$logo-color" />
			<xsl:text>&amp;font=</xsl:text><xsl:value-of select="$font" />
			<xsl:text>&amp;font-size=</xsl:text><xsl:value-of select="$font-size" />
			<xsl:text>&amp;w=</xsl:text><xsl:value-of select="$w" />
			<xsl:text>&amp;h=</xsl:text><xsl:value-of select="$h" />
			<xsl:text>&amp;ref=</xsl:text><xsl:value-of select="$site-ref" />
			<xsl:text>&amp;word=</xsl:text><xsl:value-of select="$word" />
			<xsl:text>&amp;transform=</xsl:text><xsl:value-of select="$text-transform" />
			<xsl:text>&amp;display=</xsl:text><xsl:value-of select="$display" />
			<xsl:text>&amp;t-align=</xsl:text><xsl:value-of select="$t-align" />
			<xsl:text>&amp;l-height=</xsl:text><xsl:value-of select="$l-height" />
			<xsl:text>&amp;logo-align=</xsl:text><xsl:value-of select="$logo-align" />
			<xsl:text>&amp;logo-always-animated=</xsl:text><xsl:value-of select="$logo-always-animated" />
			<xsl:text>&amp;no-logo=</xsl:text><xsl:value-of select="$no-logo" />
		</xsl:variable>
		
		<iframe class="copy-288"
				src="{$url}"
				margin="0"
				border="0"
				scrolling="no"
				frameborder="no"
				width="{$w}"
				height="{number($h)}"></iframe>

	</xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">



<xsl:template name="site-footer">
	<footer>
		<xsl:call-template name="iframe-copy-288" />
	</footer>
</xsl:template>



<xsl:template name="iframe-copy-288">
	<xsl:variable name="bg-color" select="'000'" />
	<xsl:variable name="text-color" select="'FFF'" />
	<xsl:variable name="font" select="'Arial, Helvetica, sans-serif'" />
	<xsl:variable name="font-size" select="'12'" />
	<xsl:variable name="w" select="'220'" />
	<xsl:variable name="h" select="'33'" />
	<xsl:variable name="logo" select="'/logo-w.png'" />

	<xsl:variable name="url">
		<xsl:text>http://watermark.deuxhuithuit.com/?</xsl:text>
		<xsl:text>lang=</xsl:text><xsl:value-of select="$url-language" />
		<xsl:text>&amp;bg=</xsl:text><xsl:value-of select="$bg-color" />
		<xsl:text>&amp;text=</xsl:text><xsl:value-of select="$text-color" />
		<xsl:text>&amp;font=</xsl:text><xsl:value-of select="$font" />
		<xsl:text>&amp;font-size=</xsl:text><xsl:value-of select="$font-size" />
		<xsl:text>&amp;w=</xsl:text><xsl:value-of select="$w" />
		<xsl:text>&amp;h=</xsl:text><xsl:value-of select="$h" />
		<xsl:text>&amp;logo=</xsl:text><xsl:value-of select="$logo" />
		<xsl:text>&amp;ref=</xsl:text><xsl:value-of select="$site-ref" />
	</xsl:variable>
	
	<iframe class="copy-288" 
			src="{$url}" 
			margin="0" 
			border="0" 
			scrolling="no" 
			frameborder="no" 
			width="{$w}" 
			height="{$h}"></iframe>

</xsl:template>

</xsl:stylesheet>
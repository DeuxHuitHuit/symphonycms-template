<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="favicon">

		<xsl:variable name="filename">
			<xsl:text>favicon</xsl:text>
			<xsl:if test="$dev = true()">
				<xsl:text>-dev</xsl:text>
			</xsl:if>
		</xsl:variable>

		<link rel="shortcut icon"     href="{$root}/{$filename}.ico" type="image/vnd.microsoft.icon" />
		<link rel="icon"              href="{$root}/{$filename}.ico" type="image/x-icon" />
		<link rel="icon"              href="{$root}/{$filename}.png" type="image/png" />
		<link rel="apple-touch-icon"  href="{$root}/{$filename}.png" type="image/png" />
		<link rel="pavatar"           href="{$root}/{$filename}.png" type="image/png" />
		<meta name="msapplication-TileImage" content="{$root}/{$filename}.png" />
	</xsl:template>
</xsl:stylesheet>

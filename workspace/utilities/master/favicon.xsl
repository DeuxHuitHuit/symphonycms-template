<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="favicon">
	<link rel="shortcut icon"     href="{$root}/favicon.ico" type="image/vnd.microsoft.icon" />
	<link rel="icon"              href="{$root}/favicon.ico" type="image/ico" />
	<link rel="icon"              href="{$root}/favicon.png" type="image/png" />
	<link rel="apple-touch-icon"  href="{$root}/favicon.png" type="image/png" />
	<link rel="pavatar"           href="{$root}/favicon.png" type="image/png" />
	<meta name="msapplication-TileImage" content="{$root}/favicon.png" />
</xsl:template>

</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="master-theme-metas">
		<xsl:if test="string-length($config/theme) != 0">
			<meta name="theme-color" content="{$config/theme}" />
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>

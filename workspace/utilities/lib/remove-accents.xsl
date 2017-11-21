<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="remove-accents">
		<xsl:param name="text" />
		<xsl:if test="string-length($text) != 0">
			<xsl:value-of select="translate($text,'áàâäéèêëíìîïóòôöúùûüçÀÂÁÄÉÊÈËÌÍÎÏÓÒÔÖÙÚÛÜÇ','aaaaeeeeiiiioooouuuucAAAAEEEEIIIIOOOOUUUUC')" />
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>

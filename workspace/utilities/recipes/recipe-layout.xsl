<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:variable name="centered-column">
		<xsl:text>flexbox flex-column flex-center</xsl:text>
	</xsl:variable>

	<xsl:variable name="series">
		<xsl:text>flexbox flex-wrap</xsl:text>
	</xsl:variable>

	<xsl:variable name="start-series">
		<xsl:value-of select="$series"/>
		<xsl:text> flex-justify-start flex-align-items-start</xsl:text>
	</xsl:variable>
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">



<xsl:template name="heading">
	<xsl:param name="content" />
	<xsl:param name="level" select="'1'"/>
	<xsl:param name="attr" />

	<xsl:element name="h{$level}">
		<xsl:call-template name="attr">
			<xsl:with-param name="attr" select="$attr" />
		</xsl:call-template>

		<xsl:call-template name="content">
			<xsl:with-param name="content" select="$content" />
		</xsl:call-template>
	</xsl:element>
</xsl:template>

</xsl:stylesheet>
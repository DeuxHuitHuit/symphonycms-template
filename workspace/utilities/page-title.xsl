<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:variable name="plh-page-title" select="/data/plh-page/descendant-or-self::page[@handle=$current-page]/item[@lang=$url-language]" />

<xsl:template name="page-title">
	<xsl:call-template name="default-page-title" />
</xsl:template>

<xsl:template name="default-page-title">
	<xsl:if test="string-length($plh-page-title) &gt; 0">
		<xsl:value-of select="$page-title"/>
		<xsl:text> - </xsl:text>
	</xsl:if>
	<xsl:value-of select="/data/config/entry [1]/site-name" />
</xsl:template>

</xsl:stylesheet>
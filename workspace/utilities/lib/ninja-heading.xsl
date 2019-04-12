<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:exsl="http://exslt.org/common"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="svg" mode="ninja-heading">
		<xsl:copy-of select="." />
	</xsl:template>

	<xsl:template mode="ninja-heading"
		match="i | strong | bold | em | span | sup | a | button | img | b | abbr | del | br | wbr | u | time | sub | small | s | q | mark | strike">
		<xsl:param name="lg" select="$url-language" />

		<xsl:element name="{name()}">
			<xsl:apply-templates select="* | @* | text()" mode="ninja-heading">
				<xsl:with-param name="lg" select="$lg" />
			</xsl:apply-templates>
		</xsl:element>
	</xsl:template>

	<xsl:template match="text()" mode="ninja-heading">
		<xsl:param name="lg" select="$url-language" />
		<xsl:call-template name="content">
			<xsl:with-param name="content" select="."/>
			<xsl:with-param name="lg" select="$lg" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="//@*" mode="ninja-heading">
		<xsl:attribute name="{name(.)}">
			<xsl:value-of select="."/>
		</xsl:attribute>
	</xsl:template>
</xsl:stylesheet>

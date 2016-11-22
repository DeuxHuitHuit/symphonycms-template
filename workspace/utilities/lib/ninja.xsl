<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:exsl="http://exslt.org/common"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Ninja nodes -->
<xsl:template match="//*" mode="ninja">
	<xsl:param name="key" />

	<xsl:element name="{name()}">
		<xsl:apply-templates select="* | @* | text()" mode="ninja">
			<xsl:with-param name="key" select="$key" />
		</xsl:apply-templates>
	</xsl:element>
</xsl:template>

<!-- Ninja attributes -->
<xsl:template match="//@*" mode="ninja">
	<xsl:attribute name="{name(.)}">
		<xsl:value-of select="."/>
	</xsl:attribute>
</xsl:template>

<!-- Override example 
<xsl:template match="//h2" mode="ninja" priority="1">
	<xsl:param name="key" />

	<xsl:element name="{name()}">
		<xsl:attribute name="id">
			<xsl:value-of select="concat($key, '-titre-', count(preceding-sibling::h2)+1)" />
		</xsl:attribute>
		<xsl:apply-templates select="* | @* | text()" mode="ninja" />
	</xsl:element>
</xsl:template>
-->

<xsl:template match="//i | //b | //br" mode="ninja-inline">
	<xsl:param name="key" />

	<xsl:apply-templates select="." mode="ninja">
		<xsl:with-param name="key" select="$key" />
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="//*" mode="ninja-inline">
	<xsl:param name="key" />

	<xsl:apply-templates select="* | @* | text()" mode="ninja">
		<xsl:with-param name="key" select="$key" />
	</xsl:apply-templates>
</xsl:template>

</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:exsl="http://exslt.org/common"
	xmlns:str="http://exslt.org/strings"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="*[name() != 'img']" mode="ninja-img">
		<xsl:element name="{name()}">
			<xsl:apply-templates select="* | @* | text()" mode="ninja-img" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="img" mode="ninja-img">
		<xsl:variable name="src" select="@src" />
		<xsl:variable name="is-gif" select="contains($src, '.gif')" />
		<xsl:variable name="is-svg" select="contains($src, '.svg')" />
		<xsl:variable name="is-local" select="contains($src, $root)" />
		<xsl:choose>
			<xsl:when test="$is-local and not($is-gif) and not($is-svg)">
				
				<xsl:variable name="new-path" select="substring-after($src, 'workspace/')" />

				<xsl:element name="{name()}">
					<xsl:apply-templates select="@*[not(name() = 'src')]" mode="ninja-img" />
					<xsl:attribute name="data-src-original"><xsl:value-of select="$src" /></xsl:attribute>
					<xsl:attribute name="src"><xsl:value-of select="$src" /></xsl:attribute>
					<xsl:attribute name="data-src-format">/image/4/$w/0/<xsl:value-of select="$new-path" /></xsl:attribute>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$root" />
				<xsl:copy-of select="." />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="text()" mode="ninja-img">
		<xsl:param name="lg" select="$url-language" />
		<xsl:call-template name="content">
			<xsl:with-param name="content" select="."/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="//@*" mode="ninja-img">
		<xsl:attribute name="{name(.)}">
			<xsl:value-of select="."/>
		</xsl:attribute>
	</xsl:template>

</xsl:stylesheet>
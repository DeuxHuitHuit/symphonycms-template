<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="meta-alt-link">
		<xsl:call-template name="meta-alt-link-default" />
	</xsl:template>

	<xsl:template name="meta-alt-link-default">
		<xsl:apply-templates select="/data/fl-languages/supported-languages/item[@handle != $url-language]" mode="meta-alt-link" />
	</xsl:template>

	<xsl:template match="fl-languages/supported-languages/item" mode="meta-alt-link">
		<xsl:param name="url">
			<xsl:call-template name="alt-link-url">
				<xsl:with-param name="lg" select="@handle" />
			</xsl:call-template>
		</xsl:param>
		<link rel="alternate" hreflang="{@handle}"  href="{$url}"/>
	</xsl:template>

	<xsl:template name="alt-link-url">
		<xsl:param name="page-id" select="$current-page-id" />
		<xsl:param name="lg" />
		<xsl:call-template name="create-page-url-by-id">
			<xsl:with-param name="id" select="$page-id" />
			<xsl:with-param name="lg" select="$lg" />
		</xsl:call-template>
		<xsl:call-template name="alt-link-url-extra">
			<xsl:with-param name="lg" select="$lg" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="alt-link-url-extra">
		<xsl:param name="lg" />
		<xsl:param name="extra" />
		<xsl:if test="string-length($extra) != 0 ">
			<xsl:value-of select="$extra" />
			<xsl:text>/</xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template name="page-alt-link-rss">
		<xsl:param name="page-id" />
		<xsl:param name="path">
			<xsl:call-template name="create-page-url-by-id">
				<xsl:with-param name="id" select="$page-id" />
			</xsl:call-template>
		</xsl:param>
		<link rel="alternate" href="{$root}{$path}" type="application/rss+xml" title="RSS 2.0"  />
	</xsl:template>

	<xsl:template name="page-metas-alt-rss"></xsl:template>
	
</xsl:stylesheet>

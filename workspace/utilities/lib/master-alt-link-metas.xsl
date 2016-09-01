<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Master Meta template -->
	<xsl:template name="page-metas-alt-link">
		<xsl:call-template name="default-page-metas-alt-link" />
	</xsl:template>

	<xsl:template name="default-page-metas-alt-link">
		<xsl:apply-templates select="/data/fl-languages/supported-languages/item[@handle != $url-language]" mode="meta-link" />
	</xsl:template>

<!-- Metas generator -->
	<xsl:template match="fl-languages/supported-languages/item" mode="meta-link">
		<xsl:variable name="page-url">
			<xsl:call-template name="page-alt-link-url">
				<xsl:with-param name="lg" select="@handle" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="page-title">
			<xsl:call-template name="page-alt-link-title">
				<xsl:with-param name="lg" select="@handle" />
			</xsl:call-template>
		</xsl:variable>
		
		<link title="{$page-title}"
			  rel="alternate"
			  hreflang="{@handle}" 
			  href="{$page-url}"/>
	</xsl:template>

<!-- page-alt-link generator -->
	<xsl:template name="page-alt-link-url">
		<xsl:param name="page-id" select="$current-page-id" />
		<xsl:param name="lg" />
		
		<xsl:call-template name="create-page-url-by-id" >
			<xsl:with-param name="id" select="$page-id" />
			<xsl:with-param name="lg" select="$lg" />
		</xsl:call-template>
		<xsl:call-template name="page-alt-link-url-extra">
			<xsl:with-param name="lg" select="$lg" />
		</xsl:call-template>
		
	</xsl:template>

	<xsl:template name="page-alt-link-url-extra">
		<xsl:param name="lg" />
	</xsl:template>

<!-- page-alt-link-title generator -->
	<xsl:template name="page-alt-link-title">
		<xsl:param name="lg" />

		<xsl:if test="count(/data/params/page-types/item[@handle = 'index']) = 0">
			<xsl:value-of select="/data/plh-page/page/item[@lang=$lg]" />
			<xsl:text> - </xsl:text>
		</xsl:if>
		<xsl:value-of select="$config/site-titre/item[@lang=$lg]" />
	</xsl:template>

<!-- page-alt-link-rss generator -->
	<xsl:template name="page-alt-link-rss">
		<xsl:param name="page-id" />
		
		<xsl:variable name="path">
			<xsl:call-template name="create-page-url-by-id">
				<xsl:with-param name="id" select="$page-id" />
			</xsl:call-template>
		</xsl:variable>
		
		<link rel="alternate" href="{$root}{$path}" type="application/rss+xml" title="RSS 2.0"  />
	</xsl:template>

	<xsl:template name="page-metas-alt-rss"></xsl:template>

</xsl:stylesheet>

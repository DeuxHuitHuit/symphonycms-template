<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exslt="http://exslt.org/common"
	exclude-result-prefixes="exslt">

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
		
		<link rel="alternate"
			  hreflang="{@handle}" 
			  href="{$page-url}"/>
	</xsl:template>

<!-- page-alt-link generator -->
	<xsl:template name="page-alt-link-url">
		<xsl:param name="page-id" select="$current-page-id" />
		<xsl:param name="lg" />
		
		<xsl:call-template name="create-page-url-by-id">
			<xsl:with-param name="id" select="$page-id" />
			<xsl:with-param name="lg" select="$lg" />
		</xsl:call-template>
		<xsl:call-template name="page-alt-link-url-extra">
			<xsl:with-param name="lg" select="$lg" />
		</xsl:call-template>
	</xsl:template>

<!-- page alt-link url extra generator -->
	<xsl:template name="page-alt-link-url-extra">
		<xsl:param name="lg" />
		<xsl:param name="entry" select="$page-meta-entry"/>

		<xsl:if test="exslt:object-type($entry) = 'node-set'">
			<xsl:variable name="extra-entry-handle">
				<xsl:call-template name="default-value">
					<xsl:with-param name="lg" select="$lg"/>
					<xsl:with-param name="a" select="$entry/url/item[@lang = $lg]/@handle" />
					<xsl:with-param name="b" select="$entry/url/item[@lang = $lg]" />
					<xsl:with-param name="c" select="$entry/url/@handle" />
					<xsl:with-param name="d" select="$entry/url" />

					<xsl:with-param name="e" select="$entry/titre/item[@lang = $lg]/@handle" />
					<xsl:with-param name="f" select="$entry/titre/item[@lang = $lg]" />
					<xsl:with-param name="g" select="$entry/titre/@handle" />
					<xsl:with-param name="h" select="$entry/titre" />

					<xsl:with-param name="i" select="$entry/title/item[@lang = $lg]/@handle" />
					<xsl:with-param name="j" select="$entry/title/item[@lang = $lg]" />
					<xsl:with-param name="k" select="$entry/title/@handle" />
					<xsl:with-param name="l" select="$entry/title" />

					<xsl:with-param name="m" select="$entry/nom/item[@lang = $lg]/@handle" />
					<xsl:with-param name="n" select="$entry/nom/item[@lang = $lg]" />
					<xsl:with-param name="o" select="$entry/nom/@handle" />
					<xsl:with-param name="p" select="$entry/nom" />

					<xsl:with-param name="q" select="$entry/name/item[@lang = $lg]/@handle" />
					<xsl:with-param name="r" select="$entry/name/item[@lang = $lg]" />
					<xsl:with-param name="s" select="$entry/name/@handle" />
					<xsl:with-param name="t" select="$entry/name" />
				</xsl:call-template>
			</xsl:variable>

			<xsl:if test="string-length($extra-entry-handle) != 0 ">
				<xsl:value-of select="$extra-entry-handle" />
				<xsl:text>/</xsl:text>
			</xsl:if>
		</xsl:if>
	</xsl:template>

<!-- page-alt-link-title generator -->
	<xsl:template name="page-alt-link-title">
		<xsl:param name="lg" />

		<xsl:call-template name="master-title" >
			<xsl:with-param name="lg" select="$lg" />
		</xsl:call-template>
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

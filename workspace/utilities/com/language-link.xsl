<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="site-lang-links">
	<xsl:param name="include-current-language" select="false()"/>
	<xsl:param name="use-short-content" select="true()" />
	<xsl:param name="attr" />

	<xsl:if test="$include-current-language = false()">
		<xsl:apply-templates select="/data/fl-languages/supported-languages/item[@handle != $url-language]" mode="revert-language" >
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="use-short-content" select="$use-short-content" />
		</xsl:apply-templates>
	</xsl:if>

	<xsl:if test="$include-current-language = true()">
		<xsl:apply-templates select="/data/fl-languages/supported-languages/item" mode="revert-language" >
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="use-short-content" select="$use-short-content" />
		</xsl:apply-templates>
	</xsl:if>

</xsl:template>

<xsl:template match="fl-languages/supported-languages/item" mode="revert-language" >
	<xsl:param name="use-short-content" select="true()" />
	<xsl:param name="content" >
		<xsl:if test="$use-short-content = true()">
			<xsl:value-of select="substring(.,1,2)" />
		</xsl:if>
		<xsl:if test="$use-short-content = false()">
			<xsl:value-of select="." />
		</xsl:if>
	</xsl:param>
	<xsl:param name="attr" />

	<xsl:variable name="computed-attr">
		<add data-lg="{@handle}" />
		<add data-action="full" />
		<add class="js-alt-lg-link" />
		<xsl:copy-of select="$attr" />
	</xsl:variable>

	<xsl:variable name="computed-url">
		<xsl:call-template name="page-alt-link-url">
			<xsl:with-param name="lg" select="@handle" />
		</xsl:call-template>
	</xsl:variable>

	<xsl:call-template name="button">
		<xsl:with-param name="url" select="$computed-url" />
		<xsl:with-param name="content" select="$content" />
		<xsl:with-param name="attr" select="$computed-attr" />
	</xsl:call-template>

</xsl:template>

</xsl:stylesheet>
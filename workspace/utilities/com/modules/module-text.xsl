<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: module-text -->
	<xsl:template name="module-text" match="item[@section = 'module-text']" mode="module">
		<xsl:param name="text" select="text" />
		<xsl:param name="computed-text">
			<xsl:call-template name="util-rewrite-markdown">
				<xsl:with-param name="text" select="$text"/>
			</xsl:call-template>
		</xsl:param>
		<xsl:param name="ext-attr" />

		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="module-text" />
		</xsl:variable>

		<xsl:variable name="attr-ctn">
			<xsl:copy-of select="$recipe-markdown-normal" />
			<add dev-extended-by="module-text" />
		</xsl:variable>

		<!-- STRUCTURE -->
		<xsl:call-template name="module">
			<xsl:with-param name="ext-attr" select="$attr" />
			<xsl:with-param name="ext-attr-ctn" select="$attr-ctn" />
			<xsl:with-param name="transition-name" select="'transition-module-text'" />
			<xsl:with-param name="content" select="$computed-text" />
		</xsl:call-template>

	</xsl:template>
</xsl:stylesheet>

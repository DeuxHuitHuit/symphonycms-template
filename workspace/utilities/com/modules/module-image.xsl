<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: module-image -->
	<xsl:template name="module-image" match="item[@section = 'module-image']" mode="module">
		<xsl:param name="image" select="image" />
		<xsl:param name="alt" select="alt" />
		<xsl:param name="caption" select="caption" />
		<xsl:param name="ext-attr" />

		<xsl:variable name="has-caption" select="string-length($caption) != 0" />

		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="module-image" />
		</xsl:variable>

		<xsl:variable name="attr-ctn">
			<add dev-extended-by="module-image" />
		</xsl:variable>

		<xsl:variable name="attr-image">
			<add dev-element="image" />
		</xsl:variable>

		<xsl:variable name="attr-caption">
			<add dev-element="caption" />
		</xsl:variable>

		<!-- STRUCTURE -->
		<xsl:call-template name="module">
			<xsl:with-param name="ext-attr" select="$attr" />
			<xsl:with-param name="ext-attr-ctn" select="$attr-ctn" />
			<xsl:with-param name="transition-name" select="'transition-module-image'" />
			<xsl:with-param name="content">
				<!-- Picture -->
				<xsl:call-template name="picture">
					<xsl:with-param name="image" select="$image" />
					<xsl:with-param name="alt" select="$alt" />
				</xsl:call-template>
				<!-- Caption -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-caption" />
					<xsl:with-param name="content" select="$caption" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>

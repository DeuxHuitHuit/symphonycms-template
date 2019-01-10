<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: util-nav-link-attr -->
	<xsl:template name="util-nav-link-attr">
		<xsl:param name="label" select="label" />
		<xsl:param name="ga-cat" select="'menu-nav'" />
		<xsl:param name="ga-label" select="concat($url-language, '/', $label)" />
		<xsl:param name="role" select="'menuitem'" />
		<xsl:param name="target" select="'_self'" />
		<xsl:param name="ext-attr" />

		<xsl:variable name="has-ga-cat" select="string-length($ga-cat) != 0" />
		<xsl:variable name="has-ga-label" select="string-length($ga-label) != 0" />
		<xsl:variable name="has-role" select="string-length($role) != 0" />
		<xsl:variable name="has-target" select="string-length($target) != 0" />

		<xsl:if test="$has-ga-cat">
			<add data-ga-cat="{$ga-cat}" />
		</xsl:if>
		<xsl:if test="$has-ga-label">
			<add data-ga-label="{$ga-label}" />
		</xsl:if>
		<xsl:if test="$has-role">
			<add role="{$role}" />
		</xsl:if>
		<xsl:if test="$has-target">
			<add target="{$target}" />
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: util-nav-link-attr -->
	<xsl:template name="util-nav-link-attr">
		<xsl:param name="label" select="label" />
		<xsl:param name="url" select="url" />
		<xsl:param name="ga-cat" select="'menu-nav'" />
		<xsl:param name="ga-label" select="concat($url-language, '/', $label)" />
		<xsl:param name="ga-action" select="''" />
		<xsl:param name="role" select="'menuitem'" />
		<xsl:param name="target">
			<xsl:choose>
				<xsl:when test="starts-with($url, 'http://') or starts-with($url, 'https://')">
					<xsl:text>_blank</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>_self</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>

		<xsl:variable name="has-ga-cat" select="string-length($ga-cat) != 0" />
		<xsl:variable name="has-ga-label" select="string-length($ga-label) != 0" />
		<xsl:variable name="has-ga-action" select="string-length($ga-action) != 0" />
		<xsl:variable name="has-role" select="string-length($role) != 0" />
		<xsl:variable name="has-target" select="string-length($target) != 0" />

		<xsl:if test="$has-ga-cat">
			<set data-ga-cat="{$ga-cat}" />
		</xsl:if>
		<xsl:if test="$has-ga-label">
			<set data-ga-label="{$ga-label}" />
		</xsl:if>
		<xsl:if test="$has-ga-action">
			<set data-ga-action="{$ga-action}" />
		</xsl:if>
		<xsl:if test="$has-role">
			<set role="{$role}" />
		</xsl:if>
		<xsl:if test="$has-target">
			<set target="{$target}" />
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>

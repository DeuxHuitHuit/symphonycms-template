<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: util-transition-scroll-attr -->
	<xsl:template name="util-transition-scroll-attr">
		<xsl:param name="name" />
		<xsl:param name="state" select="'visible'" />
		<xsl:param name="screen-offset" select="'1'" />

		<xsl:variable name="has-name" select="string-length($name) != 0" />

		<xsl:if test="$has-name">
			<add class="{$name}" />
			<add class="js-auto-toggle-class-on-scroll" />
			<add data-toggle-class-on-scroll-add-after="is-{$state}" />
			<add data-toggle-class-on-scroll-rem-before="is-{$state}" />
			<add data-toggle-class-on-scroll-screen-offset="{$screen-offset}" />
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:util="https://github.com/DeuxHuitHuit/288-utils"
	extension-element-prefixes="util">

<!-- COMPONENT: site-logo -->
	<xsl:template name="site-logo">
		<xsl:param name="url" select="$page-index-url" />
		<xsl:param name="logo">
			<!-- <xsl:call-template name="logo-site" /> -->
		</xsl:param>
		<xsl:param name="site-title">
			<xsl:call-template name="site-title-default" />
		</xsl:param>
		<xsl:param name="ext-attr" />

		<xsl:variable name="has-logo" select="util:count($logo) &gt; 0" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<add role="menuitem" />
			<add data-ga-cat="menu-nav" />
			<add data-ga-label="logo" />
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="site-logo" />
		</xsl:variable>

		<xsl:variable name="attr-title">
			<xsl:if test="$has-logo">
				<add class="display-none" />
			</xsl:if>
			<add dev-element="title" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="button">
			<xsl:with-param name="url" select="$url" />
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- Logo -->
				<xsl:copy-of select="$logo" />
				<!-- Title -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-title" />
					<xsl:with-param name="element" select="'span'" />
					<xsl:with-param name="content" select="$site-title" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>

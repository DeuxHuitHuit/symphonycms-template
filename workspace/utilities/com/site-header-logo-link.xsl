<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: site-header-logo-link ===========================================================-->
	<xsl:template name="site-header-logo-link">
		<xsl:param name="url" select="$page-index-url"/>
		<xsl:param name="attr" />
		<xsl:param name="site-name" select="$site-name" />
		<xsl:param name="site-name-attr" />
		<xsl:param name="content" />
		
	<!-- DEFAULT STYLES ____________________________________________________ -->
		<!-- self -->
		<xsl:variable name="site-header-logo-link-style">
			
		</xsl:variable>

		<xsl:variable name="site-name-style">
			<add class="display-none" />
		</xsl:variable>
	<!-- ___________________________________________________________________/-->

	<!-- COMPUTED ATTRIBUTES 												 -->
		<xsl:variable name="computed-attr">
			<add role="menuitem" />

			<xsl:copy-of select="$site-header-logo-link-style" />
			<xsl:copy-of select="$attr" />

			<add dev-component="site-header-logo-link" />
			
			<add data-ga-cat="menu-nav" data-ga-label="logo" />
		</xsl:variable>

		<xsl:variable name="computed-site-name-attr">
			<xsl:copy-of select="$site-name-style" />
			<xsl:copy-of select="$site-name-attr" />
			<add dev-element="site-name" />
		</xsl:variable>
	<!--																	/-->

	<!-- STRUCTURE 															 -->
		<!-- Self -->
		<xsl:call-template name="button">
			<xsl:with-param name="attr" select="$computed-attr" />
			<xsl:with-param name="url" select="$url" />
			<xsl:with-param name="content">
				<!-- Content -->
				<xsl:call-template name="content">
					<xsl:with-param name="content" select="$content"/>
				</xsl:call-template>

				<!-- site name span -->
				<xsl:call-template name="element">
					<xsl:with-param name="element" select="'span'" />
					<xsl:with-param name="attr" select="$computed-site-name-attr" />
					<xsl:with-param name="content" select="$site-name"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	<!--																	/-->
	</xsl:template>
</xsl:stylesheet>

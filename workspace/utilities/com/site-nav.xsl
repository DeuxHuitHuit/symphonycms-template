<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: site-nav ========================================================================-->
	<xsl:template name="site-nav">
		<xsl:param name="attr" />
		<xsl:param name="nav-link-ctn-attr" />
		<xsl:param name="nav-link-attr" />
		<xsl:param name="nav-link-selected-attr" />

	<!-- DEFAULT STYLES _____________________________________________________-->
		<xsl:variable name="site-nav-style">
		</xsl:variable>

		<xsl:variable name="nav-link-ctn-style">
		</xsl:variable>

		<xsl:variable name="nav-link-style">
		</xsl:variable>

		<xsl:variable name="nav-link-selected-style">
		</xsl:variable>
	<!--____________________________________________________________________/-->

	<!-- STRUCTURE DIAGRAMS 												   >
		|- SELF : <nav> site-nav
		|		:-(RPT) : site-nav-links (menu/entry)
		|		:		|- nav-link-ctn
		|		:		|		|- CORE : nav-link
																			/-->

	<!-- COMPUTED ATTRIBUTES 												 -->
		<xsl:variable name="computed-attr">
			<add role="menu" />
			<xsl:copy-of select="$site-nav-style" />
			<xsl:copy-of select="$attr" />
			<add dev-component="site-nav" />
		</xsl:variable>

		<xsl:variable name="computed-nav-link-ctn-attr">
			<xsl:copy-of select="$nav-link-ctn-style" />
			<xsl:copy-of select="$nav-link-ctn-attr" />
			<add dev-element="nav-link-ctn" />
		</xsl:variable>

		<xsl:variable name="computed-nav-link-attr">
			<xsl:copy-of select="$nav-link-style" />
			<xsl:copy-of select="$nav-link-attr" />
			<add dev-element="nav-link" />
		</xsl:variable>

		<xsl:variable name="computed-nav-link-selected-attr">
			<xsl:copy-of select="$nav-link-selected-style" />
			<xsl:copy-of select="$nav-link-selected-attr" />
		</xsl:variable>
	<!--																	/-->

	<!-- STRUCTURE															 -->
		<!-- self: <nav> -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="'nav'"/>
			<xsl:with-param name="attr" select="$computed-attr" />
			<xsl:with-param name="content">

				<!-- REPEAT: site-nav-links -->
				<xsl:apply-templates select="/data/menu/entry" mode="site-nav-links">
					<xsl:with-param name="attr" select="$computed-nav-link-ctn-attr" />
					<xsl:with-param name="nav-link-attr" select="$computed-nav-link-attr" />
					<xsl:with-param name="nav-link-selected-attr" select="$computed-nav-link-selected-attr" />
				</xsl:apply-templates>
			</xsl:with-param>
		</xsl:call-template>
	<!--																	/-->
	</xsl:template>

<!-- REPEAT TEMPLATE : site-nav-links (menu/entry) ==============================================-->
	<xsl:template match="menu/entry" mode="site-nav-links">
		<xsl:param name="attr" />
		<xsl:param name="nav-link-attr" />
		<xsl:param name="nav-link-selected-attr" />

	<!-- STRUCTURE															 -->
		<!-- self: nav-link-ctn -->
		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">

				<!-- nav-link (COMP: nav-link) -->
				<xsl:call-template name="nav-link">
					<xsl:with-param name="attr" select="$nav-link-attr"/>
					<xsl:with-param name="selected-attr" select="$nav-link-selected-attr" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	<!--																	/-->
	</xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: site-header -->
	<xsl:template name="site-header">
		<xsl:param name="main-menu" select="$menus/main" />
		<xsl:param name="ext-attr" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<add class="flexbox" />
			<add class="padding-vertical-broad" />
			<add class="padding-horizontal-security" />
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="site-header" />
		</xsl:variable>

		<xsl:variable name="attr-logo-ctn">
			<add class="flex-grow-1" />
			<add dev-element="logo-ctn" />
		</xsl:variable>

		<xsl:variable name="attr-nav-ctn">
			<add dev-element="nav-ctn" />
		</xsl:variable>

		<xsl:variable name="attr-lang-ctn">
			<add dev-element="lang-ctn" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="'header'" />
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- Logo ctn -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-logo-ctn" />
					<xsl:with-param name="content">
						<!-- Site Logo -->
						<xsl:call-template name="site-logo" />
					</xsl:with-param>
				</xsl:call-template>
				<!-- Nav ctn -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-nav-ctn" />
					<xsl:with-param name="content">
						<!-- Site Nav -->
						<xsl:call-template name="site-nav" />
					</xsl:with-param>
				</xsl:call-template>
				<!-- Lang ctn -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-lang-ctn" />
					<xsl:with-param name="content">
						<!-- Lang -->
						<!-- <xsl:call-template name="site-lang" /> -->
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>

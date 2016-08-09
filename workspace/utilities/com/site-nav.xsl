<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../lib/nav-link.xsl" />

<xsl:template name="site-nav">
	<xsl:param name="attr" />
	<xsl:param name="link-ctn-attr" />
	<xsl:param name="link-attr" />

	<xsl:variable name="computed-attr">
		<add id="site-nav" />
		<add class="js-site-nav-link-ctn" />
		<add role="menu" />

		<xsl:copy-of select="$attr" />
	</xsl:variable>

	<xsl:variable name="computed-link-ctn-attr">
		<xsl:copy-of select="$link-ctn-attr" />
	</xsl:variable>

	<xsl:variable name="computed-link-attr">
		<xsl:copy-of select="$link-attr" />
	</xsl:variable>

	<nav>
		<xsl:call-template name="attr">
			<xsl:with-param name="attr" select="$computed-attr" />
		</xsl:call-template>

		<xsl:apply-templates select="/data/menu/entry" mode="site-nav">
			<xsl:with-param name="attr" select="$computed-link-ctn-attr" />
			<xsl:with-param name="link-attr" select="$computed-link-attr" />
		</xsl:apply-templates>
	</nav>

</xsl:template>

<xsl:template match="menu/entry" mode="site-nav">
	<xsl:param name="attr" />
	<xsl:param name="link-attr" />

	<div>
		<xsl:call-template name="attr" >
			<xsl:with-param name="attr" select="$attr" />
		</xsl:call-template>

		<xsl:call-template name="nav-link">
			<!--xsl:param name="content" select="titre" /-->
			<!--xsl:param name="page" select="page/page" /-->
			<!--xsl:param name="page-extra-url" select="''" /-->
			<!--xsl:param name="selected-on-sub-page" select="true()" /-->
			<!--xsl:param name="failover-element" select="'button'" /-->
			<!--xsl:param name="url" select="url" /-->
			<xsl:with-param name="attr" select="$link-attr"/>
		</xsl:call-template>
	</div>
</xsl:template>

</xsl:stylesheet>
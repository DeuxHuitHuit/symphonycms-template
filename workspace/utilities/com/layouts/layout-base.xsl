<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: layout-base -->
	<xsl:template name="layout-base" match="entry" mode="layout-base">
		<xsl:param name="header">
			<!-- <xsl:call-template name="header-base" /> -->
		</xsl:param>
		<xsl:param name="content-before" />
		<xsl:param name="modules" select="modules/item" />
		<xsl:param name="content-after" />
		<xsl:param name="show-share" select="true()" />
		<xsl:param name="ext-attr" />
		<xsl:param name="ext-attr-article" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<add class="relative" />
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="layout-base" />
		</xsl:variable>

		<xsl:variable name="attr-article">
			<xsl:copy-of select="$ext-attr-article" />
			<add dev-extended-by="layout-base" />
		</xsl:variable>

		<xsl:variable name="attr-share">
			<add class="padding-horizontal-security" />
			<add class="max-width-tiniest margin-horizontal-auto" />
			<xsl:copy-of select="$recipe-interval-module" />
			<add dev-element="share" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="layout">
			<xsl:with-param name="ext-attr" select="$attr" />
			<xsl:with-param name="ext-attr-article" select="$attr-article" />
			<xsl:with-param name="content">
				<!-- Header -->
				<xsl:copy-of select="$header" />
				<!-- Content: before -->
				<xsl:copy-of select="$content-before" />
				<!-- Modules -->
				<xsl:apply-templates select="$modules" mode="module" />
				<!-- Content: after -->
				<xsl:copy-of select="$content-after" />
				<xsl:if test="$show-share">
					<xsl:call-template name="nav-share">
						<xsl:with-param name="ext-attr" select="$attr-share" />
					</xsl:call-template>
				</xsl:if>
			</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>

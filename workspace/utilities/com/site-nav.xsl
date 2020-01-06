<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: site-nav -->
	<xsl:template name="site-nav">
		<xsl:param name="items" select="$menus/main/item" />
		<xsl:param name="ext-attr" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<add class="flexbox" />
			<xsl:copy-of select="$recipe-gutter-h-button" />
			<xsl:copy-of select="$recipe-gutter-h-button" />
			<add role="menu" />
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="site-nav" />
		</xsl:variable>

		<xsl:variable name="attr-item">
			<xsl:copy-of select="$recipe-gutter-h-button-item" />
			<xsl:copy-of select="$recipe-gutter-h-button-item" />
			<add dev-element="item" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="'nav'" />
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<xsl:apply-templates select="$items" mode="site-nav-item">
					<xsl:with-param name="ext-attr" select="$attr-item" />
				</xsl:apply-templates>
			</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>

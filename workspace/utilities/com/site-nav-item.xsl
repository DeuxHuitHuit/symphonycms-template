<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: site-nav-item -->
	<xsl:template name="site-nav-item" match="item" mode="site-nav-item">
		<xsl:param name="label" select="label" />
		<xsl:param name="url">
			<xsl:call-template name="util-auto-url" />
		</xsl:param>
		<xsl:param name="ext-attr" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="site-nav-item" />
		</xsl:variable>

		<xsl:variable name="attr-button">
			<xsl:call-template name="util-nav-link-attr" />
			<add dev-element="button" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- BUTTON: link -->
				<xsl:call-template name="button-link">
					<xsl:with-param name="url" select="$url" />
					<xsl:with-param name="attr" select="$attr-button" />
					<xsl:with-param name="content" select="$label" />
				</xsl:call-template>
			</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>

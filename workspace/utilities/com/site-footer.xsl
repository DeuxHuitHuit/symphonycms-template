<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: site-footer =====================================================================-->
	<xsl:template name="site-footer">
		<xsl:param name="attr" />

	<!-- DEFAULT STYLES _____________________________________________________-->
		<xsl:variable name="site-footer-style"></xsl:variable>
	<!--____________________________________________________________________/-->

	<!-- COMPUTED ATTRIBUTES 												 -->
		<xsl:variable name="computed-attr">
			<xsl:copy-of select="$site-footer-style" />
			<xsl:copy-of select="$attr" />
			<add dev-component="site-footer" />
		</xsl:variable>
	<!--																	/-->

	<!-- STRUCTURE															 -->
		<!-- <footer> : self -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="'footer'"/>
			<xsl:with-param name="attr" select="$computed-attr" />
			<xsl:with-param name="content">
				
				<!-- iframe-288 -->
				<xsl:call-template name="iframe-copyright-288" />
			</xsl:with-param>
		</xsl:call-template>
	<!--																	/-->
	</xsl:template>
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: site-footer =====================================================================-->
	<xsl:template name="site-footer">
		<xsl:param name="attr" />

	<!-- DEFAULT STYLES _____________________________________________________-->
		<xsl:variable name="site-footer-style">
			
		</xsl:variable>
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
				<xsl:call-template name="iframe-copyright-288">
					<!--
					<xsl:with-param name="bg-color" select="'transparent'" />
					<xsl:with-param name="text-color" select="'fff'" />
					<xsl:with-param name="logo-color" select="'fff'" />
					<xsl:with-param name="font" select="'Arial, Helvetica, sans-serif'" />
					<xsl:with-param name="font-size" select="'12'" />
					<xsl:with-param name="w" select="'125'" />
					<xsl:with-param name="h" select="'28'" />
					<xsl:with-param name="word" select="'Website'" />
					<xsl:with-param name="text-transform" select="'none'" />
					<xsl:with-param name="display" select="'inline'" />
					<xsl:with-param name="t-align" select="'left'" />
					<xsl:with-param name="l-height" select="'0'" />
					<xsl:with-param name="logo-align" select="'left'" />
					-->
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	<!--																	/-->
	</xsl:template>

</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- CORE-ELEMENT: text =========================================================================-->
	<xsl:template name="text">
		<!-- element params -->
		<xsl:param name="element" select="'div'" />
		<xsl:param name="is-optional" select="false()" />
		<!-- attr params -->
		<xsl:param name="attr" />
		<xsl:param name="attr-mode" />
		<!-- content params -->
		<xsl:param name="lg" select="$url-language" />
		<xsl:param name="content" />

	<!-- STRUCTURE															 -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="$element" />
			<xsl:with-param name="is-optional" select="$is-optional" />
			<xsl:with-param name="attr" select="$attr"/>
			<xsl:with-param name="attr-mode" select="$attr-mode" />
			<xsl:with-param name="lg" select="$lg" />
			<xsl:with-param name="content" select="$content" />
		</xsl:call-template>
	<!--																	/-->
	</xsl:template>

<!-- CORE-ELEMENT: optional-text ================================================================-->
	<xsl:template name="optional-text">
		<!-- element params -->
		<xsl:param name="element" select="'div'" />
		<!-- attr params -->
		<xsl:param name="attr" />
		<xsl:param name="attr-mode" />
		<!-- content params -->
		<xsl:param name="lg" select="$url-language" />
		<xsl:param name="content" />
		
	<!-- STRUCTURE															 -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="$element" />
			<xsl:with-param name="is-optional" select="true()" />
			<xsl:with-param name="attr" select="$attr"/>
			<xsl:with-param name="attr-mode" select="$attr-mode" />
			<xsl:with-param name="lg" select="$lg" />
			<xsl:with-param name="content" select="$content" />
		</xsl:call-template>
	<!--																	/-->
	</xsl:template>
</xsl:stylesheet>

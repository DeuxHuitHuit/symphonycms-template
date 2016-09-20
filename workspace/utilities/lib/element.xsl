<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- CORE-ELEMENT: element ======================================================================-->
	<xsl:template name="element">
		<xsl:param name="element" select="'div'" />
		<xsl:param name="is-optional" select="false()" />
		<!-- attr -->
		<xsl:param name="attr" />
		<xsl:param name="attr-mode" select="$default-attr-mode"/>
		<!-- content -->
		<xsl:param name="lg" select="$url-language" />
		<xsl:param name="content" />

	<!-- COMPUTED OPTIONAL FLAG 											 -->
		<xsl:variable name="has-content">
			<xsl:if test="string-length($content) != 0">
				<xsl:text>yes</xsl:text>
			</xsl:if>
			<!-- 
				TODO: @Paco
				Continue to check for case were we have only img or
				other case without direct text 
			-->
		</xsl:variable>
	<!--																	/-->

	<!-- STRUCTURE 															 -->
		<xsl:if test="$is-optional = false() or string-length($has-content) != 0">
			<!-- element -->
			<xsl:element name="{$element}">
				<xsl:call-template name="attr">
					<xsl:with-param name="attr" select="$attr"/>
					<xsl:with-param name="attr-mode" select="$attr-mode" />
				</xsl:call-template>

				<xsl:call-template name="content">
					<xsl:with-param name="content" select="$content" />
					<xsl:with-param name="lg" select="$lg" />
				</xsl:call-template>
			</xsl:element>
		</xsl:if>
	<!--																	/-->
	</xsl:template>

<!-- CORE-ELEMENT: optional-element =============================================================-->
	<xsl:template name="optional-element">
		<xsl:param name="element" select="'div'" />
		<!-- attr -->
		<xsl:param name="attr" />
		<xsl:param name="attr-mode" select="$default-attr-mode"/>
		<!-- content -->
		<xsl:param name="lg" select="$url-language" />
		<xsl:param name="content" />

	<!-- STRUCTURE 															 -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="$element"/>
			<xsl:with-param name="is-optional" select="true()" />
			<xsl:with-param name="attr" select="$attr"/>
			<xsl:with-param name="attr-mode" select="$attr-mode" />
			<xsl:with-param name="lg" select="$lg" />
			<xsl:with-param name="content" select="$content"/>
		</xsl:call-template>
	<!--																	/-->
	</xsl:template>
</xsl:stylesheet>
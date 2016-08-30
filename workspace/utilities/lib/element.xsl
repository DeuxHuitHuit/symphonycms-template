<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="optional-element">
	<xsl:param name="content" />
	<xsl:param name="element" select="'div'" />
	<xsl:param name="attr" />
	<xsl:param name="attr-mode" />

	<!-- Detect content -->
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



	<!-- Structure -->
	<xsl:if test="string-length($has-content) != 0">
		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr"/>
			<xsl:with-param name="element" select="$element"/>
			<xsl:with-param name="content" select="$content"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<!-- COMPONENT SITE-NAV =====================================================/-->
	<xsl:template name="element">
		<xsl:param name="element" select="'div'" />
		<xsl:param name="attr" />
		<xsl:param name="attr-mode" />
		<xsl:param name="content" />

		<!-- STRUCTURE  - - - - - - - - - - - - - - - - -  - - - - - - - - - - - /-->
		<xsl:element name="{$element}">
			<xsl:call-template name="attr">
				<xsl:with-param name="attr" select="$attr"/>
				<xsl:with-param name="mode" select="$attr-mode" />
			</xsl:call-template>

			<xsl:call-template name="content" >
				<xsl:with-param name="content" select="$content" />
			</xsl:call-template>
		</xsl:element>
	</xsl:template>

</xsl:stylesheet>
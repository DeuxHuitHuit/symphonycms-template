<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: site-credits -->
	<xsl:template name="site-credits">
		<xsl:param name="text">
			<xsl:choose>
				<xsl:when test="$url-language = 'fr'">
					<xsl:text>Crédits</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>Credits</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:param name="ext-attr" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<add class="flex-shrink-0 overflow-hidden" />
			<add class="relative cursor-pointer" />
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="site-credits" />
		</xsl:variable>

		<xsl:variable name="attr-text">
			<add class="absolute fill z-index-1" />
			<add class="flexbox align-items-center justify-content-center" />
			<add dev-element="text" />
		</xsl:variable>

		<xsl:variable name="attr-logo">
			<add class="relative z-index-4" />
			<add dev-element="logo" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- Text -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-text" />
					<xsl:with-param name="element" select="'span'" />
					<xsl:with-param name="content" select="$text" />
				</xsl:call-template>
				<!-- Logo -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-logo" />
					<xsl:with-param name="content">
						<!-- COMP: iframe-copyright-288 -->
						<xsl:call-template name="iframe-copyright-288">
							<xsl:with-param name="word" select="''" />
							<xsl:with-param name="logo-always-animated" select="'true'" />
							<xsl:with-param name="display" select="'block'" />
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>

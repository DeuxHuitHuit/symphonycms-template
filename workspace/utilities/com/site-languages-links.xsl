<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: site-languages-links ============================================================-->
	<xsl:template name="site-languages-links">
		<xsl:param name="include-current-language" select="false()"/>
		<!--
			 Can be normal, abreviation or any other string 
			 When a unknown format is requested. 
				the template site-languages-link-custom-text-strategy is called
				with the param :
					 entry:          current language node
					 text-strategy:  requested text-strategy
		-->
		<xsl:param name="text-strategy" select="'normal'" />
		<!-- button params -->
		<xsl:param name="failover-element" select="$default-button-failover-element" />
		<!-- attr params -->
		<xsl:param name="attr" />

	<!-- STRUCTURE															 -->
		<xsl:choose>
			<xsl:when test="$include-current-language = false()">
				<xsl:apply-templates select="/data/fl-languages/supported-languages/item[@handle != $url-language]" mode="site-languages-link">
					<xsl:with-param name="attr" select="$attr" />
					<xsl:with-param name="text-strategy" select="$text-strategy" />
				</xsl:apply-templates>
			</xsl:when>

			<xsl:when test="$include-current-language = true()">
				<xsl:apply-templates select="/data/fl-languages/supported-languages/item" mode="site-languages-link">
					<xsl:with-param name="attr" select="$attr" />
					<xsl:with-param name="text-strategy" select="$text-strategy" />
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:message>
					<xsl:text>Error when calling site-languages-links: Params : 'include-current-language' must be true() or false() </xsl:text>
				</xsl:message>
			</xsl:otherwise>
		</xsl:choose>
	<!--																	/-->
	</xsl:template>

<!-- REPEAT TEMPLATE : site-languages-link (fl-languages/supported-languages/item) ==============-->
	<xsl:template match="fl-languages/supported-languages/item" mode="site-languages-link">
		<xsl:param name="text-strategy" select="'normal'" />
		<!-- button params -->
		<xsl:param name="failover-element" select="$default-button-failover-element" />
		<!-- attr params -->
		<xsl:param name="attr" />
		<!-- content params -->
		<xsl:param name="content-lg" select="$url-language" />
		<xsl:param name="content">
			<xsl:choose>
				<xsl:when test="string-length($text-strategy) = 0 or $text-strategy = 'normal'">
					<xsl:value-of select="." />
				</xsl:when>
				<xsl:when test="$text-strategy = 'abreviation'">
					<xsl:value-of select="substring(.,1,2)" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="site-languages-link-custom-text-strategy">
						<xsl:with-param name="text-strategy" select="$text-strategy" />
						<xsl:with-param name="entry" select="."/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		
	<!-- COMPUTED VALUES 													 -->
		<xsl:variable name="computed-url">
			<xsl:call-template name="alt-link-url">
				<xsl:with-param name="lg" select="@handle" />
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="computed-attr">
			<add data-ga-cat="menu-nav" data-ga-label="{.}" />
			<xsl:copy-of select="$attr" />
		</xsl:variable>
	<!--																	/-->

	<!-- STRUCTURE															 -->
		<xsl:call-template name="revert-language-link">
			<xsl:with-param name="revert-lg-handle" select="@handle" />
			<xsl:with-param name="url" select="$computed-url" />
			<xsl:with-param name="failover-element" select="$failover-element" />
			<xsl:with-param name="is-optional" select="false()" />
			<xsl:with-param name="attr" select="$computed-attr" />
			<xsl:with-param name="content-lg" select="$content-lg" />
			<xsl:with-param name="content" select="$content" />
		</xsl:call-template>
	<!--																	/-->
	</xsl:template>
</xsl:stylesheet>

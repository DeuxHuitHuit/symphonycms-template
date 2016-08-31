<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- CORE-ELEMENT: button =======================================================================-->
	<xsl:template name="button">
		<xsl:param name="url" select="''" />
		<xsl:param name="failover-element" select="'button'" />
		<!-- element params -->
		<xsl:param name="is-optional" select="false()" />
		<!-- attr params -->
		<xsl:param name="attr" />
		<xsl:param name="attr-mode" select="''" />
		<!-- content params -->
		<xsl:param name="lg" select="$url-language" />
		<xsl:param name="content" />
		
	<!-- COMPUTED VALUES 													 -->
		<xsl:variable name="computed-element">
			<xsl:choose>
				<xsl:when test="string-length($url) != 0">
					<xsl:text>a</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$failover-element" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
	<!--																	/-->

	<!-- COMPUTED ATTRIBUTES 												 -->
		<xsl:variable name="computed-attr">
			<xsl:if test="string-length($url) != 0">
				<set href="{$url}" />
			</xsl:if>
			<xsl:copy-of select="$attr" />
			<add dev-core="button" />
		</xsl:variable>
	<!--																	/-->

	<!-- STRUCTURE															 -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="$computed-element"/>
			<xsl:with-param name="is-optional" select="$is-optional" />
			<xsl:with-param name="attr" select="$computed-attr"/>
			<xsl:with-param name="attr-mode" select="$attr-mode" />
			<xsl:with-param name="lg" select="$lg" />
			<xsl:with-param name="content" select="$content" />
		</xsl:call-template>
	<!--																	/-->
	</xsl:template>

<!-- CORE-ELEMENT: optional-button ==============================================================-->
	<xsl:template name="optional-button">
		<xsl:param name="url" select="''" />
		<xsl:param name="failover-element" select="'button'" />
		<!-- attr params -->
		<xsl:param name="attr" />
		<xsl:param name="attr-mode" select="''" />
		<!-- content params -->
		<xsl:param name="lg" select="$url-language" />
		<xsl:param name="content" />

	<!-- STRUCTURE															 -->
		<xsl:call-template name="button">
			<xsl:with-param name="url" select="$url" />
			<xsl:with-param name="failover-element" select="$failover-element" />
			<xsl:with-param name="is-optional" select="true()" />
			<xsl:with-param name="attr" select="$attr"/>
			<xsl:with-param name="attr-mode" select="$attr-mode" />
			<xsl:with-param name="lg" select="$lg" />
			<xsl:with-param name="content" select="$content" />
		</xsl:call-template>
	<!--																	/-->
	</xsl:template>

</xsl:stylesheet>
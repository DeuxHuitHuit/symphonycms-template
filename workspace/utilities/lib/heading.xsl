<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- CORE-ELEMENT: heading ======================================================================-->
	<xsl:template name="heading">
		<xsl:param name="level" select="'1'"/>
		<!-- element params -->
		<xsl:param name="is-optional" select="false()" />
		<!-- attr params -->
		<xsl:param name="attr" />
		<xsl:param name="attr-mode" select="''" />
		<!-- content params -->
		<xsl:param name="lg" select="$url-language" />
		<xsl:param name="content" />
		
	<!-- VALIDATION 														 -->
		<xsl:if test="number($level) &lt; 1 or number($level) &gt; 6">
			<xsl:message>
				<xsl:text>$level must be a integer between 1 and 6</xsl:text>
			</xsl:message>
		</xsl:if>
	<!--																	/-->

	<!-- COMPUTED VALUES 													 -->
		<xsl:variable name="computed-element">
			<xsl:text>h</xsl:text>
			<xsl:value-of select="$level" />
		</xsl:variable>
	<!--																	/-->

	<!-- STRUCTURE															 -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="$computed-element" />
			<xsl:with-param name="is-optional" select="$is-optional" />
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="attr-mode" select="$attr-mode" />
			<xsl:with-param name="lg" select="$url-language" />
			<xsl:with-param name="content" select="$content" />
		</xsl:call-template>
	<!--																	/-->
	</xsl:template>

<!-- CORE-ELEMENT: optional-heading =============================================================-->
	<xsl:template name="optional-heading">
		<xsl:param name="level" select="'1'"/>
		<!-- attr params -->
		<xsl:param name="attr" />
		<xsl:param name="attr-mode" select="''" />
		<!-- content params -->
		<xsl:param name="lg" select="$url-language" />
		<xsl:param name="content" />

	<!-- STRUCTURE															 -->
		<xsl:call-template name="heading">
			<xsl:with-param name="level" select="$level" />
			<xsl:with-param name="is-optional" select="true()" />
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="attr-mode" select="$attr-mode" />
			<xsl:with-param name="lg" select="$lg" />
			<xsl:with-param name="content" select="$content" />
		</xsl:call-template>
	<!--																	/-->
	</xsl:template>
</xsl:stylesheet>

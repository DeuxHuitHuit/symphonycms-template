<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!-- CORE : button ==============================================================================-->
	<xsl:template name="button">
		<xsl:param name="content" />
		<xsl:param name="url" select="''" />
		<xsl:param name="failover-element" select="'button'" />
		<xsl:param name="attr" />

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
			<xsl:with-param name="attr" select="$computed-attr"/>
			<xsl:with-param name="content" select="$content" />
		</xsl:call-template>
	<!--																	/-->
	</xsl:template>

<!-- CORE : optional-button ======================================================================-->
	<xsl:template name="optional-button">
		<xsl:param name="content" />
		<xsl:param name="url" select="''" />
		<xsl:param name="failover-element" select="'button'" />
		<xsl:param name="attr" />

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
			<add dev-core="optional-button" />
		</xsl:variable>
	<!--																	/-->

	<!-- STRUCTURE															 -->
		<xsl:call-template name="optional-element">
			<xsl:with-param name="element" select="$computed-element"/>
			<xsl:with-param name="attr" select="$computed-attr"/>
			<xsl:with-param name="content" select="$content" />
		</xsl:call-template>
	<!--																	/-->
	</xsl:template>

<!-- CORE : button-tel ==========================================================================-->
	<xsl:template name="button-tel">
		<xsl:param name="tel" />
		<xsl:param name="content" select="$tel"/>
		<xsl:param name="failover-element" select="'a'" />
		<xsl:param name="attr" />

	<!-- COMPUTED VALUES 													 -->
		<xsl:variable name="phone-number">
			<xsl:if test="starts-with($tel, '+1') = false()">
				<xsl:text>+1</xsl:text>
			</xsl:if>
			<xsl:value-of select="translate($tel, ' -().', '')" />
		</xsl:variable>
	<!--																	/-->

	<!-- STRUCTURE															 -->
		<xsl:call-template name="button">
			<xsl:with-param name="content" select="$content" />
			<xsl:with-param name="url" select="concat('tel:', $phone-number)" />
			<xsl:with-param name="failover-element" select="$failover-element" />
			<xsl:with-param name="attr" select="$attr" />
		</xsl:call-template>
	<!--																	/-->
	</xsl:template>

</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="site-title">
		<xsl:param name="title" />
		<xsl:param name="config-title" select="$config/title" />
		<xsl:param name="params-title" select="$params/website-name" />
		<xsl:call-template name="site-title-default">
			<xsl:with-param name="title" select="$title" />
			<xsl:with-param name="config-title" select="$config/title" />
			<xsl:with-param name="params-title" select="$params/website-name" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="site-title-default">
		<xsl:param name="title" />
		<xsl:param name="config-title" select="$config/title" />
		<xsl:param name="params-title" select="$params/website-name" />
		<xsl:choose>
			<xsl:when test="string-length($title) != 0">
				<xsl:value-of select="$title" />
			</xsl:when>
			<xsl:when test="string-length($config-title) != 0">
				<xsl:value-of select="$config-title"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$params-title" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>

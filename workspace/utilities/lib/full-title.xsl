<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="full-title">
		<xsl:param name="lg" />
		<xsl:call-template name="full-title-default" />
	</xsl:template>

	<xsl:template name="full-title-default">
		<xsl:param name="lg" />
		<xsl:choose>
			<xsl:when test="count($params/page-type/item[@handle = 'index']) != 0">
				<xsl:value-of select="$site-title" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="page-title">
					<xsl:with-param name="lg" select="$lg"/>
				</xsl:call-template>
				<xsl:if test="$append-site-title">
					<xsl:value-of select="$append-site-title-char" />
				</xsl:if>
				<xsl:call-template name="site-title" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>

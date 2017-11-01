<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Override in the page to change page-title -->
	<xsl:template name="page-title">
		<xsl:param name="lg" select="$url-language" />

		<xsl:call-template name="default-page-title" >
			<xsl:with-param name="lg" select="$lg" />
		</xsl:call-template>
	</xsl:template>

<!-- Override in the page to use detail-entry page-title -->
	<xsl:variable name="page-meta-entry" />

<!-- Default page title algo -->
	<xsl:template name="default-page-title">
		<xsl:param name="lg" select="$url-language" />
		<xsl:param name="entry" select="$page-meta-entry"/>
		<xsl:param name="custom" >
			<xsl:if test="exslt:object-type($entry) = 'node-set'">
				<xsl:call-template name="default-value">
					<xsl:with-param name="lg" select="$lg"/>
					<xsl:with-param name="a" select="$entry/meta-titre" />
					<xsl:with-param name="b" select="$entry/meta-title" />
					<xsl:with-param name="c" select="$entry/titre" />
					<xsl:with-param name="d" select="$entry/title" />
					<xsl:with-param name="e" select="$entry/nom" />
					<xsl:with-param name="f" select="$entry/name" />
				</xsl:call-template>
			</xsl:if>
		</xsl:param>

		<xsl:variable name="plh-page-title" select="/data/plh-page//page [@handle=$current-page]/item [@lang=$lg]" />

		<xsl:choose>
			<xsl:when test="string-length($custom) != 0">
				<xsl:value-of select="$custom" />
			</xsl:when>
			<xsl:when test="string-length($page-metas/titre) != 0">
				<xsl:value-of select="$page-metas/titre" />
			</xsl:when>
			<xsl:when test="string-length($plh-page-title) != 0">
				<xsl:value-of select="$plh-page-title" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$page-title" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="../utilities/master/master.xsl" />

	<xsl:variable name="index" select="$data/pages-index/entry[1]" />
	<xsl:variable name="page" select="$data/pages-detail/entry[1]" />

	<xsl:template match="data">
		<xsl:choose>
			<xsl:when test="$page">
				<xsl:apply-templates select="$page" mode="layout-base" />
			</xsl:when>
			<xsl:when test="$index">
				<xsl:apply-templates select="$index" mode="layout-base" />
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!-- Page Title -->
	<xsl:template name="page-title">
		<xsl:param name="title">
			<xsl:choose>
				<xsl:when test="string-length($page/title) != 0">
					<xsl:value-of select="$page/title" />
				</xsl:when>
			</xsl:choose>
		</xsl:param>
		<xsl:call-template name="page-title-default">
			<xsl:with-param name="title" select="$title" />
		</xsl:call-template>
	</xsl:template>

	<!-- Page Description -->
	<xsl:template name="page-description">
		<xsl:param name="description">
			<xsl:choose>
				<xsl:when test="string-length($page/share-description) != 0">
					<xsl:value-of select="$page/share-description" />
				</xsl:when>
			</xsl:choose>
		</xsl:param>
		<xsl:value-of select="$description" />
	</xsl:template>

	<!-- Page Image -->
	<xsl:template name="meta-share">
		<xsl:param name="image">
			<xsl:choose>
				<xsl:when test="string-length($page/share-image) != 0">
					<xsl:copy-of select="$page/share-image" />
				</xsl:when>
			</xsl:choose>
		</xsl:param>
		<xsl:call-template name="meta-share-default">
			<xsl:with-param name="image" select="$image" />
		</xsl:call-template>
	</xsl:template>

	<!-- Alt Lang Url Extra -->
	<xsl:template name="alt-link-url-extra">
		<xsl:param name="lg" />
		<xsl:if test="string-length($params/handle) != 0">
			<xsl:value-of select="$page/slug/item[@lang = $lg]/@handle" />
			<xsl:text>/</xsl:text>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
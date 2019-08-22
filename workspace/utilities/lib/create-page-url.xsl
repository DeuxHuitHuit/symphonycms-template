<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="create-page-url">
		<xsl:param name="page" />
		<xsl:param name="lg" select="$url-language" />
		<xsl:call-template name="create-page-url-by-id">
			<xsl:with-param name="id" select="$page/page/@id" />
			<xsl:with-param name="lg" select="$lg" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="create-page-url-by-id">
		<xsl:param name="id" select="$current-page-id" />
		<xsl:param name="lg" select="$url-language" />
		<xsl:apply-templates select="/data/navigation//page [@id = $id]" mode="url">
			<xsl:with-param name="lg" select="$lg" />
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="page" mode="url">
		<xsl:param name="url" />
		<xsl:param name="lg" select="$url-language" />
		<xsl:choose>
			<xsl:when test="count(./parent::page) &gt; 0">
				<xsl:apply-templates select="./parent::page" mode="url">
					<xsl:with-param name="lg" select="$lg" />
					<xsl:with-param name="url">
						<xsl:choose>
							<xsl:when test="$is-multilingual">
								<xsl:value-of select="item [@lang = $lg]/@handle" />/<xsl:value-of select="$url" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="@handle" />/<xsl:value-of select="$url" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$is-multilingual">
						<xsl:text>/</xsl:text><xsl:value-of select="$lg" />
						<xsl:text>/</xsl:text>
						<xsl:if test="count(types/type [. = 'index']) = 0">
							<xsl:value-of select="item [@lang = $lg]/@handle" />
							<xsl:text>/</xsl:text>
						</xsl:if>
						<xsl:value-of select="$url" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>/</xsl:text>
						<xsl:if test="count(types/type [. = 'index']) = 0">
							<xsl:value-of select="@handle" />
							<xsl:text>/</xsl:text>
						</xsl:if>
						<xsl:value-of select="$url" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="create-page-handle-by-id">
		<xsl:param name="id" />
		<xsl:apply-templates select="/data/navigation//page [@id = $id]" mode="full-page-handle-creator" />
	</xsl:template>

	<xsl:template match="page" mode="full-page-handle-creator">
		<xsl:for-each select="./ancestor::page">
			<xsl:value-of select="@handle" />
			<xsl:text>-</xsl:text>
		</xsl:for-each>
		<xsl:value-of select="@handle" />
	</xsl:template>
</xsl:stylesheet>

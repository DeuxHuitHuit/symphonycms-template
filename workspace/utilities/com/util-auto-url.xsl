<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:func="http://exslt.org/functions"
	xmlns:util="https://github.com/DeuxHuitHuit/288-utils"
	extension-element-prefixes="func util">

	<!-- FUNCTION: util:auto-url -->
	<func:function name="util:auto-url">
		<xsl:param name="context" select="." />
		<func:result>
			<xsl:apply-templates select="$context" mode="util-auto-url" />
		</func:result>
	</func:function>

	<!-- util-auto-url -->
	<xsl:template name="util-auto-url" match="*" mode="util-auto-url">
		<xsl:choose>
			<xsl:when test="string-length(url) != 0">
				<xsl:value-of select="url" />
			</xsl:when>

			<!-- Symphony Pages -->
			<xsl:when test="string-length(page/page) != 0">
				<xsl:call-template name="create-page-url-by-id">
					<xsl:with-param name="id" select="page/page/@id"/>
				</xsl:call-template>
			</xsl:when>

			<!-- Pages -->
			<xsl:when test="@section = 'pages' or ../section/@handle = 'pages'">
				<xsl:value-of select="$page-index-url" />
				<xsl:value-of select="slug/@handle" />
				<xsl:text>/</xsl:text>
			</xsl:when>

			<!-- Files -->
			<xsl:when test="item[@section = 'files'] or ../section/@handle = 'files'">
				<xsl:value-of select="$workspace" />
				<xsl:value-of select="files/@path" />
				<xsl:text>/</xsl:text>
				<xsl:value-of select="files/filename" />
			</xsl:when>

			<xsl:when test="count(entry/item)">
				<xsl:apply-templates select="entry/item" mode="util-auto-url" />
			</xsl:when>

		</xsl:choose>

		<xsl:if test="string-length(url-extra) != 0">
			<xsl:value-of select="url-extra" />
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>

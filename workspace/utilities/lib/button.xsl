<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!-- Main template -->
<xsl:template name="button">
	<xsl:param name="text" />
	<xsl:param name="url" select="''" />
	<xsl:param name="class" select="''" />
	<xsl:param name="action" select="''" />
	
	<xsl:variable name="node-type">
		<xsl:choose>
			<xsl:when test="string-length($url) != 0">
				<xsl:text>a</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>button</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:element name="{$node-type}">
		<xsl:if test="string-length($class) != 0">
			<xsl:attribute name="class">
				<xsl:value-of select="$class" />
			</xsl:attribute>
		</xsl:if>
		
		<xsl:if test="string-length($url) != 0">
			<xsl:attribute name="href">
				<xsl:value-of select="$url" />
			</xsl:attribute>
		</xsl:if>
		
		<xsl:if test="string-length($action) != 0">
			<xsl:attribute name="data-action">
				<xsl:value-of select="$action" />
			</xsl:attribute>
		</xsl:if>
		
		<xsl:copy-of select="$text" />
		
	</xsl:element>
</xsl:template>

</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:exslt="http://exslt.org/common"
 exclude-result-prefixes="exslt"
>

<!-- Main template -->
<xsl:template name="button">
	<xsl:param name="text" />
	<xsl:param name="url" select="''" />
	<xsl:param name="class" select="''" />
	<xsl:param name="action" select="''" />
	<xsl:param name="type" select="''" />
	<xsl:param name="failover-element" select="'button'" />
	
	<xsl:variable name="node-type">
		<xsl:choose>
			<xsl:when test="string-length($url) != 0">
				<xsl:text>a</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$failover-element" />
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
		
		<xsl:if test="string-length($type) != 0">
			<xsl:attribute name="type">
				<xsl:value-of select="$type" />
			</xsl:attribute>
		</xsl:if>
		
		<xsl:choose>
			<xsl:when test="exslt:object-type($text) = 'string'">
				<xsl:value-of select="$text" />
			</xsl:when>
			<xsl:when test="exslt:object-type($text) = 'RTF'">
				<xsl:copy-of select="$text" disable-output-escaping="yes"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="$text/*" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:element>
</xsl:template>


</xsl:stylesheet>
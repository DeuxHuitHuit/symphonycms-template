<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exslt="http://exslt.org/common"
	exclude-result-prefixes="exslt" >

<!-- Main template -->
<xsl:template name="button">
	<xsl:param name="content" />
	<xsl:param name="url" select="''" />
	<xsl:param name="failover-element" select="'button'" />
	<xsl:param name="attr" />

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
	
	<xsl:variable name="dynamic-attr">
		<xsl:if test="string-length($url) != 0">
			<set href="{$url}" />
		</xsl:if>
	</xsl:variable>

	<xsl:element name="{$node-type}">
		<xsl:call-template name="attr">
			<xsl:with-param name="attr">
				<xsl:copy-of select="$dynamic-attr" />
				<xsl:copy-of select="$attr" />
			</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="content">
			<xsl:with-param name="content" select="$content" />
		</xsl:call-template>
		
	</xsl:element>
</xsl:template>

<xsl:template name="button-tel">
	<xsl:param name="tel" />
	<xsl:param name="failover-element" select="'a'" />
	<xsl:param name="attr" />
	
	<xsl:call-template name="button">
		<xsl:with-param name="content" select="$tel" />
		<xsl:with-param name="url" select="concat('tel:+1-', translate($tel, ' ()', '-'))" />
		<xsl:with-param name="failover-element" select="$failover-element" />
		<xsl:with-param name="attr" select="$attr" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
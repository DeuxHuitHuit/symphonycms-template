<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:exslt="http://exslt.org/common"
 exclude-result-prefixes="exslt"
>

<!-- Main template -->
<xsl:template name="button">
	<xsl:param name="content" />
	<xsl:param name="url" select="''" />
	<xsl:param name="class" select="''" />
	<xsl:param name="action" select="''" />
	<xsl:param name="ga-value" select="''" />
	<xsl:param name="ga-cat" select="''" />
	<xsl:param name="type" select="''" />
	<xsl:param name="target" select="''" />
	<xsl:param name="failover-element" select="'button'" />
	<xsl:param name="extra-key" select="''" />
	
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
				<xsl:text>button </xsl:text>
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
		
		<xsl:if test="string-length($ga-value) != 0">
			<xsl:attribute name="data-ga-value">
				<xsl:value-of select="$ga-value" />
			</xsl:attribute>
		</xsl:if>
		
		<xsl:if test="string-length($ga-cat) != 0">
			<xsl:attribute name="data-ga-cat">
				<xsl:value-of select="$ga-cat" />
			</xsl:attribute>
		</xsl:if>
		
		<xsl:if test="string-length($type) != 0">
			<xsl:attribute name="type">
				<xsl:value-of select="$type" />
			</xsl:attribute>
		</xsl:if>
		
		<xsl:if test="string-length($target) != 0">
			<xsl:attribute name="target">
				<xsl:value-of select="$target" />
			</xsl:attribute>
		</xsl:if>
		
		<xsl:if test="string-length($extra-key) != 0">
			<xsl:call-template name="btn-attributes" mode="{$extra-key}">
				<xsl:with-param name="extra-key" select="$extra-key" />
			</xsl:call-template>
		</xsl:if>
		
		<xsl:call-template name="content">
			<xsl:with-param name="content" select="$content" />
		</xsl:call-template>
		
	</xsl:element>
</xsl:template>

<xsl:template name="button-tel">
	<xsl:param name="tel" />
	<xsl:param name="class" select="''" />
	<xsl:param name="action" select="''" />
	<xsl:param name="ga-value" select="''" />
	<xsl:param name="ga-cat" select="''" />
	<xsl:param name="type" select="''" />
	<xsl:param name="failover-element" select="'a'" />
	<xsl:param name="extra-key" select="''" />
	
	<xsl:call-template name="button">
		<xsl:with-param name="text" select="$tel" />
		<xsl:with-param name="url" select="concat('tel:+1-', translate($tel, ' ()', '-'))" />
		<xsl:with-param name="class" select="$class" />
		<xsl:with-param name="action" select="$action" />
		<xsl:with-param name="ga-value" select="$ga-value" />
		<xsl:with-param name="ga-cat" select="$ga-cat" />
		<xsl:with-param name="type" select="$type" />
		<xsl:with-param name="failover-element" select="$failover-element" />
		<xsl:with-param name="extra-key" select="$extra-key" />
	</xsl:call-template>
</xsl:template>


</xsl:stylesheet>

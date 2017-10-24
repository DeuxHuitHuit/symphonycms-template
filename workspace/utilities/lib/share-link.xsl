<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://exslt.org/strings"
	exclude-result-prefixes="str"
	>

	<xsl:template name="share-link">
		<xsl:param name="attr" />
		<xsl:param name="url" />
		<xsl:param name="content" />

		<xsl:variable name="computed-attr">
			<set target="_blank" />
			<set rel="noopener" />
			<xsl:copy-of select="$attr" />
			<add dev-core="share-link" />
		</xsl:variable>

		<xsl:call-template name="optional-button">
			<xsl:with-param name="attr" select="$computed-attr" />
			<xsl:with-param name="failover-element" select="'a'"/>
			<xsl:with-param name="url" select="$url"/>
			<xsl:with-param name="content" select="$content" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="share-link-email">
		<xsl:param name="attr" />
		<xsl:param name="content" />
		<xsl:param name="status" />
		<xsl:param name="separator" select="' - '" />
		<xsl:param name="url" />

		<xsl:variable name="computed-url">
			<xsl:choose>
				<xsl:when test="string-length($status) != 0">
					<xsl:value-of select="str:encode-uri(concat('?subject=', $status, '&amp;body=', $url), false())" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="str:encode-uri(concat('?body=', $url), false())" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="computed-attr">
			<xsl:copy-of select="$attr" />
			<add data-mailto="{$computed-url}" />
			<rem target="_blank" />
		</xsl:variable>

		<xsl:call-template name="share-link">
			<xsl:with-param name="attr" select="$computed-attr" />
			<xsl:with-param name="content" select="$content"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="share-link-twitter">
		<xsl:param name="attr" />
		<xsl:param name="content" />
		<xsl:param name="status" />
		<xsl:param name="separator" select="' - '" />
		<xsl:param name="url" />

		<xsl:variable name="computed-status">
			<xsl:value-of select="$status" />
			<xsl:choose>
				<xsl:when test="string-length($status) != 0 and string-length($url) != 0">
					<xsl:value-of select="$separator" />
				</xsl:when>
				<otherwise>
					<xsl:text> </xsl:text>
				</otherwise>
			</xsl:choose>
			<xsl:value-of select="$url" />
		</xsl:variable>

		<xsl:call-template name="share-link">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="url" select="concat('https://twitter.com/home?status=', $computed-status)" />
			<xsl:with-param name="content" select="$content"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="share-link-facebook">
		<xsl:param name="attr" />
		<xsl:param name="content" />
		<xsl:param name="url" />

		<xsl:call-template name="share-link">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="url" select="concat('https://www.facebook.com/sharer/sharer.php?u=', $url)" />
			<xsl:with-param name="content" select="$content"/>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="share-link-linkedIn">
		<xsl:param name="attr" />
		<xsl:param name="content" />
		<xsl:param name="status" />
		<xsl:param name="separator" select="' - '" />
		<xsl:param name="url" />

		<xsl:variable name="computed-status">
			<xsl:value-of select="$status" />
			<xsl:choose>
				<xsl:when test="string-length($status) != 0 and string-length($url) != 0">
					<xsl:value-of select="$separator" />
				</xsl:when>
				<otherwise>
					<xsl:text> </xsl:text>
				</otherwise>
			</xsl:choose>
			<xsl:value-of select="$url" />
		</xsl:variable>

		<xsl:call-template name="share-link">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="url" select="concat('https://www.linkedin.com/shareArticle?mini=true&amp;url=', $url, '&amp;title=', $computed-status)" />
			<xsl:with-param name="content" select="$content"/>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
